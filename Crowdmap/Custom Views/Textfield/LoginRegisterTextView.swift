//
//  LoginRegisterTextView.swift
//  Crowdmap
//
//  Created by Murat Turan on 5.03.2019.
//  Copyright © 2019 Murat Turan. All rights reserved.
//

import Foundation
import UIKit

protocol LoginRegisterTextFieldDelegate: class {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool
}

class LoginRegisterTextField: UITextField, UITextViewDelegate{
    
    @IBInspectable var imageName: String!
    
    let customView = UIView(frame: CGRect(x: 0, y: 0, width: 35, height: 35))
    let imageView = UIImageView(frame: CGRect(x: 0, y: 5, width: 25, height: 25))
    var image: UIImage!
    var lineView: UIView!
    var loginRegisterTextFieldDelegate: LoginRegisterTextFieldDelegate!
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        if lineView == nil {
            self.leftViewMode = .always
            self.tintColor = UIColor.white
            let lineHeight = self.frame.size.height - 1
            lineView = UIView(frame: CGRect(x: 0, y: lineHeight, width: self.frame.size.width, height: 2))
            lineView.backgroundColor = UIColor.kuRadarTabBar.withAlphaComponent(0.5)
            switch self.tag{
            case 1: self.attributedPlaceholder = NSAttributedString(string: "   Enter email", attributes: [NSAttributedString.Key.foregroundColor: UIColor.white.withAlphaComponent(0.9)])
            self.textContentType = .emailAddress
            case 2: self.attributedPlaceholder = NSAttributedString(string: "   Enter password", attributes: [NSAttributedString.Key.foregroundColor: UIColor.white.withAlphaComponent(0.9)])
            case 3: self.attributedPlaceholder = NSAttributedString(string: "   Enter name", attributes: [NSAttributedString.Key.foregroundColor: UIColor.white.withAlphaComponent(0.9)])
            case 4: self.attributedPlaceholder = NSAttributedString(string: "   Enter last name", attributes: [NSAttributedString.Key.foregroundColor: UIColor.white.withAlphaComponent(0.9)])
            default: self.attributedPlaceholder = NSAttributedString(string: "   ", attributes: [NSAttributedString.Key.foregroundColor: UIColor.white.withAlphaComponent(0.9)])
            }
            self.backgroundColor = UIColor.clear
            self.borderStyle = .none
            if imageName != nil {
                image = UIImage(named: imageName!)
                imageView.image = image
                customView.addSubview(imageView)
                self.leftView = customView
            }
            translatesAutoresizingMaskIntoConstraints = false
            self.addSubview(lineView)
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        if lineView != nil {
            let lineHeight = self.frame.size.height - 2
            lineView.frame = CGRect(x: 0, y: lineHeight, width: frame.size.width, height: 1)
            layoutIfNeeded()
        }
    }
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        if imageName != nil {
            return CGRect(x: 40, y: 0, width: bounds.size.width - 80, height: bounds.size.height - 3)
        }
        return bounds
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        if imageName != nil {
            return CGRect(x: 40, y: 0, width: bounds.size.width - 80, height: bounds.size.height - 3)
        }
        return bounds
    }
    
    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: 32, dy: 0)
    }
    
    private func textFieldDidBeginEditing(_ textField: UITextField) {
        lineView.backgroundColor = UIColor.kuRadarTabBar.withAlphaComponent(0.9)
    }
    
    private func textFieldDidEndEditing(_ textField: UITextField) {
        lineView.backgroundColor = UIColor.kuRadarTabBar.withAlphaComponent(0.5)
    }
    
    
    
    
    
    
}
