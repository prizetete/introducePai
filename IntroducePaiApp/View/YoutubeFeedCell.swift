//
//  YoutubeFeedCell.swift
//  IntroducePaiApp
//
//  Created by Komkrit Siratitanan on 25/2/2562 BE.
//  Copyright © 2562 Komkrit Siratitanan. All rights reserved.
//

import UIKit

class YoutubeFeedCell: UITableViewCell {

    @IBOutlet weak var mCoverImage: UIImageView!
    @IBOutlet weak var mProfileView: UIView!
    @IBOutlet weak var mProfileImgView: UIImageView!
    @IBOutlet weak var mContentView: UIView!
    @IBOutlet weak var mTitleLabel: UILabel!
    @IBOutlet weak var mDescLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.setDefaultColor()
        // Initialization code
        
    }
    
    private func setDefaultColor() {
        self.selectionStyle = .none
        self.backgroundColor = UIColor.black.withAlphaComponent(0.9)
        self.contentView.backgroundColor = UIColor.black.withAlphaComponent(0.9)
        
        self.mCoverImage.backgroundColor = UIColor.white.withAlphaComponent(0.35)
        self.mProfileView.backgroundColor = UIColor.black.withAlphaComponent(0.9)
        self.mProfileImgView.backgroundColor = UIColor.white.withAlphaComponent(0.35)
        self.mContentView.backgroundColor = .clear
        self.mTitleLabel.backgroundColor = .clear //UIColor.black.withAlphaComponent(0.6)
        self.mDescLabel.backgroundColor = .clear //UIColor.black.withAlphaComponent(0.6)
        
        self.mTitleLabel.textColor = UIColor.white.withAlphaComponent(0.75)
        self.mDescLabel.textColor = UIColor.white.withAlphaComponent(0.35)
        
        self.mTitleLabel.font = UIFont.systemFont(ofSize: 16.0)
        self.mDescLabel.font = UIFont.systemFont(ofSize: 12.0)
        
        self.mTitleLabel.lineBreakMode = .byWordWrapping
        self.mTitleLabel.numberOfLines = 2
        
        self.mDescLabel.lineBreakMode = .byWordWrapping
        self.mDescLabel.numberOfLines = 2
        
        self.mProfileImgView.clipsToBounds = true
        self.mProfileImgView.layer.cornerRadius = 17.0
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
