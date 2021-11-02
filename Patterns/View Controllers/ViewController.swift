//
//  ViewController.swift
//  Patterns
//
//  Created by National Team on 25.10.2021.
//

import UIKit

class ViewController: UIViewController {
  
  private let componentsFactory: AbstractUIComponentsFactory = FactoryCreator.createUIComponentsFactory()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view.
    
    Storage.shared.userName = "Alex Colter"
    Storage.shared.userAge = 18
    
    
    let profileCard = componentsFactory.createProfileCard()
    profileCard.update(name: Storage.shared.userName, age: Storage.shared.userAge)
    view.addSubview(profileCard)
    profileCard.snp.makeConstraints { make in
      make.top.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(16)
    }
    
    let optionsList = componentsFactory.createOptionsList()
    optionsList.addOptions(["Option 1", "Option 2", "Option 3"])
    view.addSubview(optionsList)
    optionsList.snp.makeConstraints { make in
      make.top.equalTo(profileCard.snp.bottom).offset(16)
      make.leading.trailing.equalToSuperview().inset(16)
    }
  }
}

