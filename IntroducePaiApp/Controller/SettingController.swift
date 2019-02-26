//
//  SettingController.swift
//  Calculator
//
//  Created by Komkrit Siratitanan on 28/1/2562 BE.
//  Copyright © 2562 Komkrit Siratitanan. All rights reserved.
//

import UIKit

class SettingController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.setNavBarColor()
        print("Setting")
        self.view.backgroundColor = .red
        self.navigationController?.hidesBarsOnSwipe = true
        // Do any additional setup after loading the view.
//        self.setupCustomView()
    }
    
    private func setupCustomView() {
        let mBGBlack = UIView()
        mBGBlack.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        
        let mCustomView = UIView()
        mCustomView.backgroundColor = UIColor.white.withAlphaComponent(0.8)
        mCustomView.layer.cornerRadius = 10.0
        
        let mViewImg = UIView()
        mViewImg.clipsToBounds = true
        mViewImg.layer.cornerRadius = 10.0
        
        let mImg = UIImageView()
        mImg.image = UIImage(named: "profilePic")
        
        let mButton = UIButton()
        mButton.backgroundColor = UIColor.clear.withAlphaComponent(0.25)
        mButton.setTitle("GET", for: .normal)
        mButton.layer.cornerRadius = 15.0
        
//        let tempButton = UIButton()
//        mButton.backgroundColor = UIColor.clear.withAlphaComponent(0.25)
//        mButton.setTitle("GET", for: .normal)
//        mButton.layer.cornerRadius = 15.0
        
        if let mWindow = UIApplication.shared.keyWindow {
//            mWindow.addSubview(mBGBlack)
            mWindow.addSubview(mCustomView)
            mWindow.addSubview(mViewImg)
            mViewImg.addSubview(mImg)
            mCustomView.addSubview(mButton)
            
//            mBGBlack.translatesAutoresizingMaskIntoConstraints = false
            mCustomView.translatesAutoresizingMaskIntoConstraints = false
            mViewImg.translatesAutoresizingMaskIntoConstraints = false
            mImg.translatesAutoresizingMaskIntoConstraints = false
            mButton.translatesAutoresizingMaskIntoConstraints = false
            
//            mBGBlack.topAnchor.constraint(equalTo: mWindow.topAnchor).isActive = true
//            mBGBlack.leftAnchor.constraint(equalTo: mWindow.leftAnchor).isActive = true
//            mBGBlack.bottomAnchor.constraint(equalTo: mWindow.bottomAnchor).isActive = true
//            mBGBlack.rightAnchor.constraint(equalTo: mWindow.rightAnchor).isActive = true
            
            mCustomView.centerXAnchor.constraint(equalTo: mWindow.centerXAnchor).isActive = true
            mCustomView.bottomAnchor.constraint(equalTo: mWindow.bottomAnchor, constant: -100.0).isActive = true
            mCustomView.heightAnchor.constraint(equalToConstant: 76.0).isActive = true
            mCustomView.leftAnchor.constraint(equalTo: mWindow.leftAnchor, constant: 8.0).isActive = true
            mCustomView.rightAnchor.constraint(equalTo: mWindow.rightAnchor, constant: -8.0).isActive = true
            
            mViewImg.widthAnchor.constraint(equalToConstant: 60.0).isActive = true
            mViewImg.heightAnchor.constraint(equalToConstant: 60.0).isActive = true
            mViewImg.centerYAnchor.constraint(equalTo: mCustomView.centerYAnchor).isActive = true
            mViewImg.leftAnchor.constraint(equalTo: mCustomView.leftAnchor, constant: 8.0).isActive = true
            
            mImg.centerYAnchor.constraint(equalTo: mViewImg.centerYAnchor).isActive = true
            mImg.centerXAnchor.constraint(equalTo: mViewImg.centerXAnchor).isActive = true
            mImg.widthAnchor.constraint(equalToConstant: 60.0).isActive = true
            mImg.heightAnchor.constraint(equalToConstant: 60.0).isActive = true
            
            mButton.rightAnchor.constraint(equalTo: mCustomView.rightAnchor, constant: -8.0).isActive = true
            mButton.centerYAnchor.constraint(equalTo: mCustomView.centerYAnchor).isActive = true
            mButton.heightAnchor.constraint(equalToConstant: 30.0).isActive = true
            mButton.widthAnchor.constraint(equalToConstant: 70.0).isActive = true
        }
    }
    

}
