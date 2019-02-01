//
//  ProfileViewController.swift
//  Calculator
//
//  Created by Komkrit Siratitanan on 28/1/2562 BE.
//  Copyright © 2562 Komkrit Siratitanan. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {
    
    @IBOutlet weak var mProfilePicImg: UIImageView!
    @IBOutlet weak var mLabelName: UITextView!
    @IBOutlet weak var mAddressLabel: UITextView!
    @IBOutlet weak var mGithubView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Profile"
        self.setupView()
        self.setHideBackButton()
        
    }
    
    func setupView() {
        self.mProfilePicImg.image = UIImage(named: "profilePic")
        self.mProfilePicImg.backgroundColor = UIColor.red
        self.mProfilePicImg.layer.cornerRadius = self.mProfilePicImg.frame.height / 2
        self.mProfilePicImg.contentMode = .scaleAspectFill
        self.mProfilePicImg.clipsToBounds = true
        
        self.mLabelName.text = "Komkrit Siratitanan"
        self.mLabelName.backgroundColor = .clear
        
        self.mAddressLabel.text = "Address: 1817/124 Sathupradit rd.\n Bangpongpang Yannawa Bangkok 10120\nE-mail: prizetete1212@gmail.com, Tel: 0942415698"
        self.mAddressLabel.backgroundColor = .clear
        
        self.mGithubView.text = "Github: https://github.com/prizetete"
        self.mGithubView.backgroundColor = .clear
    }
    
    private func setHideBackButton() {
        self.navigationItem.hideBackButton()
        self.navigationItem.addBtnBackToLeft(target: self, action: #selector(self.backAction))
    }
    
    @objc private func backAction() {
        self.navigationController?.popViewController(animated: true)
    }
}
