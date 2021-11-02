//
//  Storage.swift
//  Patterns
//

import Foundation

class Storage {
  static let shared = Storage()
  
  var userName: String?
  var userAge: Int?
  
  private init() {}
}
