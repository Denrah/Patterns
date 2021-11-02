//
//  ProxyViewController.swift
//  Patterns
//

import UIKit

protocol SearchService {
  func search(text: String) -> String
}

class FakeSearchService: SearchService {
  func search(text: String) -> String {
    let value = Int.random(in: 1...100)
    print("Performed search for \(text)")
    return "Result for \"\(text)\" is \(value)"
  }
}

class SearchProxy: SearchService {
  private let searchService: SearchService = FakeSearchService()
  private var caches: [String: (date: Date, value: String)] = [:]
  
  func search(text: String) -> String {
    if let cache = caches[text], Date().timeIntervalSince1970 - cache.date.timeIntervalSince1970 < 30 {
      print("Returned cached value for \(text)")
      return cache.value
    } else {
      let value = searchService.search(text: text)
      caches[text] = (date: Date(), value: value)
      return value
    }
  }
}

class ProxyViewController: UIViewController {
  
  let textField = UITextField()
  let searchService: SearchService = SearchProxy()
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    
    view.addSubview(textField)
    textField.borderStyle = .roundedRect
    textField.snp.makeConstraints { make in
      make.top.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(16)
    }
    
    let button = UIButton()
    button.setTitle("Search", for: .normal)
    button.setTitleColor(.systemBlue, for: .normal)
    view.addSubview(button)
    button.snp.makeConstraints { make in
      make.top.equalTo(textField.snp.bottom).offset(16)
      make.leading.equalToSuperview().inset(16)
    }
    
    button.addTarget(self, action: #selector(search), for: .touchUpInside)
  }
  
  @objc private func search() {
    let result = searchService.search(text: textField.text ?? "")
    let alert = UIAlertController(title: "Result", message: result, preferredStyle: .alert)
    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
    present(alert, animated: true, completion: nil)
  }
}
