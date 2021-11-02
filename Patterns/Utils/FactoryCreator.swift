//
//  FactoryCreator.swift
//  Patterns
//

import UIKit

struct FactoryCreator {
  static func createUIComponentsFactory() -> AbstractUIComponentsFactory {
    switch UIDevice.current.userInterfaceIdiom {
    case .phone:
      return PhoneUIComponentsFactory()
    case .pad:
      return TabletUIComponentsFactory()
    default:
      return PhoneUIComponentsFactory()
    }
  }
}
