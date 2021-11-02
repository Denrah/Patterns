//
//  ProfileCardPhoneView.swift
//  Patterns
//

import UIKit
import SnapKit

class ProfileCardPhoneView: UIView, ProfileCardProtocol {
  private let avatarImageView = UIImageView()
  private let nameLabel = UILabel()
  private let ageLabel = UILabel()
  
  init() {
    super.init(frame: .zero)
    setup()
  }
  
  required init?(coder: NSCoder) {
    super.init(coder: coder)
    setup()
  }
  
  func update(name: String?, age: Int?) {
    nameLabel.text = name
    ageLabel.text = "\(age ?? 0) лет"
  }
  
  private func setup() {
    backgroundColor = .systemGray4
    layer.cornerRadius = 8
    
    addSubview(avatarImageView)
    avatarImageView.image = UIImage(named: "avatar")
    avatarImageView.contentMode = .scaleAspectFill
    avatarImageView.layer.cornerRadius = 32
    avatarImageView.clipsToBounds = true
    avatarImageView.snp.makeConstraints { make in
      make.size.equalTo(64)
      make.top.equalToSuperview().inset(16)
      make.centerX.equalToSuperview()
    }
    
    addSubview(nameLabel)
    nameLabel.font = .preferredFont(forTextStyle: .title3)
    nameLabel.textAlignment = .center
    nameLabel.snp.makeConstraints { make in
      make.top.equalTo(avatarImageView.snp.bottom).offset(16)
      make.leading.trailing.equalToSuperview().inset(16)
    }
    
    addSubview(ageLabel)
    ageLabel.font = .preferredFont(forTextStyle: .body)
    ageLabel.textAlignment = .center
    ageLabel.snp.makeConstraints { make in
      make.top.equalTo(nameLabel.snp.bottom).offset(8)
      make.leading.trailing.bottom.equalToSuperview().inset(16)
    }
  }
}
