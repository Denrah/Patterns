//
//  PrototypeViewController.swift
//  Patterns
//
//  Created by National Team on 28.10.2021.
//

import UIKit

protocol Prototype: UIView {
  func clone() -> Prototype
}

class InfoCardView: UIView, Prototype {
  private let titleLabel = UILabel()
  private let subtitleLabel = UILabel()
  
  private let name: String
  private let age: Int
  
  init(name: String, age: Int) {
    self.name = name
    self.age = age
    super.init(frame: .zero)
    setup()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  private func setup() {
    backgroundColor = .systemGray
    layer.cornerRadius = 8
    
    addSubview(titleLabel)
    titleLabel.font = .preferredFont(forTextStyle: .title3)
    titleLabel.text = name
    titleLabel.snp.makeConstraints { make in
      make.top.leading.trailing.equalToSuperview().inset(16)
    }
    
    addSubview(subtitleLabel)
    subtitleLabel.font = .preferredFont(forTextStyle: .body)
    subtitleLabel.text = "Age: \(age)"
    subtitleLabel.snp.makeConstraints { make in
      make.top.equalTo(titleLabel.snp.bottom).offset(8)
      make.leading.trailing.bottom.equalToSuperview().inset(16)
    }
  }
  
  func clone() -> Prototype {
    InfoCardView(name: name, age: age)
  }
}

class PrototypeViewController: UIViewController {
  
  private let button = UIButton()
  private let stackView = UIStackView()
  
  private let cardView = InfoCardView(name: "Jhon Doe", age: 23)
  
  override func viewDidLoad() {
    super.viewDidLoad()
    view.addSubview(button)
    button.setTitleColor(.systemBlue, for: .normal)
    button.setTitle("Add card", for: .normal)
    button.addTarget(self, action: #selector(clone), for: .touchUpInside)
    button.snp.makeConstraints { make in
      make.top.leading.trailing.equalTo(view.safeAreaLayoutGuide)
    }
    
    view.addSubview(stackView)
    stackView.axis = .vertical
    stackView.spacing = 16
    stackView.snp.makeConstraints { make in
      make.top.equalTo(button.snp.bottom)
      make.leading.trailing.equalToSuperview().inset(16)
    }
    
    stackView.addArrangedSubview(cardView)
    
    // Do any additional setup after loading the view.
  }
  
  @objc private func clone() {
    let newCardView = cardView.clone()
    stackView.addArrangedSubview(newCardView)
  }
}
