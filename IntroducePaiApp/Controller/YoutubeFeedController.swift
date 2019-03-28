//
//  YoutubeFeedController.swift
//  IntroducePaiApp
//
//  Created by Komkrit Siratitanan on 25/2/2562 BE.
//  Copyright © 2562 Komkrit Siratitanan. All rights reserved.
//

import Foundation
import UIKit
import Kingfisher

class YoutubeFeedController: UIViewController, UIGestureRecognizerDelegate {
    
    @IBOutlet weak var mTableView: UITableView!
    private var oAPIDriver: APIDriver!
    private var oYoutube: YoutubeViewModel!
    private var axYoutubeData: [YoutubeViewModel.YoutubeData]!
    private var iNumberRow: Int!
    private var oMenuSheet: Menusheet!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setHideBackButton()
        self.navigationItem.title = "Youtube Feed"
        self.mTableView.delegate = self
        self.mTableView.dataSource = self
        self.mTableView.register(UINib(nibName: "YoutubeFeedCell", bundle: nil), forCellReuseIdentifier: "YoutubeFeedCell")
        self.axYoutubeData = []
        self.iNumberRow = 0
        self.setDefault()
        self.oYoutube = YoutubeViewModel()
        self.oYoutube.delegate = self
        self.oYoutube.getDataYoutube()
//        self.oMenuSheet = Menusheet()
    }
    
    private func setDefault() {
        self.mTableView.separatorStyle = .singleLine
        self.mTableView.separatorInset = UIEdgeInsets.init(top: 0.0, left: 8.0, bottom: 0.0, right: 8.0)
        self.mTableView.separatorColor = UIColor.white.withAlphaComponent(0.25)
        self.mTableView.backgroundColor = UIColor.black.withAlphaComponent(0.9)
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.9)
    }
    
    private func setHideBackButton() {
        self.navigationItem.hideBackButton()
        self.navigationItem.addBtnBackToLeft(target: self, action: #selector(self.backAction))
    }
    
    @objc private func backAction() {
        self.navigationController?.popViewController(animated: true)
    }
}

extension YoutubeFeedController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.iNumberRow
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.mTableView.dequeueReusableCell(withIdentifier: "YoutubeFeedCell") as! YoutubeFeedCell
        
        let oData = self.axYoutubeData[indexPath.row]
        cell.mDescLabel.text = oData.desc
        cell.mTitleLabel.text = oData.title
        
//        let urlProfile = URL(string: oData.img_profile_url)
//        cell.mProfileImgView.kf.setImage(with: urlProfile)
        
//        let longPress = UILongPressGestureRecognizer(target: self, action: #selector(self.longPress))
//        longPress.minimumPressDuration = 0.5
//        cell.mProfileImgView.isUserInteractionEnabled = true
//        cell.mProfileImgView.addGestureRecognizer(longPress)
        
//        let urlCover = URL(string: oData.img_cover)
//        cell.mCoverImage.kf.setImage(with: urlCover)
        let resource = ImageResource(downloadURL: URL(string: oData.img_cover)!, cacheKey: oData.img_cover)
        cell.mCoverImage.kf.setImage(with: resource)
        
        cell.mVDOTimeLabel.text = oData.limit_time
        cell.mVDOTimeLabel.layer.cornerRadius = 7.0
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 325.0
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 325.0
    }
}

extension YoutubeFeedController: YoutubeViewModelDelegate {
    func getDataYoutube(_ axData: [YoutubeViewModel.YoutubeData], _ iNumRow: Int) {
        self.axYoutubeData = axData
        self.iNumberRow = iNumRow
        self.mTableView.reloadData()
    }
}

class Menusheet: UIImageView, UIGestureRecognizerDelegate {
    
    var mContentView: UIView!
    var mBlackBGView: UIView!
    var mEmotionView: UIView!
    
    var bIsShowing: Bool!
    var sender: UIGestureRecognizer!
    var bIsShowAbove: Bool!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        print("img")
        self.bIsShowAbove = true
        self.bIsShowing = false
        self.mBlackBGView = UIView()
        self.mBlackBGView.backgroundColor = UIColor.black.withAlphaComponent(0.75)

        self.mContentView = UIView()
        self.mContentView.backgroundColor = .green
        
        self.mEmotionView = UIView()
        self.mEmotionView.backgroundColor = .white
        self.mEmotionView.layer.cornerRadius = 25.0
        
        self.backgroundColor = .green
        self.clipsToBounds = true
        self.layer.cornerRadius = 17.0
        
        let longPress = UILongPressGestureRecognizer(target: self, action: #selector(self.longPress))
        longPress.minimumPressDuration = 0.5
        self.isUserInteractionEnabled = true
        self.addGestureRecognizer(longPress)

    }
    
    private func isCheckAbove(fYPositioon: CGFloat) {
        let heightNavStatus: CGFloat = UIApplication.shared.statusBarFrame.size.height + UIApplication.shared.statusBarFrame.height
        let TotalHeightCheck = heightNavStatus + 150.0
        self.bIsShowAbove = (fYPositioon - TotalHeightCheck) >= 0
    }
    
    @objc private func longPress(sender: UIGestureRecognizer) {
        self.sender = sender
        switch sender.state {
            case .began:
                print("begin")
                if let mWindow = UIApplication.shared.keyWindow {
                    let senderPositionOnKeyWindow = (self.sender.view as AnyObject).convert(CGPoint.zero, to: mWindow)
                    self.isCheckAbove(fYPositioon: senderPositionOnKeyWindow.y)
                    self.showMenu()
                }
            case .changed:
//                print("is changing")
                break
            case .ended:
                self.dismissView()
            default:break
        }
    }
    
    private func setupView() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.dismissView))
        self.mBlackBGView.addGestureRecognizer(tapGesture)
        
        if let mWindow = UIApplication.shared.keyWindow {
            let senderPositionOnKeyWindow = (self.sender.view as AnyObject).convert(CGPoint.zero, to: mWindow)
            mWindow.addSubview(self.mBlackBGView)
            mWindow.addSubview(self.mContentView)
            self.mContentView.addSubview(self.mEmotionView)
            
            self.mBlackBGView.translatesAutoresizingMaskIntoConstraints = false
            self.mBlackBGView.leftAnchor.constraint(equalTo: mWindow.leftAnchor).isActive = true
            self.mBlackBGView.topAnchor.constraint(equalTo: mWindow.topAnchor).isActive = true
            self.mBlackBGView.rightAnchor.constraint(equalTo: mWindow.rightAnchor).isActive = true
            self.mBlackBGView.bottomAnchor.constraint(equalTo: mWindow.bottomAnchor).isActive = true
            
            if self.bIsShowAbove {
                print("show top")
                self.mContentView.frame = CGRect(x: senderPositionOnKeyWindow.x, y: senderPositionOnKeyWindow.y - 158.0, width: 314.0, height: 150.0)
                self.mEmotionView.translatesAutoresizingMaskIntoConstraints = false
                self.mEmotionView.leftAnchor.constraint(equalTo: self.mContentView.leftAnchor, constant: 8.0).isActive = true
                self.mEmotionView.bottomAnchor.constraint(equalTo: self.mContentView.bottomAnchor, constant: -8.0).isActive = true
                self.mEmotionView.rightAnchor.constraint(equalTo: self.mContentView.rightAnchor, constant: -8.0).isActive = true
                self.mEmotionView.widthAnchor.constraint(equalToConstant: 298.0).isActive = true
                self.mEmotionView.centerXAnchor.constraint(equalTo: self.mContentView.centerXAnchor).isActive = true
                self.mEmotionView.heightAnchor.constraint(equalToConstant: 66.0).isActive = true
            } else {
                print("show bot")
                self.mContentView.frame = CGRect(x: senderPositionOnKeyWindow.x, y: senderPositionOnKeyWindow.y + 42.0, width: 314.0, height: 150.0)
                self.mEmotionView.translatesAutoresizingMaskIntoConstraints = false
                self.mEmotionView.leftAnchor.constraint(equalTo: self.mContentView.leftAnchor, constant: 8.0).isActive = true
                self.mEmotionView.topAnchor.constraint(equalTo: self.mContentView.topAnchor, constant: 8.0).isActive = true
                self.mEmotionView.rightAnchor.constraint(equalTo: self.mContentView.rightAnchor, constant: -8.0).isActive = true
                self.mEmotionView.widthAnchor.constraint(equalToConstant: 298.0).isActive = true
                self.mEmotionView.centerXAnchor.constraint(equalTo: self.mContentView.centerXAnchor).isActive = true
                self.mEmotionView.heightAnchor.constraint(equalToConstant: 66.0).isActive = true
            }
            
            
            
            

        }
        
        
    }
    
    @objc private func dismissView() {
        self.mBlackBGView.removeFromSuperview()
        self.mContentView.removeFromSuperview()
        self.mEmotionView.removeFromSuperview()
        self.bIsShowing = false
    }
    
    
    func showMenu() {
        if !self.bIsShowing {
            self.setupView()
            self.bIsShowing = true
        }
    }
    
    
}
