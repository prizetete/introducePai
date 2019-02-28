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

class YoutubeFeedController: UIViewController {
    
    @IBOutlet weak var mTableView: UITableView!
    private var oAPIDriver: APIDriver!
    private var oYoutube: YoutubeViewModel!
    private var axYoutubeData: [YoutubeViewModel.YoutubeData]!
    private var iNumberRow: Int!
    
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
        
        let urlProfile = URL(string: oData.img_profile_url)
        cell.mProfileImgView.kf.setImage(with: urlProfile)
        
        let urlCover = URL(string: oData.img_cover)
        cell.mCoverImage.kf.setImage(with: urlCover)
        
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
