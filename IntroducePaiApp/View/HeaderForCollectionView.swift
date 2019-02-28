//
//  HeaderForCollectionView.swift
//  IntroducePaiApp
//
//  Created by Komkrit Siratitanan on 12/2/2562 BE.
//  Copyright © 2562 Komkrit Siratitanan. All rights reserved.
//

import UIKit

class HeaderForCollectionView: UICollectionReusableView {

    private var mView: UIView!
    var mLabel: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.mView = UIView()
        self.mLabel = UILabel()
        
        self.backgroundColor = .red
        
        self.setupView()
    }
    
    private func setupView() {
        self.addSubview(self.mView)
        self.mView.addSubview(self.mLabel)
        
        self.mView.translatesAutoresizingMaskIntoConstraints = false
        self.mLabel.translatesAutoresizingMaskIntoConstraints = false
        
        self.mView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        self.mView.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        self.mView.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        self.mView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        self.mView.backgroundColor = .yellow
        
        self.mLabel.centerYAnchor.constraint(equalTo: self.mView.centerYAnchor).isActive = true
        self.mLabel.leftAnchor.constraint(equalTo: self.mView.leftAnchor, constant: 16.0).isActive = true
        self.mLabel.rightAnchor.constraint(equalTo: self.mView.rightAnchor, constant: -16.0).isActive = true
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.mView.backgroundColor = .red
    }
    
}
