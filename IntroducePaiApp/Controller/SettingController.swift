//
//  SettingController.swift
//  Calculator
//
//  Created by Komkrit Siratitanan on 28/1/2562 BE.
//  Copyright © 2562 Komkrit Siratitanan. All rights reserved.
//
//import PTTextField
import UIKit

class SettingController: UIViewController, UITextViewDelegate {
    
    private var mTableview: UITableView!
    private var mTextViewJa: textviewJa!
    private var mTextViewJa2: textFieldJa!
//    private var oPTTextField: PTTextField!
    private var mViewChangeColor: UIView = UIView()
    private var mChangeTxtColor: UILabel = UILabel()
    
    private var oPTTextField: PTTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.setNavBarColor()
        
        self.view.backgroundColor = .white
        self.oPTTextField = PTTextField()
        self.oPTTextField.setupPTTextField(sTextShow: "Hello World")
//        self.oPTTextField.setupPTTextField(sTextShow: "This is better than using NSTimer", oBGColor: self.view.backgroundColor!, oPlaceHolderColor: .red, oFontColor: .blue, borderColor: .blue, borderWidth: 2.0)
//        self.oPTTextField.setupPTTextField(sTextShow: "This is better than using NSTimer")
        self.view.addSubview(self.oPTTextField)
        self.oPTTextField.translatesAutoresizingMaskIntoConstraints = false
        self.oPTTextField.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        self.oPTTextField.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 16.0).isActive = true
        self.oPTTextField.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 16.0).isActive = true
        self.oPTTextField.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -16.0).isActive = true
        self.oPTTextField.heightAnchor.constraint(equalToConstant: 50.0).isActive = true
        
//        let mBtn1 = UIButton()
//        mBtn1.backgroundColor = .red
//        mBtn1.tag = 111
//        let mBtn2 = UIButton()
//        mBtn2.backgroundColor = .blue
//        mBtn2.tag = 222
//        self.view.addSubview(mBtn1)
//        self.view.addSubview(mBtn2)
        
        
//        self.view.addSubview(mViewChangeColor)
//        mViewChangeColor.backgroundColor = .yellow
//        mViewChangeColor.translatesAutoresizingMaskIntoConstraints = false
//        mViewChangeColor.topAnchor.constraint(equalTo: mBtn2.bottomAnchor, constant: 16.0).isActive = true
//        mViewChangeColor.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 16.0).isActive = true
//        mViewChangeColor.widthAnchor.constraint(equalToConstant: 50.0).isActive = true
//        mViewChangeColor.heightAnchor.constraint(equalToConstant: 50.0).isActive = true
        
        self.mViewChangeColor.addSubview(self.mChangeTxtColor)
        self.mChangeTxtColor.translatesAutoresizingMaskIntoConstraints = false
        self.mChangeTxtColor.textColor = .blue
        self.mChangeTxtColor.text = "O"
        self.mChangeTxtColor.font = .systemFont(ofSize: 20.0)
        self.mChangeTxtColor.centerXAnchor.constraint(equalTo: self.mViewChangeColor.centerXAnchor).isActive = true
        self.mChangeTxtColor.centerYAnchor.constraint(equalTo: self.mViewChangeColor.centerYAnchor).isActive = true
        
//        mBtn1.translatesAutoresizingMaskIntoConstraints = false
//        mBtn1.widthAnchor.constraint(equalToConstant: 50.0).isActive = true
//        mBtn1.heightAnchor.constraint(equalToConstant: 25.0).isActive = true
//        mBtn1.topAnchor.constraint(equalTo: self.oPTTextField.bottomAnchor, constant: 16.0).isActive = true
//        mBtn1.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 16.0).isActive = true
////        mBtn1.addTarget(self, action: #selector(self.setColor), for: .touchUpInside)
//
//        mBtn2.translatesAutoresizingMaskIntoConstraints = false
//        mBtn2.widthAnchor.constraint(equalToConstant: 50.0).isActive = true
//        mBtn2.heightAnchor.constraint(equalToConstant: 25.0).isActive = true
//        mBtn2.topAnchor.constraint(equalTo: self.oPTTextField.bottomAnchor, constant: 16.0).isActive = true
//        mBtn2.leftAnchor.constraint(equalTo: mBtn1.rightAnchor, constant: 16.0).isActive = true
//        mBtn2.addTarget(self, action: #selector(self.setColor), for: .touchUpInside)
        
//        mBtn1
        
        self.mTextViewJa = textviewJa()
        self.mTextViewJa2 = textFieldJa()
        self.mTextViewJa2.setTextShow(sTitleShow: "อีเมล/นามแฝง")

        //        self.mTextViewJa.delegate = self
        self.view.addSubview(self.mTextViewJa)
        self.mTextViewJa.translatesAutoresizingMaskIntoConstraints = false
        //        self.mTextViewJa.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 8.0).isActive = true
        self.mTextViewJa.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        self.mTextViewJa.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
        self.mTextViewJa.widthAnchor.constraint(equalToConstant: 200.0).isActive = true
        self.mTextViewJa.heightAnchor.constraint(equalToConstant: 30.0).isActive = true

        self.view.addSubview(self.mTextViewJa2)
        self.mTextViewJa2.translatesAutoresizingMaskIntoConstraints = false
        //        self.mTextViewJa.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 8.0).isActive = true
        self.mTextViewJa2.topAnchor.constraint(equalTo: self.mTextViewJa.bottomAnchor, constant: 16.0).isActive = true
        self.mTextViewJa2.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        self.mTextViewJa2.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width - 16.0).isActive = true
        self.mTextViewJa2.heightAnchor.constraint(equalToConstant: 50.0).isActive = true
    }
    
//    @objc func setColor(sender: UIButton) {
//        if sender.tag == 111 {
//            self.oPTTextField.setPTTextFieldColor(oFontColor: .red, oBorderColor: .red)
//            UIView.animate(withDuration: 1.0, animations: {
//                self.mViewChangeColor.backgroundColor = .red
//
//            }, completion: nil)
//
//            UIView.transition(with: self.mChangeTxtColor, duration: 1.0, options: .transitionCrossDissolve, animations: {
//                self.mChangeTxtColor.textColor = .blue
//            }, completion: nil)
//        } else {
//            self.oPTTextField.setPTTextFieldColor(oFontColor: .blue, oBorderColor: .blue)
//            UIView.animate(withDuration: 1.0, animations: {
//                self.mViewChangeColor.backgroundColor = .blue
//
//            }, completion: nil)
//
//            UIView.transition(with: self.mChangeTxtColor, duration: 1.0, options: .transitionCrossDissolve, animations: {
//                self.mChangeTxtColor.textColor = .red
//            }, completion: nil)
//        }
//    }
}

extension SettingController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 56.0
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 56.0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.mTableview.dequeueReusableCell(withIdentifier: "SettingCell") as! SettingCell
        cell.mLabel.text = "\(indexPath.row)"
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}

class SettingCell: UITableViewCell {
    
    private var mMainView: UIView = UIView()
    var mLabel: UILabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setupTableView()
        self.backgroundColor = .green
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupTableView() {
        self.mMainView.translatesAutoresizingMaskIntoConstraints = false
        self.mLabel.translatesAutoresizingMaskIntoConstraints = false
        
        self.addSubview(self.mMainView)
        self.mMainView.addSubview(self.mLabel)
        
        self.mMainView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        self.mMainView.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        self.mMainView.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        self.mMainView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        
        self.mLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        self.mLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        self.mLabel.widthAnchor.constraint(equalToConstant: 75.0).isActive = true
        self.mLabel.heightAnchor.constraint(equalToConstant: 30.0).isActive = true
        self.mLabel.text = "Hello"
        self.mLabel.textAlignment = .center
    }
    
}


class textviewJa: UITextView {
    var mView: UIView!
    var mTextInLabel: UILabel!
    
    override init(frame: CGRect = .zero, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)
        self.delegate = self
        self.layer.cornerRadius = 10.0
        self.layer.borderColor = UIColor.gray.cgColor
        self.layer.borderWidth = 2.0
        self.backgroundColor = .white
        self.mView = UIView()
        self.mTextInLabel = UILabel()
        self.mTextInLabel.text = "สวัสดีจ้า"
        self.mTextInLabel.font = .systemFont(ofSize: 10.0)
        self.mTextInLabel.textAlignment = .center
        self.mTextInLabel.textColor = UIColor.red
        self.mView.backgroundColor = .white
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension textviewJa: UITextViewDelegate {
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        print("begin editing")
        
        self.superview?.addSubview(self.mView)
        self.mView.addSubview(self.mTextInLabel)
        self.mView.translatesAutoresizingMaskIntoConstraints = false
        self.mView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 10.0).isActive = true
        self.mView.heightAnchor.constraint(equalToConstant: 8.0).isActive = true
        self.mView.widthAnchor.constraint(equalToConstant: 50.0).isActive = true
        self.mView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        self.mTextInLabel.translatesAutoresizingMaskIntoConstraints = false
        self.mTextInLabel.centerXAnchor.constraint(equalTo: self.mView.centerXAnchor).isActive = true
        self.mTextInLabel.centerYAnchor.constraint(equalTo: self.mView.centerYAnchor).isActive = true
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        print("end editing")
        self.mView.removeFromSuperview()
    }
}

class textFieldJa: UITextField {
    var mView: UIView!
    var mTextInLabel: UILabel!
    var sTextShow: String = ""
    var mTempPlaceHolder: UILabel!
    var bIsShowing: Bool!
    var bVerify: Bool!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.delegate = self
        print("init ja")
        self.bVerify = false
        self.bIsShowing = false
        self.autocorrectionType = .no
        self.inputAccessoryView = self.accessory
        self.addAccessory()
        self.layer.cornerRadius = 10.0
        self.layer.borderColor = UIColor.gray.cgColor
        self.layer.borderWidth = 2.0
    }
    
    func setRegex(oColor: UIColor = .red,sTextCheck: String , sRegex: String) {
//        if !sTextCheck.isEmpty {
            if let range = sTextCheck.range(of:sRegex, options: .regularExpression) {
                self.layer.borderColor = UIColor.green.cgColor
            } else {
                self.layer.borderColor = oColor.cgColor
            }
//        }
//        self.layer.borderColor = UIColor.gray.cgColor
    }
    
    func setTextShow(sTitleShow: String) {
        self.mView = UIView()
        self.mTextInLabel = UILabel()
        self.sTextShow = sTitleShow
        self.mTextInLabel.text = self.sTextShow
        self.mTextInLabel.font = .systemFont(ofSize: 10.0)
        self.mTextInLabel.textAlignment = .center
        self.mTextInLabel.textColor = UIColor.gray
        self.mView.backgroundColor = .white
        print("TopText: \(self.getWidthSize(fSize: 10.0))")
        self.setTempPlaceHolder()
    }
    
    func getWidthSize(fSize: CGFloat) -> CGFloat {
        let fontAttributes = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: fSize)]
        let size = (self.sTextShow as NSString).size(withAttributes: fontAttributes)
        return size.width
    }
    
    
    func setTempPlaceHolder() {
        self.mTempPlaceHolder = UILabel()
        self.mTempPlaceHolder.text = self.sTextShow
        self.mTempPlaceHolder.font = .systemFont(ofSize: 16.0)
        self.mTempPlaceHolder.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
        self.mTempPlaceHolder.textAlignment = .left
        self.mTempPlaceHolder.textColor = UIColor.gray
        self.mTempPlaceHolder.backgroundColor = .white
        self.addSubview(self.mTempPlaceHolder)
        self.mTempPlaceHolder.frame = CGRect(x: 16.0, y: 16.6, width: self.getWidthSize(fSize: 16.0) + 16.0, height: 15.0)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let padding = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
    
    override open func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
    override open func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
    override open func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
    var accessory: UIView = {
        let accessoryView = UIView(frame: .zero)
        accessoryView.backgroundColor = UIColor.gray
        //        accessoryView.addBorder(edges: .top, colour: UIColor.purple, thickness: 0.3)
        accessoryView.frame = CGRect(x: 0, y: 0, width: 0, height: 0)
        
        return accessoryView
    }()
    
    func addAccessory()  {
        self.accessory.frame = CGRect(x: 0, y: 0, width: 0, height: 46)
        self.accessory.translatesAutoresizingMaskIntoConstraints = false
        let mButton = UIButton()
        mButton.showsTouchWhenHighlighted = true
        mButton.isEnabled = true
        mButton.imageView?.contentMode = .scaleAspectFit
        mButton.setImage(UIImage(named: "ic-keyboard-hide")?.withRenderingMode(.alwaysTemplate), for: .normal)
        mButton.imageView?.tintColor = UIColor.black.withAlphaComponent(0.38)
        mButton.addTarget(self, action: #selector(self.keyboardHide), for: .touchUpInside)
        self.accessory.addSubview(mButton)
        mButton.translatesAutoresizingMaskIntoConstraints = false
        mButton.centerYAnchor.constraint(equalTo: self.accessory.centerYAnchor).isActive = true
        mButton.widthAnchor.constraint(equalToConstant: 30.0).isActive = true
        mButton.heightAnchor.constraint(equalToConstant: 30.0).isActive = true
        mButton.rightAnchor.constraint(equalTo: self.accessory.rightAnchor, constant: -8.0).isActive = true
    }
    
    @objc private func keyboardHide() {
        self.endEditing(true)
    }
}

extension textFieldJa: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if !self.bIsShowing {
            self.bIsShowing = true
            UIView.animate(withDuration: 0.5, delay: 0.0, usingSpringWithDamping: 0.66, initialSpringVelocity: 1.0, options: .curveEaseOut, animations: {
                self.mTempPlaceHolder.transform = CGAffineTransform(scaleX: 0.6, y: 0.6)
                self.mTempPlaceHolder.frame = CGRect(x: 16.0, y: -5.0, width: self.getWidthSize(fSize: 16.0) + 16.0, height: 15.0)
            }) { (bComplete) in
                self.mTempPlaceHolder.removeFromSuperview()
                self.superview?.addSubview(self.mView)
                self.mView.addSubview(self.mTextInLabel)
                self.mView.translatesAutoresizingMaskIntoConstraints = false
                self.mView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 10.0).isActive = true
                self.mView.heightAnchor.constraint(equalToConstant: 8.0).isActive = true
                self.mView.widthAnchor.constraint(equalToConstant: self.getWidthSize(fSize: 10.0) + 16.0).isActive = true
                self.mView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
                self.mTextInLabel.translatesAutoresizingMaskIntoConstraints = false
                self.mTextInLabel.centerXAnchor.constraint(equalTo: self.mView.centerXAnchor).isActive = true
                self.mTextInLabel.centerYAnchor.constraint(equalTo: self.mView.centerYAnchor).isActive = true
            }
        }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let Txt: String = "\(String(textField.text!))\(string)"
        self.setRegex(oColor: .red, sTextCheck: Txt, sRegex: "^.+@.+\\..+")
        return true
    }
    
    
    
    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextField.DidEndEditingReason) {
        self.bIsShowing = false
        self.layer.borderColor = UIColor.gray.cgColor
        self.mTempPlaceHolder.removeFromSuperview()
        self.mView.removeFromSuperview()
        if self.text!.isEmpty {
            self.setTempPlaceHolder()
        }
    }
}

