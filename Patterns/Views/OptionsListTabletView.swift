//
//  OptionsListTabletView.swift
//  Patterns
//
//  Created by National Team on 25.10.2021.
//

import UIKit

class OptionsListTabletView: UIStackView, OptionsListProtocol {
  func addOptions(_ options: [String]) {
    axis = .horizontal
    spacing = 24
    distribution = .equalSpacing
    
    options.forEach { option in
      let label =  UILabel()
      label.font = .preferredFont(forTextStyle: .title2)
      label.text = option
      addArrangedSubview(label)
    }
  }
}
