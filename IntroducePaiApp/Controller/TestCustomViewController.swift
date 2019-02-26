//
//  TestCustomViewController.swift
//  Calculator
//
//  Created by Komkrit Siratitanan on 30/1/2562 BE.
//  Copyright © 2562 Komkrit Siratitanan. All rights reserved.
//

import UIKit

class TestCustomViewController: UIViewController {
    
    @IBOutlet weak var mClickMeBtn: UIButton!
    private var oCustomView: CustomView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setHideBackButton()
        self.mClickMeBtn.addTarget(self, action: #selector(self.ClickOnButton), for: .touchUpInside)
        self.navigationItem.title = "CustomView"
        
    }
    
    private func setHideBackButton() {
        self.navigationItem.hideBackButton()
        self.navigationItem.addBtnBackToLeft(target: self, action: #selector(self.backAction))
    }
    
    @objc private func ClickOnButton() {
        self.oCustomView = CustomView()
        self.oCustomView.showCustomView()
    }
    
    @objc private func backAction() {
        self.navigationController?.popViewController(animated: true)
    }
}
