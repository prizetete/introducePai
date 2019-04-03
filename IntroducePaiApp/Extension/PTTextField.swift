//
//  PTTextField.swift
//  IntroducePaiApp
//
//  Created by Komkrit Siratitanan on 2/4/2562 BE.
//  Copyright © 2562 Komkrit Siratitanan. All rights reserved.
//

import Foundation
import UIKit

class PTTextField: UITextField {
    var mView: UIView!
    var mLabel: UILabel!
    
    var sRegEX: String!
    var sTextShow: String! = ""
    
    var oBorderColor: UIColor!
    var oCorrectColor: UIColor!
    var oWrongColor: UIColor!
    var oBGColor: UIColor!
    var oFontColor: UIColor!
    var oPlaceHolderColor: UIColor!
    
    var bVerify: Bool!
    var bIsShowing: Bool!
    
    private let padding = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.delegate = self
        self.bVerify = false
        self.bIsShowing = false
        self.sRegEX = ""
        self.mView = UIView()
        self.mLabel = UILabel()
    }
    
    func setupPTTextField(sTextShow: String, oBGColor: UIColor = .white, oPlaceHolderColor: UIColor = .gray, oFontColor: UIColor = .gray, sRegEX: String = "", oCorrectColor: UIColor = .green, oWrongColor: UIColor = .red, cornerRadius: CGFloat = 10.0, borderColor: UIColor = .gray, borderWidth: CGFloat = 1.0) {
        self.sTextShow = sTextShow
        self.oBorderColor = borderColor
        self.oFontColor = oFontColor
        self.oPlaceHolderColor = oPlaceHolderColor
        self.oBGColor = oBGColor
        self.oWrongColor = oWrongColor
        self.oCorrectColor = oCorrectColor
        self.sRegEX = sRegEX
        self.layer.cornerRadius = cornerRadius
        self.layer.borderColor = borderColor.cgColor
        self.layer.borderWidth = borderWidth
        self.attributedPlaceholder = NSAttributedString(
            string: self.sTextShow,
            attributes: [
                NSAttributedString.Key.foregroundColor: self.oPlaceHolderColor,
                NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16.0)
            ]
        )
    }
    
    override open func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: self.padding)
    }
    
    override open func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: UIEdgeInsets(top: 0, left: 14, bottom: 0, right: 10))
    }
    
    override open func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: self.padding)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func getWidthSize(fSize: CGFloat) -> CGFloat {
        let fontAttributes = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: fSize)]
        let size = self.sTextShow.size(withAttributes: fontAttributes)
        return size.width
    }
    
    func setPTTextFieldColor(oFontColor: UIColor = .gray, oBorderColor: UIColor = .gray) {
        self.layer.borderColor = oBorderColor.cgColor
        self.mLabel.textColor = oFontColor
    }
    
    func VerifyText(oCorrectColor: UIColor, oWrongColor: UIColor, sTextCheck: String , sRegex: String) {
        if let _ = sTextCheck.range(of:sRegex, options: .regularExpression) {
            self.layer.borderColor = oCorrectColor.cgColor
        } else {
            self.layer.borderColor = oWrongColor.cgColor
        }
    }
}

extension PTTextField: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let sTxt: String = "\(String(textField.text!))\(string)"
        if !self.sRegEX.isEmpty {
            self.VerifyText(oCorrectColor: self.oCorrectColor, oWrongColor: self.oWrongColor, sTextCheck: sTxt, sRegex: self.sRegEX)
        }
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        self.placeholder = ""
        self.superview?.addSubview(self.mView)
        self.mView.addSubview(self.mLabel)
        
        self.mView.backgroundColor = .red //self.oBGColor
        if self.text!.isEmpty {
            self.mLabel.textColor = self.oPlaceHolderColor
            self.mView.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
            self.mView.frame = CGRect(x: textField.frame.origin.x + 10.0, y: textField.frame.origin.y + (self.frame.size.height / 4), width: self.getWidthSize(fSize: 16.0) + 16.0, height: (self.frame.size.height / 2))
        } else {
            self.mLabel.textColor = self.oFontColor
            self.mView.transform = CGAffineTransform(scaleX: 0.75, y: 0.75)
            self.mView.frame = CGRect(x: textField.frame.origin.x + 10.0, y: textField.frame.origin.y - (self.frame.size.height / 4), width: self.getWidthSize(fSize: 12.0) + 8.0, height: (self.frame.size.height / 2))
        }
        
        self.mLabel.text = self.sTextShow
        self.mLabel.font = .systemFont(ofSize: 16.0)
        self.mLabel.textAlignment = .left
        
        self.mLabel.translatesAutoresizingMaskIntoConstraints = false
        self.mLabel.leftAnchor.constraint(equalTo: self.mView.leftAnchor, constant: 4.0).isActive = true
        self.mLabel.rightAnchor.constraint(equalTo: self.mView.rightAnchor, constant: -4.0).isActive = true
        self.mLabel.centerYAnchor.constraint(equalTo: self.mView.centerYAnchor).isActive = true
        
        if self.text!.isEmpty {
            UIView.animate(withDuration: 0.25, animations: {
                self.bIsShowing = true
                self.mView.transform = CGAffineTransform(scaleX: 0.75, y: 0.75)
                self.mView.frame = CGRect(x: textField.frame.origin.x + 10.0, y: textField.frame.origin.y - (self.frame.size.height / 4), width: self.getWidthSize(fSize: 12.0) + 8.0, height: (self.frame.size.height / 2))
                UIView.transition(with: self.mLabel, duration: 0.25, options: .transitionCrossDissolve, animations: {
                    self.mLabel.textColor = self.oFontColor
                }, completion: nil)
            }) { (complete) in
                self.bIsShowing = false
            }
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextField.DidEndEditingReason) {
        UIView.animate(withDuration: 0.25, animations: {
            self.bIsShowing = true
            if self.text!.isEmpty {
                self.mView.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
                self.mView.frame = CGRect(x: textField.frame.origin.x + 10.0, y: textField.frame.origin.y + (self.frame.size.height / 4), width: self.getWidthSize(fSize: 16.0) + 16.0, height: (self.frame.size.height / 2))
                UIView.transition(with: self.mLabel, duration: 0.25, options: .transitionCrossDissolve, animations: {
                    self.mLabel.textColor = self.oPlaceHolderColor
                }, completion: nil)
            }
        }) { (complete) in
            if self.text!.isEmpty {
                self.mView.removeFromSuperview()
            }
            self.attributedPlaceholder = NSAttributedString(
                string: self.sTextShow,
                attributes: [
                    NSAttributedString.Key.foregroundColor: self.oPlaceHolderColor,
                    NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16.0)
                ]
            )
            self.layer.borderColor = self.oBorderColor.cgColor
            self.bIsShowing = false
        }
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        return !self.bIsShowing
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        return !self.bIsShowing
    }
}
