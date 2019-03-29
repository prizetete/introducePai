//
//  SettingController.swift
//  Calculator
//
//  Created by Komkrit Siratitanan on 28/1/2562 BE.
//  Copyright © 2562 Komkrit Siratitanan. All rights reserved.
//

import UIKit

class SettingController: UIViewController, UITextViewDelegate {
    
    private var mTableview: UITableView!
    private var mTextViewJa: textviewJa!
    private var mTextViewJa2: textFieldJa!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.setNavBarColor()
        
        self.view.backgroundColor = .white
        
        self.mTextViewJa = textviewJa()
        self.mTextViewJa2 = textFieldJa()
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
        self.mTextViewJa2.widthAnchor.constraint(equalToConstant: 300.0).isActive = true
        self.mTextViewJa2.heightAnchor.constraint(equalToConstant: 50.0).isActive = true
        
//        self.mTableview = UITableView()
//        self.mTableview.delegate = self
//        self.mTableview.dataSource = self
//
//        self.mTableview.translatesAutoresizingMaskIntoConstraints = false
//        self.mTableview.backgroundColor = .yellow
//        self.mTableview.register(SettingCell.self, forCellReuseIdentifier: "SettingCell")
//
//        self.view.addSubview(self.mTableview)
//
//        self.mTableview.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
//        self.mTableview.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
//        self.mTableview.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true
//        self.mTableview.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        
    }
    
//    func textViewDidChange(_ textView: UITextView) {
//        print("change: \(textView.text)")
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
    
    override init(frame: CGRect = .zero) {
        super.init(frame: frame)
        self.delegate = self
        self.layer.cornerRadius = 10.0
        self.layer.borderColor = UIColor.gray.cgColor
        self.layer.borderWidth = 2.0

        self.mView = UIView()
        self.mTextInLabel = UILabel()
        self.mTextInLabel.text = "สวัสดีจ้า"
        self.mTextInLabel.font = .systemFont(ofSize: 10.0)
        self.mTextInLabel.textAlignment = .center
        self.mTextInLabel.textColor = UIColor.gray
        self.mView.backgroundColor = .white
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
    
}

extension textFieldJa: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        print("begin111")
//        self.placeholder = ""
        UIView.animate(withDuration: 0.35) {
            self.superview?.addSubview(self.mView)
            self.mView.addSubview(self.mTextInLabel)
            self.mView.translatesAutoresizingMaskIntoConstraints = false
            self.mView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 15.0).isActive = true
            self.mView.heightAnchor.constraint(equalToConstant: 8.0).isActive = true
            self.mView.widthAnchor.constraint(equalToConstant: 50.0).isActive = true
            self.mView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
            self.mTextInLabel.translatesAutoresizingMaskIntoConstraints = false
            self.mTextInLabel.centerXAnchor.constraint(equalTo: self.mView.centerXAnchor).isActive = true
            self.mTextInLabel.centerYAnchor.constraint(equalTo: self.mView.centerYAnchor).isActive = true
        }
    }

    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextField.DidEndEditingReason) {
        print("end1111")
//        self.placeholder = "สวัสดีจ้า"
        self.mView.removeFromSuperview()
    }
}
