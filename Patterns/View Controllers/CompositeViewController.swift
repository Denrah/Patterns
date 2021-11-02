//
//  CompositeViewController.swift
//  Patterns
//

import UIKit

protocol CatalogueItem {
  var title: String? { get }
}

struct Category: CatalogueItem {
  let title: String?
  var children: [CatalogueItem] = []
  
  mutating func add(child: CatalogueItem) {
    children.append(child)
  }
}

struct Product: CatalogueItem {
  let title: String?
}

class CompositeViewController: UIViewController {
  
  private let stackView = UIStackView()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    view.addSubview(stackView)
    stackView.axis = .vertical
    stackView.spacing = 4
    stackView.alignment = .leading
    stackView.snp.makeConstraints { make in
      make.top.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(16)
    }
    
    
    
    var phones = Category(title: "Телефоны")
    var apple = Category(title: "Apple")
    var samsung = Category(title: "Samsung")
    apple.add(child: Product(title: "iPhone 13"))
    apple.add(child: Product(title: "iPhone 12"))
    samsung.add(child: Product(title: "Galaxy Z Fold"))
    samsung.add(child: Product(title: "Galaxy Z Flip"))
    phones.add(child: apple)
    phones.add(child: samsung)
    
    var cases = Category(title: "Чехлы")
    cases.add(child: Product(title: "Smart folio"))
    cases.add(child: Product(title: "Nilkkin"))
    
    let new = Product(title: "Новинки")
    
    let catalogue: [CatalogueItem] = [phones, cases, new]
    
    makeList(items: catalogue, level: 0)
    
    
    // Do any additional setup after loading the view.
  }
  
  func makeList(items: [CatalogueItem], level: Int) {
    items.forEach { item in
      let label = UILabel()
      
      if item is Category {
        label.text = (item.title ?? "") + " >"
      } else {
        label.text = item.title
      }
      
      stackView.addArrangedSubview(label)
      label.snp.makeConstraints { make in
        make.leading.equalToSuperview().inset(16 * level)
      }
      
      if let category = item as? Category, !category.children.isEmpty {
        makeList(items: category.children, level: level + 1)
      }
    }
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
