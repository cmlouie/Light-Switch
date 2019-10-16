//
//  TitleView.swift
//  Light Switch
//
//  Created by Christopher Louie on 2019-10-16.
//  Copyright © 2019 Christopher Louie. All rights reserved.
//

import UIKit

class DescriptionView: UIView {

    var toggleAction: (() -> Void)?
    
    var lightState: LightState? {
        didSet {
            toggleAction?()
        }
    }

    lazy var titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.text = "Lamp"
        titleLabel.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        titleLabel.textColor = .black
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        return titleLabel
    }()
    
    lazy var descriptionLabel: UILabel = {
        let descriptionLabel = UILabel()
        descriptionLabel.text = "Powered Off"
        descriptionLabel.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        descriptionLabel.textColor = Constants.descriptionTextColor
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        return descriptionLabel
    }()
    
    lazy var image: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: Constants.imageNameOff)
        image.contentMode = .scaleAspectFit
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    lazy var creditLabel: UILabel = {
        let descriptionLabel = UILabel()
        descriptionLabel.text = "Inspired by Apple Home App, recreated by Christopher Louie. \n For demo purposes only – created on Oct 15, 2019."
        descriptionLabel.numberOfLines = 0
        descriptionLabel.textAlignment = .center
        descriptionLabel.font = UIFont.systemFont(ofSize: 10, weight: .light)
        descriptionLabel.textColor = Constants.handleColorOff
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        return descriptionLabel
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        backgroundColor = .clear
        addSubview(titleLabel)
        addSubview(descriptionLabel)
        addSubview(image)
        addSubview(creditLabel)
        setupLayout()
    }
    
    private func setupLayout() {
        NSLayoutConstraint.activate([
            image.topAnchor.constraint(equalTo: topAnchor, constant: Constants.topTextSpacing),
            image.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constants.leadingImageSpacing),
            image.heightAnchor.constraint(equalToConstant: Constants.imageHeight),
            
            titleLabel.topAnchor.constraint(equalTo: image.topAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: image.trailingAnchor, constant: Constants.imageTextSpacing),
            
            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: Constants.titleDescriptionSpacing),
            descriptionLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            
            creditLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            creditLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -Constants.topTextSpacing)
        ])
    }
    
    override class var requiresConstraintBasedLayout: Bool {
        return true
    }

}
