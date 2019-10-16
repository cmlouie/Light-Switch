//
//  SwitchHandleView.swift
//  Light Switch
//
//  Created by Christopher Louie on 2019-10-15.
//  Copyright © 2019 Christopher Louie. All rights reserved.
//

import UIKit

class SwitchHandleView: UIView {
    
    var toggleAction: (() -> Void)?
    
    var lightState: LightState? {
        didSet {
            toggleAction?()
        }
    }

    lazy var switchHandle: UIView = {
        let switchHandle = UIView()
        switchHandle.layer.cornerRadius = 25
        switchHandle.backgroundColor = Constants.handleColorOff
        switchHandle.translatesAutoresizingMaskIntoConstraints = false
        return switchHandle
    }()
    
    lazy var icon: UIImageView = {
        let icon = UIImageView()
        icon.image = UIImage(named: Constants.iconNameOff)
        icon.contentMode = .scaleAspectFit
        icon.translatesAutoresizingMaskIntoConstraints = false
        return icon
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
        addSubview(switchHandle)
        addSubview(icon)
        setupLayout()
    }
    
    private func setupLayout() {
        NSLayoutConstraint.activate([
            switchHandle.centerXAnchor.constraint(equalTo: centerXAnchor),
            switchHandle.centerYAnchor.constraint(equalTo: centerYAnchor),
            switchHandle.widthAnchor.constraint(equalToConstant: Constants.switchHandleWidth),
            switchHandle.heightAnchor.constraint(equalToConstant: Constants.switchHandleHeight),
            
            icon.centerXAnchor.constraint(equalTo: switchHandle.centerXAnchor),
            icon.centerYAnchor.constraint(equalTo: switchHandle.centerYAnchor),
            icon.heightAnchor.constraint(equalToConstant: 32.0)
        ])
    }
    
    override class var requiresConstraintBasedLayout: Bool {
        return true
    }
    
}
