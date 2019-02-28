//
//  TestCustomViewController.swift
//  Calculator
//
//  Created by Komkrit Siratitanan on 30/1/2562 BE.
//  Copyright © 2562 Komkrit Siratitanan. All rights reserved.
//

import UIKit
import WebKit

class TestCustomViewController: UIViewController {
    
    private var mClickMeBtn: UIButton = UIButton()
    private var oCustomView: CustomView!
    private var videoBackgroundWebView: WKWebView = WKWebView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setHideBackButton()
        
        self.navigationItem.title = "CustomView"
        self.setVideoBackground()
    }
    
    private func setVideoBackground() {
        self.mClickMeBtn.translatesAutoresizingMaskIntoConstraints = false
        self.videoBackgroundWebView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(self.videoBackgroundWebView)
        self.videoBackgroundWebView.addSubview(self.mClickMeBtn)
        
        self.videoBackgroundWebView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        self.videoBackgroundWebView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        self.videoBackgroundWebView.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true
        self.videoBackgroundWebView.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
        self.videoBackgroundWebView.scrollView.isScrollEnabled = false
        
        self.mClickMeBtn.centerXAnchor.constraint(equalTo: self.videoBackgroundWebView.centerXAnchor).isActive = true
        self.mClickMeBtn.centerYAnchor.constraint(equalTo: self.videoBackgroundWebView.centerYAnchor).isActive = true
        self.mClickMeBtn.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 8.0).isActive = true
        self.mClickMeBtn.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -8.0).isActive = true
//        self.mClickMeBtn.widthAnchor.constraint(equalToConstant: 65.0).isActive = true
        self.mClickMeBtn.heightAnchor.constraint(equalToConstant: 25.0).isActive = true
        self.mClickMeBtn.backgroundColor = UIColor.black.withAlphaComponent(0.85)
        self.mClickMeBtn.layer.cornerRadius = 10.0
        self.mClickMeBtn.addTarget(self, action: #selector(self.ClickOnButton), for: .touchUpInside)
        self.mClickMeBtn.setTitleColor(UIColor.white, for: .normal)
        self.mClickMeBtn.setTitle("Click Me", for: .normal)
        
        let htmlName = "WebViewContent"
        guard let htmlPath = Bundle.main.path(forResource: htmlName, ofType: "html") else { return }
        let htmlURL = URL(fileURLWithPath: htmlPath)
        guard let html = try? Data(contentsOf: htmlURL) else { return }
        self.videoBackgroundWebView.load(html, mimeType: "text/html", characterEncodingName: "UTF-8", baseURL: htmlURL.deletingLastPathComponent())
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
