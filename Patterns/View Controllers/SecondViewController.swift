//
//  SecondViewController.swift
//  Patterns
//
//  Created by National Team on 27.10.2021.
//

import UIKit

protocol BannerBuilder {
  func reset()
  func setLeftImage()
  func setTitle()
  func setSubtitle()
  func setBackgroundColor()
}

class SimpleBannerBuilder: BannerBuilder {
  private var banner = BannerView()
  
  func reset() {
    banner = BannerView()
  }
  
  func setLeftImage() {
    banner.leftImage = nil
  }
  
  func setTitle() {
    banner.title = "Hey, bro! You are awesome!"
    banner.titleFont = .systemFont(ofSize: 18)
    banner.titleColor = .white
  }
  
  func setSubtitle() {
    banner.subtitle = nil
  }
  
  func setBackgroundColor() {
    banner.backgroundColor = .blue
  }
  
  func getBanner() -> BannerView {
    return banner
  }
}

class SuccessBannerBuilder: BannerBuilder {
  private var banner = BannerView()
  
  func reset() {
    banner = BannerView()
  }
  
  func setLeftImage() {
    banner.leftImage = UIImage(systemName: "checkmark.circle.fill")?.withRenderingMode(.alwaysTemplate)
    banner.leftImageColor = .black
  }
  
  func setTitle() {
    banner.title = "Success"
    banner.titleFont = .boldSystemFont(ofSize: 18)
    banner.titleColor = .black
  }
  
  func setSubtitle() {
    banner.subtitle = "The work has been done"
    banner.subtitleFont = .systemFont(ofSize: 14)
    banner.subtitleColor = .black
  }
  
  func setBackgroundColor() {
    banner.backgroundColor = .systemGreen
  }
  
  func getBanner() -> BannerView {
    return banner
  }
}

class ErrorBannerBuilder: BannerBuilder {
  private var banner = BannerView()
  
  func reset() {
    banner = BannerView()
  }
  
  func setLeftImage() {
    banner.leftImage = UIImage(systemName: "multiply.circle.fill")?.withRenderingMode(.alwaysTemplate)
    banner.leftImageColor = .yellow
  }
  
  func setTitle() {
    banner.title = "Error"
    banner.titleFont = .boldSystemFont(ofSize: 24)
    banner.titleColor = .yellow
  }
  
  func setSubtitle() {
    banner.subtitle = "We failed to do this work!"
    banner.subtitleFont = .systemFont(ofSize: 18)
    banner.subtitleColor = .yellow
  }
  
  func setBackgroundColor() {
    banner.backgroundColor = .red
  }
  
  func getBanner() -> BannerView {
    return banner
  }
}

class BannersDirector {
  func makeBanner(builder: BannerBuilder) {
    builder.reset()
    builder.setLeftImage()
    builder.setTitle()
    builder.setSubtitle()
    builder.setBackgroundColor()
  }
}

class BannerView: UIView {
  var leftImage: UIImage? {
    didSet {
      leftImageView.image = leftImage
      leftImageView.isHidden = leftImage == nil
    }
  }
  
  var leftImageColor: UIColor? {
    didSet {
      leftImageView.tintColor = leftImageColor ?? .white
    }
  }
  
  var title: String? {
    didSet {
      titleLabel.text = title
      titleLabel.isHidden = title == nil
    }
  }
  
  var titleFont: UIFont? {
    didSet {
      titleLabel.font = titleFont
    }
  }
  
  var titleColor: UIColor = .white {
    didSet {
      titleLabel.textColor = titleColor
    }
  }
  
  var subtitle: String? {
    didSet {
      subtitleLabel.text = subtitle
      subtitleLabel.isHidden = subtitle == nil
    }
  }
  
  var subtitleFont: UIFont? {
    didSet {
      subtitleLabel.font = subtitleFont
    }
  }
  
  var subtitleColor: UIColor = .white {
    didSet {
      subtitleLabel.textColor = subtitleColor
    }
  }
  
  private let horizontalStackView = UIStackView()
  private let verticalStackView = UIStackView()
  private let leftImageView = UIImageView()
  private let titleLabel = UILabel()
  private let subtitleLabel = UILabel()
  
  init() {
    super.init(frame: .zero)
    setup()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  private func setup() {
    layer.cornerRadius = 8
    
    addSubview(horizontalStackView)
    horizontalStackView.spacing = 16
    horizontalStackView.snp.makeConstraints { make in
      make.edges.equalToSuperview().inset(16)
    }
    
    horizontalStackView.addArrangedSubview(leftImageView)
    leftImageView.contentMode = .scaleAspectFit
    leftImageView.snp.makeConstraints { make in
      make.size.equalTo(32)
    }
    
    horizontalStackView.addArrangedSubview(verticalStackView)
    verticalStackView.spacing = 4
    verticalStackView.addArrangedSubview(titleLabel)
    verticalStackView.addArrangedSubview(subtitleLabel)
    verticalStackView.axis = .vertical
    titleLabel.numberOfLines = 0
    subtitleLabel.numberOfLines = 0
    
    leftImageView.isHidden = true
    titleLabel.isHidden = true
    subtitleLabel.isHidden = true
    
    titleLabel.textColor = .white
    subtitleLabel.textColor = .white
    
    horizontalStackView.alignment = .center
    titleLabel.setContentCompressionResistancePriority(.required, for: .vertical)
    subtitleLabel.setContentCompressionResistancePriority(.required, for: .vertical)
  }
}

class SecondViewController: UIViewController {
  
  private let director = BannersDirector()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    // Do any additional setup after loading the view.
    
    let stackView = UIStackView()
    stackView.axis = .vertical
    stackView.spacing = 8
    view.addSubview(stackView)
    stackView.snp.makeConstraints { make in
      make.leading.trailing.equalToSuperview().inset(16)
      make.centerY.equalToSuperview()
    }
    
    let simpleButton = UIButton()
    simpleButton.setTitle("Simple banner", for: .normal)
    simpleButton.setTitleColor(.systemBlue, for: .normal)
    simpleButton.addTarget(self, action: #selector(showSimpleBanner), for: .touchUpInside)
    stackView.addArrangedSubview(simpleButton)
    
    let successButton = UIButton()
    successButton.setTitle("Success banner", for: .normal)
    successButton.setTitleColor(.systemBlue, for: .normal)
    successButton.addTarget(self, action: #selector(showSuccessBanner), for: .touchUpInside)
    stackView.addArrangedSubview(successButton)
    
    let errorButton = UIButton()
    errorButton.setTitle("Error banner", for: .normal)
    errorButton.setTitleColor(.systemBlue, for: .normal)
    errorButton.addTarget(self, action: #selector(showErrorBanner), for: .touchUpInside)
    stackView.addArrangedSubview(errorButton)
    
    
  }
  
  @objc private func showSimpleBanner() {
    let builder = SimpleBannerBuilder()
    director.makeBanner(builder: builder)
    let bannerView = builder.getBanner()
    showBanner(bannerView: bannerView)
  }
  
  @objc private func showSuccessBanner() {
    let builder = SuccessBannerBuilder()
    director.makeBanner(builder: builder)
    let bannerView = builder.getBanner()
    showBanner(bannerView: bannerView)
  }
  
  @objc private func showErrorBanner() {
    let builder = ErrorBannerBuilder()
    director.makeBanner(builder: builder)
    let bannerView = builder.getBanner()
    showBanner(bannerView: bannerView)
  }
  
  private func showBanner(bannerView: BannerView) {
    view.addSubview(bannerView)
    bannerView.snp.makeConstraints { make in
      make.top.equalToSuperview().inset(88)
      make.leading.trailing.equalToSuperview().inset(16)
    }
    
    DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
      UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseIn) {
        bannerView.alpha = 0
      } completion: { _ in
        bannerView.removeFromSuperview()
      }

    }
  }
  
}
