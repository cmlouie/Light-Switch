//
//  ViewController.swift
//  Light Switch
//
//  Created by Christopher Louie on 2019-10-15.
//  Copyright © 2019 Christopher Louie. All rights reserved.
//

import UIKit

enum LightState {
    case on
    case off
}

class ViewController: UIViewController {
    
    var switchBackgroundView: UIView?
    var switchHandleView: SwitchHandleView?
    var titleView: DescriptionView?
    var hapticsGenerator: UIImpactFeedbackGenerator?
    
    var lightState: LightState! {
        didSet {
            if oldValue != lightState {
                print(lightState!)
                
                // Play haptic
                hapticsGenerator?.impactOccurred()
                
                // Update light state in SwitchHandleView Class
                if lightState == .on {
                    switchHandleView?.lightState = .on
                    titleView?.lightState = .on
                } else {
                    switchHandleView?.lightState = .off
                    titleView?.lightState = .off
                }
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadViews()
        addPanGesture(view: switchHandleView!)
        addTapGesture(view: switchBackgroundView!)
        setupToggleAction()
        lightState = .off
        
        // Setup haptics
        hapticsGenerator = UIImpactFeedbackGenerator()
        hapticsGenerator?.prepare()
    }
    
    func loadViews() {
        titleView = DescriptionView(frame: self.view.frame)
        switchBackgroundView = SwitchBackgroundView(frame: CGRect(x: view.frame.midX - Constants.switchBackgroundWidth/2,
                                                                  y: Constants.switchBackgroundOffsetY,
                                                                  width: Constants.switchBackgroundWidth,
                                                                  height: Constants.switchBackgroundHeight))
        switchHandleView = SwitchHandleView(frame: CGRect(x: view.frame.midX - Constants.switchHandleWidth/2,
                                                          y: Constants.switchHandleOffsetY,
                                                          width: Constants.switchHandleWidth,
                                                          height: Constants.switchHandleHeight))
        
        self.view.addSubview(titleView!)
        self.view.addSubview(switchBackgroundView!)
        self.view.addSubview(switchHandleView!)
    }
    
    func addPanGesture(view: UIView) {
        let pan = UIPanGestureRecognizer(target: self, action: #selector(handlePan(sender:)))
        view.addGestureRecognizer(pan)
    }
    
    func addTapGesture(view: UIView) {
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleTap(sender:)))
        view.addGestureRecognizer(tap)
    }
    
    func setupToggleAction() {
        switchHandleView?.toggleAction = { [weak self] in
            guard let strongSelf = self else { return }
            
            if self?.lightState == .off {
                UIView.animate(withDuration: Constants.animationDuration) {
                    strongSelf.switchHandleView?.switchHandle.backgroundColor = Constants.handleColorOff
                    strongSelf.switchHandleView?.icon.image = UIImage(named: Constants.iconNameOff)
                }
            } else {
                UIView.animate(withDuration: Constants.animationDuration) {
                    strongSelf.switchHandleView?.switchHandle.backgroundColor = Constants.handleColorOn
                    strongSelf.switchHandleView?.icon.image = UIImage(named: Constants.iconNameOn)
                }
            }
        }
        
        titleView?.toggleAction = { [weak self] in
            guard let strongSelf = self else { return }
            
            if self?.lightState == .off {
                UIView.animate(withDuration: Constants.animationDuration) {
                    strongSelf.titleView?.descriptionLabel.text = "Powered Off"
                    strongSelf.titleView?.image.image = UIImage(named: Constants.imageNameOff)
                }
            } else {
                UIView.animate(withDuration: Constants.animationDuration) {
                    strongSelf.titleView?.descriptionLabel.text = "Powered On"
                    strongSelf.titleView?.image.image = UIImage(named: Constants.imageNameOn)
                }
            }
        }
    }
    
    @objc func handlePan(sender: UIPanGestureRecognizer) {
        let handleView = sender.view
        let translation = sender.translation(in: view)
        let velocity = sender.velocity(in: view).y
        
        guard let handle = handleView else { return }
        switch sender.state {
        case .began, .changed:
            handle.center.y = handle.center.y + translation.y
            sender.setTranslation(CGPoint.zero, in: view)
            
            if handle.frame.origin.y > Constants.switchHandleOffsetY {
                // TODO: Add stretch effect downwards
                handle.frame.origin = CGPoint(x: handle.frame.origin.x, y: Constants.switchHandleOffsetY)
            } else if handle.frame.origin.y <= Constants.switchHandleOffsetY && handle.frame.origin.y >= Constants.handleSwitchpoint {
                lightState = .off
            } else if handle.frame.origin.y < Constants.handleSwitchpoint && handle.frame.origin.y >= Constants.handleMaxpoint {
                lightState = .on
            } else {
                // TODO: Add stretch effect upwards
                handle.frame.origin = CGPoint(x: handle.frame.origin.x, y: Constants.handleMaxpoint)
            }
            
        case .ended:
            // Handle position check
            if handle.frame.origin.y <= Constants.switchHandleOffsetY && handle.frame.origin.y >= Constants.handleSwitchpoint {
                animateHandle(senderView: handle, toState: .off)
            } else if handle.frame.origin.y < Constants.handleSwitchpoint && handle.frame.origin.y >= Constants.handleMaxpoint {
                animateHandle(senderView: handle, toState: .on)
            }
            
            // Handle velocity check
            if velocity < -Constants.swipeVelocityThreshold {
                animateHandle(senderView: handle, toState: .on)
            } else if velocity > Constants.swipeVelocityThreshold {
                animateHandle(senderView: handle, toState: .off)
            }
            
        default:
            ()
        }
    }
    
    func animateHandle(senderView: UIView, toState: LightState) {
        if toState == .on {
            UIView.animate(withDuration: Constants.animationDuration, delay: 0.0, options: .curveEaseInOut, animations: {
                senderView.frame.origin.y = Constants.handleMaxpoint
            }, completion: nil)
            lightState = .on
        } else {
            UIView.animate(withDuration: Constants.animationDuration, delay: 0.0, options: .curveEaseInOut, animations: {
                senderView.frame.origin.y = Constants.switchHandleOffsetY
            }, completion: nil)
            lightState = .off
        }
    }
    
    @objc func handleTap(sender: UITapGestureRecognizer) {
        switch sender.state {
        case .ended:
            if lightState == .off {
                animateHandle(senderView: switchHandleView!, toState: .on)
            } else {
                animateHandle(senderView: switchHandleView!, toState: .off)
            }
        default:
            ()
        }
    }
}

