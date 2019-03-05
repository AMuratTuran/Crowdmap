//
//  LoginRegisterButton.swift
//  Crowdmap
//
//  Created by Murat Turan on 5.03.2019.
//  Copyright © 2019 Murat Turan. All rights reserved.
//

import UIKit


class LoginRegisterButton: UIButton {
    
    var buttonAction: (() -> Void)?
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
    }
    
    private func setupView(){
        
        frame.size.width = 250
        
        if titleLabel?.text == "LOGIN"{
            layer.borderColor = UIColor.kuRadarTabBar.cgColor
            layer.borderWidth = 1
            setTitleColor(UIColor.kuRadarNavigationBar, for: .normal)
            backgroundColor = UIColor.white.withAlphaComponent(1)
            addTarget(self, action: #selector(updateButtonTapped), for: .touchDown)
            addTarget(self, action: #selector(updateButtonTouchUpInside), for: .touchUpInside)
            addTarget(self, action: #selector(updateButtonTouchUpOutside), for: .touchDragExit)
            translatesAutoresizingMaskIntoConstraints = false
        }else {
            
            layer.borderColor = UIColor.white.cgColor
            layer.borderWidth = 1
            setTitleColor(UIColor.white, for: .normal)
            backgroundColor = UIColor.kuRadarNavigationBar.withAlphaComponent(0.9)
            addTarget(self, action: #selector(updateButtonTapped), for: .touchDown)
            addTarget(self, action: #selector(updateButtonTouchUpInside), for: .touchUpInside)
            addTarget(self, action: #selector(updateButtonTouchUpOutside), for: .touchDragExit)
            translatesAutoresizingMaskIntoConstraints = false
        }
        
    }
    
    @objc private func updateButtonTapped() {
        UIView.animate(withDuration: 0.1, animations: {
            self.transform = CGAffineTransform.init(scaleX: 0.9, y: 0.9)
        }, completion: nil)
    }
    
    @objc private func updateButtonTouchUpInside() {
        UIView.animate(withDuration: 0.1, animations: {
            self.transform = CGAffineTransform.init(scaleX: 1.0, y: 1.0)
        }, completion: nil )
        buttonAction?()
    }
    
    @objc private func updateButtonTouchUpOutside() {
        UIView.animate(withDuration: 0.1, animations: {
            self.transform = CGAffineTransform.init(scaleX: 1.0, y: 1.0)
        }, completion: nil)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = frame.height / 2
        layer.masksToBounds = true
        
    }
    
    
    
    
    
    
    
}
