//
//  OptionsListPhoneView.swift
//  Patterns
//
//  Created by National Team on 25.10.2021.
//

import UIKit

class OptionsListPhoneView: UIStackView, OptionsListProtocol {
  func addOptions(_ options: [String]) {
    axis = .vertical
    spacing = 16
    
    options.forEach { option in
      let label =  UILabel()
      label.font = .preferredFont(forTextStyle: .body)
      label.text = option
      addArrangedSubview(label)
    }
  }
}
