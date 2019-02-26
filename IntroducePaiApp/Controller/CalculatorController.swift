//
//  ViewController.swift
//  SimpleApp
//
//  Created by Komkrit Siratitanan on 24/1/2562 BE.
//  Copyright © 2562 Komkrit Siratitanan. All rights reserved.
//

import UIKit

class CalculatorController: UIViewController {
//    @IBOutlet weak var mBtnClick: UIButton!
    private var iAnswer: Int = 0
    private var iTemp: Int = 0
    private var eKeepType: eType = .None
    @IBOutlet weak var mLabelTotalShow: UILabel!
    
    @IBOutlet weak var mClearBtn: UIButton!
    @IBOutlet weak var mEqualAnsBtn: UIButton!
    
    @IBOutlet weak var mMinusPlusBtn: UIButton!
    @IBOutlet weak var mPercentBtn: UIButton!
    @IBOutlet weak var mDotBtn: UIButton!
    
    @IBOutlet weak var mDivideBtn: UIButton!
    @IBOutlet weak var mMultiplyBtn: UIButton!
    @IBOutlet weak var mMinusBtn: UIButton!
    @IBOutlet weak var mPlusBtn: UIButton!
    
    @IBOutlet weak var m0Btn: UIButton!
    @IBOutlet weak var m1Btn: UIButton!
    @IBOutlet weak var m2Btn: UIButton!
    @IBOutlet weak var m3Btn: UIButton!
    @IBOutlet weak var m4Btn: UIButton!
    @IBOutlet weak var m5Btn: UIButton!
    @IBOutlet weak var m6Btn: UIButton!
    @IBOutlet weak var m7Btn: UIButton!
    @IBOutlet weak var m8Btn: UIButton!
    @IBOutlet weak var m9Btn: UIButton!
    
    @IBOutlet weak var mConResultView: NSLayoutConstraint!
    
    private var fLand: CGFloat = 0.0
    private var fPort: CGFloat = 0.0
    
    enum eType: String {
        case None = ""
        case Minus = "-"
        case Plus = "+"
        case Multiply = "*"
        case Divide = "/"
        case Percent = "%"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupView()
        self.setHideBackButton()
        self.navigationItem.title = "Calculator"
        self.fPort = self.mEqualAnsBtn.frame.height * 2
        self.fLand = self.mEqualAnsBtn.frame.height
        
        self.m0Btn.tag = 0
        self.m1Btn.tag = 1
        self.m2Btn.tag = 2
        self.m3Btn.tag = 3
        self.m4Btn.tag = 4
        self.m5Btn.tag = 5
        self.m6Btn.tag = 6
        self.m7Btn.tag = 7
        self.m8Btn.tag = 8
        self.m9Btn.tag = 9
        
        self.mClearBtn.addTarget(self, action: #selector(self.clearTxt), for: .touchUpInside)
        
        self.m0Btn.addTarget(self, action: #selector(self.addtxt), for: .touchUpInside)
        self.m1Btn.addTarget(self, action: #selector(self.addtxt), for: .touchUpInside)
        self.m2Btn.addTarget(self, action: #selector(self.addtxt), for: .touchUpInside)
        self.m3Btn.addTarget(self, action: #selector(self.addtxt), for: .touchUpInside)
        self.m4Btn.addTarget(self, action: #selector(self.addtxt), for: .touchUpInside)
        self.m5Btn.addTarget(self, action: #selector(self.addtxt), for: .touchUpInside)
        self.m6Btn.addTarget(self, action: #selector(self.addtxt), for: .touchUpInside)
        self.m7Btn.addTarget(self, action: #selector(self.addtxt), for: .touchUpInside)
        self.m8Btn.addTarget(self, action: #selector(self.addtxt), for: .touchUpInside)
        self.m9Btn.addTarget(self, action: #selector(self.addtxt), for: .touchUpInside)
        
        
        self.mPlusBtn.tag = 111
        self.mMinusBtn.tag = 222
        self.mMultiplyBtn.tag = 333
        self.mDivideBtn.tag = 444
        self.mPercentBtn.tag = 555
        
        self.mPlusBtn.addTarget(self, action: #selector(self.signal), for: .touchUpInside)
        self.mMinusBtn.addTarget(self, action: #selector(self.signal), for: .touchUpInside)
        self.mMultiplyBtn.addTarget(self, action: #selector(self.signal), for: .touchUpInside)
        self.mDivideBtn.addTarget(self, action: #selector(self.signal), for: .touchUpInside)
        self.mPercentBtn.addTarget(self, action: #selector(self.signal), for: .touchUpInside)
        
        self.mEqualAnsBtn.addTarget(self, action: #selector(self.getAnswer), for: .touchUpInside)
        
        self.setConHeight()
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.rotationView(notification:)), name: UIApplication.didChangeStatusBarOrientationNotification, object: nil)
    }

    @objc private func addtxt(btn: UIButton) {
        if self.iAnswer == 0 {
            self.mLabelTotalShow.text = "\(btn.tag)"
            self.iAnswer = btn.tag
        } else {
            let sTemp = "\(self.iAnswer)\(btn.tag)"
            self.mLabelTotalShow.text = sTemp
            self.iAnswer = Int(sTemp)!
        }
    }
    
    @objc private func signal(btn: UIButton) {
        switch btn.tag {
        case 111:
            self.eKeepType = .Plus
            self.iAnswer = self.iTemp + self.iAnswer
        case 222:
            self.eKeepType = .Minus
            if self.iTemp != 0 {
                self.iAnswer = self.iTemp - self.iAnswer
            }
        case 333:
            self.eKeepType = .Multiply
            if self.iTemp != 0 {
                self.iAnswer = self.iTemp * self.iAnswer
            }
        case 444:
            self.eKeepType = .Divide
            if self.iTemp != 0 {
                self.iAnswer = self.iTemp / self.iAnswer
            }
        case 555:
            self.eKeepType = .Percent
            if self.iTemp != 0 {
                self.iAnswer = (self.iTemp * 100) / self.iAnswer
            }
        default:
            self.eKeepType = .None
        }
        self.mLabelTotalShow.text = "\(self.iAnswer)"
        self.iTemp = self.iAnswer
        self.iAnswer = 0
    }
    
    @objc private func clearTxt(btn: UIButton) {
        self.mLabelTotalShow.text = "0"
        self.iAnswer = 0
        self.iTemp = 0
    }
    
    @objc private func getAnswer(btn: UIButton) {
        if self.eKeepType != . None {
            switch self.eKeepType {
            case .Plus:
                self.iAnswer = self.iTemp + self.iAnswer
            case .Minus:
                self.iAnswer = self.iTemp - self.iAnswer
            case .Multiply:
                self.iAnswer = self.iTemp * self.iAnswer
            case .Divide:
                if self.iAnswer == 0 {
                    self.mLabelTotalShow.text = "Err"
                    self.iTemp = 0
                    self.iAnswer = 0
                    self.eKeepType = .None
                    return
                }
                self.iAnswer = self.iTemp / self.iAnswer
            case .Percent:
                self.iAnswer = (self.iTemp * 100) / self.iAnswer
            default:
                print("eiei")
            }
            self.mLabelTotalShow.text = "\(self.iAnswer)"
            self.iTemp = 0
            self.eKeepType = .None
        }
    }
    
    private func setupView() {
        self.m0Btn.layer.borderColor = UIColor.black.cgColor
        self.m0Btn.layer.borderWidth = 0.25
        self.m1Btn.layer.borderColor = UIColor.black.cgColor
        self.m1Btn.layer.borderWidth = 0.25
        self.m2Btn.layer.borderColor = UIColor.black.cgColor
        self.m2Btn.layer.borderWidth = 0.25
        self.m3Btn.layer.borderColor = UIColor.black.cgColor
        self.m3Btn.layer.borderWidth = 0.25
        self.m4Btn.layer.borderColor = UIColor.black.cgColor
        self.m4Btn.layer.borderWidth = 0.25
        self.m5Btn.layer.borderColor = UIColor.black.cgColor
        self.m5Btn.layer.borderWidth = 0.25
        self.m6Btn.layer.borderColor = UIColor.black.cgColor
        self.m6Btn.layer.borderWidth = 0.25
        self.m7Btn.layer.borderColor = UIColor.black.cgColor
        self.m7Btn.layer.borderWidth = 0.25
        self.m8Btn.layer.borderColor = UIColor.black.cgColor
        self.m8Btn.layer.borderWidth = 0.25
        self.m9Btn.layer.borderColor = UIColor.black.cgColor
        self.m9Btn.layer.borderWidth = 0.25
        self.mClearBtn.layer.borderColor = UIColor.black.cgColor
        self.mClearBtn.layer.borderWidth = 0.25
        self.mMinusBtn.layer.borderColor = UIColor.black.cgColor
        self.mMinusBtn.layer.borderWidth = 0.25
        self.mMinusPlusBtn.layer.borderColor = UIColor.black.cgColor
        self.mMinusPlusBtn.layer.borderWidth = 0.25
        self.mPlusBtn.layer.borderColor = UIColor.black.cgColor
        self.mPlusBtn.layer.borderWidth = 0.25
        self.mDotBtn.layer.borderColor = UIColor.black.cgColor
        self.mDotBtn.layer.borderWidth = 0.25
        self.mEqualAnsBtn.layer.borderColor = UIColor.black.cgColor
        self.mEqualAnsBtn.layer.borderWidth = 0.25
        self.mMultiplyBtn.layer.borderColor = UIColor.black.cgColor
        self.mMultiplyBtn.layer.borderWidth = 0.25
        self.mDivideBtn.layer.borderColor = UIColor.black.cgColor
        self.mDivideBtn.layer.borderWidth = 0.25
        self.mPercentBtn.layer.borderColor = UIColor.black.cgColor
        self.mPercentBtn.layer.borderWidth = 0.25
    }
    
    @objc func rotationView(notification: NSNotification) {
        self.setConHeight()
    }
    
    func setConHeight() {
        switch UIDevice.current.orientation{
        case .portrait:
            self.mConResultView.constant = self.fPort
        case .portraitUpsideDown:
            self.mConResultView.constant = self.fPort
        case .landscapeLeft:
            self.mConResultView.constant = self.fLand
        case .landscapeRight:
            self.mConResultView.constant = self.fLand
        default:
            self.mConResultView.constant = self.fPort
        }
    }
    
    private func setHideBackButton() {
        self.navigationItem.hideBackButton()
        self.navigationItem.addBtnBackToLeft(target: self, action: #selector(self.backAction))
    }
    
    @objc private func backAction() {
        self.navigationController?.popViewController(animated: true)
    }
}


