//
//  SwitchView.swift
//  Light Switch
//
//  Created by Christopher Louie on 2019-10-15.
//  Copyright © 2019 Christopher Louie. All rights reserved.
//

import UIKit

class SwitchBackgroundView: UIView {
    
    lazy var switchBackground: UIView = {
        let switchBackground = UIView()
        switchBackground.layer.cornerRadius = 34
        switchBackground.backgroundColor = Constants.switchBackgroundColor
        switchBackground.translatesAutoresizingMaskIntoConstraints = false
        return switchBackground
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
        addSubview(switchBackground)
        setupLayout()
    }
    
    private func setupLayout() {
        NSLayoutConstraint.activate([
            switchBackground.centerXAnchor.constraint(equalTo: centerXAnchor),
            switchBackground.centerYAnchor.constraint(equalTo: centerYAnchor),
            switchBackground.widthAnchor.constraint(equalToConstant: Constants.switchBackgroundWidth),
            switchBackground.heightAnchor.constraint(equalToConstant: Constants.switchBackgroundHeight)
        ])
    }
    
    override class var requiresConstraintBasedLayout: Bool {
        return true
    }
    
}
