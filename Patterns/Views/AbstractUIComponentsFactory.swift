//
//  AbstractUIComponentsFactory.swift
//  Patterns
//

import UIKit

protocol ProfileCardProtocol: UIView {
  func update(name: String?, age: Int?)
}

protocol OptionsListProtocol: UIView {
  func addOptions(_ options: [String])
}

protocol AbstractUIComponentsFactory {
  func createProfileCard() -> ProfileCardProtocol
  func createOptionsList() -> OptionsListProtocol
}

class PhoneUIComponentsFactory: AbstractUIComponentsFactory {
  func createProfileCard() -> ProfileCardProtocol {
    return ProfileCardPhoneView()
  }
  
  func createOptionsList() -> OptionsListProtocol {
    return OptionsListPhoneView()
  }
}

class TabletUIComponentsFactory: AbstractUIComponentsFactory {
  func createProfileCard() -> ProfileCardProtocol {
    return ProfileCardTabletView()
  }
  
  func createOptionsList() -> OptionsListProtocol {
    return OptionsListTabletView()
  }
}
