//
//  FacadeViewController.swift
//  Patterns
//
//  Created by Developer on 03.11.2021.
//

import UIKit
import CryptoKit

class AuthenticationFacade {
  private let jwtService = JWTService()

  func authenticateUser(uid: String, name: String) -> String? {
    return jwtService.generateJWT(payload: JWTService.Payload(uid: uid, name: name))
  }

  func isValid(token: String) -> Bool {
    jwtService.isValid(token: token)
  }
}

class JWTService {
  struct Header: Codable {
    let alg: String
    let typ: String

    static func defaultHeader() -> Header {
      return Header(alg: "HS256", typ: "JWT")
    }
  }

  struct Payload: Codable {
    let uid: String
    let name: String
  }

  private let privateKey: SymmetricKey

  init() {
    let secret = "KbPeSgVkYp3s6v9y$B&E)H@McQfTjWmZ"
    privateKey = SymmetricKey(data: secret.data(using: .utf8) ?? Data())
  }

  func encodeObjectToData<T: Codable>(_ object: T) throws -> Data {
    return try JSONEncoder().encode(object)
  }

  func convertDataToBase64(_ data: Data) -> String {
    return data.base64EncodedString()
  }

  func generateJWT(payload: Payload) -> String? {
    guard let headerData = try? encodeObjectToData(Header.defaultHeader()),
          let payloadData = try? encodeObjectToData(payload) else { return nil }
    let stringToSign = convertDataToBase64(headerData) + "." + convertDataToBase64(payloadData)
    guard let signature = sign(string: stringToSign) else { return nil }
    return stringToSign + "." + signature
  }

  func sign(string: String) -> String? {
    guard let data = string.data(using: .utf8) else { return nil }
    let signature = HMAC<SHA256>.authenticationCode(for: data, using: privateKey)
    return convertDataToBase64(Data(signature))
  }

  func isValid(token: String) -> Bool {
    let parts = token.split(separator: ".", omittingEmptySubsequences: true).map { String($0) }
    guard parts.count == 3 else { return false }
    let string = parts[0] + "." + parts[1]
    let stringSignature = sign(string: string)
    return stringSignature == parts[2]
  }
}

class FacadeViewController: UIViewController {
  private let uidTextField = UITextField()
  private let nameTextField = UITextField()
  private let authenticateButton = UIButton()
  private let tokenTextView = UITextView()
  private let tokenTextField = UITextField()
  private let checkTokenButton = UIButton()

  private let authentication = AuthenticationFacade()

  override func viewDidLoad() {
    super.viewDidLoad()

    view.addSubview(uidTextField)
    uidTextField.borderStyle = .roundedRect
    uidTextField.placeholder = "User ID"
    uidTextField.snp.makeConstraints { make in
      make.top.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(16)
    }

    view.addSubview(nameTextField)
    nameTextField.borderStyle = .roundedRect
    nameTextField.placeholder = "User name"
    nameTextField.snp.makeConstraints { make in
      make.top.equalTo(uidTextField.snp.bottom).offset(16)
      make.leading.trailing.equalToSuperview().inset(16)
    }

    view.addSubview(authenticateButton)
    authenticateButton.configuration = UIButton.Configuration.filled()
    authenticateButton.setTitle("Authenticate", for: .normal)
    authenticateButton.addTarget(self, action: #selector(didTapAuthenticate), for: .touchUpInside)
    authenticateButton.snp.makeConstraints { make in
      make.top.equalTo(nameTextField.snp.bottom).offset(16)
      make.leading.trailing.equalToSuperview().inset(16)
    }

    view.addSubview(tokenTextView)
    tokenTextView.isEditable = false
    tokenTextView.isScrollEnabled = false
    tokenTextView.snp.makeConstraints { make in
      make.top.equalTo(authenticateButton.snp.bottom).offset(16)
      make.leading.trailing.equalToSuperview().inset(16)
    }

    view.addSubview(tokenTextField)
    tokenTextField.borderStyle = .roundedRect
    tokenTextField.placeholder = "Token"
    tokenTextField.snp.makeConstraints { make in
      make.top.equalTo(tokenTextView.snp.bottom).offset(32)
      make.leading.trailing.equalToSuperview().inset(16)
    }

    view.addSubview(checkTokenButton)
    checkTokenButton.configuration = UIButton.Configuration.filled()
    checkTokenButton.setTitle("Validate", for: .normal)
    checkTokenButton.addTarget(self, action: #selector(didTapValidate), for: .touchUpInside)
    checkTokenButton.snp.makeConstraints { make in
      make.top.equalTo(tokenTextField.snp.bottom).offset(16)
      make.leading.trailing.equalToSuperview().inset(16)
    }
  }

  @objc private func didTapAuthenticate() {
    guard let uid = uidTextField.text, let name = nameTextField.text else { return }
    let token = authentication.authenticateUser(uid: uid, name: name)
    tokenTextView.text = token
    tokenTextField.text = token
  }

  @objc private func didTapValidate() {
    guard let token = tokenTextField.text else { return }
    let result = authentication.isValid(token: token) ? "Token is valid" : "Token is invalid"
    let alert = UIAlertController(title: result, message: nil, preferredStyle: .alert)
    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
    present(alert, animated: true)
  }


  /*
   // MARK: - Navigation

   // In a storyboard-based application, you will often want to do a little preparation before navigation
   override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
   // Get the new view controller using segue.destination.
   // Pass the selected object to the new view controller.
   }
   */

}
