//
//  ProfileCardTabletView.swift
//  Patterns
//

import UIKit

class ProfileCardTabletView: UIView, ProfileCardProtocol {
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
    let containerView = UIView()
    
    containerView.backgroundColor = .systemGray4
    containerView.layer.cornerRadius = 8
    
    addSubview(containerView)
    containerView.snp.makeConstraints { make in
      make.top.leading.bottom.equalToSuperview()
      make.trailing.lessThanOrEqualToSuperview()
    }
    
    containerView.addSubview(avatarImageView)
    avatarImageView.image = UIImage(named: "avatar")
    avatarImageView.contentMode = .scaleAspectFill
    avatarImageView.layer.cornerRadius = 64
    avatarImageView.clipsToBounds = true
    avatarImageView.snp.makeConstraints { make in
      make.size.equalTo(128)
      make.top.bottom.leading.equalToSuperview().inset(16)
    }
    
    let stackView = UIStackView()
    stackView.axis = .vertical
    stackView.spacing = 8
    containerView.addSubview(stackView)
    stackView.snp.makeConstraints { make in
      make.leading.equalTo(avatarImageView.snp.trailing).offset(24)
      make.trailing.equalToSuperview().inset(32)
      make.centerY.equalToSuperview()
    }
    
    stackView.addArrangedSubview(nameLabel)
    nameLabel.font = .preferredFont(forTextStyle: .title1)

    stackView.addArrangedSubview(ageLabel)
    ageLabel.font = .preferredFont(forTextStyle: .title3)

  }
}
