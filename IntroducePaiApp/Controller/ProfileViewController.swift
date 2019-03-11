//
//  ProfileViewController.swift
//  Calculator
//
//  Created by Komkrit Siratitanan on 28/1/2562 BE.
//  Copyright © 2562 Komkrit Siratitanan. All rights reserved.
//

import UIKit
import MyOwnExt


class ProfileViewController: UIViewController {
    
    @IBOutlet weak var mProfilePicImg: UIImageView!
    @IBOutlet weak var mLabelName: UITextView!
    @IBOutlet weak var mAddressLabel: UITextView!
    @IBOutlet weak var mGithubView: UITextView!
    
    private var mView: UIView = UIView()
    private var mCollectionView: UICollectionView!
    var mPageControl: UIPageControl = UIPageControl()
    
    private var sCellID: String = "PageCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Profile"
        self.setupCollection()
        self.setupView()
        self.setHideBackButton()
    }
    
    private func setupCollection() {
        self.mCollectionView = {
            let layout = UICollectionViewFlowLayout()
            layout.scrollDirection = .horizontal
            layout.minimumLineSpacing = 0.0
            let mCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
            mCollectionView.backgroundColor = .white
            mCollectionView.dataSource = self
            mCollectionView.delegate = self
            mCollectionView.showsHorizontalScrollIndicator = false
            return mCollectionView
        }()
        self.mCollectionView.isPagingEnabled = true
        for iIndex in 0 ..< 3 {
            self.mCollectionView.register(PageCell.self, forCellWithReuseIdentifier: "\(self.sCellID)\(iIndex)")
        }
        
        let selectedIndexPath = IndexPath(item: 0, section: 0)
        self.mCollectionView.selectItem(at: selectedIndexPath, animated: false, scrollPosition: .left)
    }
    
    func configurePageControl() {
        self.mPageControl.numberOfPages = 3
        self.mPageControl.currentPage = 0
        self.mPageControl.alpha = 0.75
        self.mPageControl.tintColor = UIColor.black
        self.mPageControl.pageIndicatorTintColor = UIColor.gray
        self.mPageControl.currentPageIndicatorTintColor = UIColor.black
    }
    
    func setupView() {
        self.configurePageControl()
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
        
        self.view.addSubview(self.mView)
        self.mView.addSubview(self.mCollectionView)
        self.mView.addSubview(self.mPageControl)
        
        self.mView.translatesAutoresizingMaskIntoConstraints = false
        self.mView.backgroundColor = .white
        self.mPageControl.translatesAutoresizingMaskIntoConstraints = false
        self.mCollectionView.translatesAutoresizingMaskIntoConstraints = false
        
        self.mView.topAnchor.constraint(equalTo: self.mGithubView.bottomAnchor, constant: 8.0).isActive = true
        self.mView.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
        self.mView.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true
        self.mView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        
        self.mCollectionView.topAnchor.constraint(equalTo: self.mView.topAnchor).isActive = true
        self.mCollectionView.leftAnchor.constraint(equalTo: self.mView.leftAnchor).isActive = true
        self.mCollectionView.rightAnchor.constraint(equalTo: self.mView.rightAnchor).isActive = true
        self.mCollectionView.bottomAnchor.constraint(equalTo: self.mView.bottomAnchor).isActive = true
        
        self.mPageControl.centerXAnchor.constraint(equalTo: self.mView.centerXAnchor).isActive = true
        self.mPageControl.bottomAnchor.constraint(equalTo: self.mView.bottomAnchor, constant: 0.0).isActive = true
    }
    
    private func setHideBackButton() {
        self.navigationItem.hideBackButton()
        self.navigationItem.addBtnBackToLeft(target: self, action: #selector(self.backAction))
    }
    
    @objc private func backAction() {
        self.navigationController?.popViewController(animated: true)
    }
}

extension ProfileViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = self.mCollectionView.dequeueReusableCell(withReuseIdentifier: "\(self.sCellID)\(indexPath.item)", for: indexPath) as! PageCell
        cell.contentView.backgroundColor = .white
        if indexPath.item == 0 {
            cell.mLabel.text = "Personal Information"
            cell.mTextView.text = "- Date of Birth : 20 May 1994\n- Age               : 24\n- Height           : 171\n- Weight          : 62\n- Nationality    : Thai\n- Sex               : Male\n- Religion        : Buddhism\n"
        } else if indexPath.item == 1 {
            cell.mLabel.text = "Language & Skills"
            cell.mTextView.text = "Thai: Native\nEnglish: Intermediate\nProgramming Language: Swift, HTML, PHP, Javascript(Basic), CSS(Basic)\nTools: Xcode, Git Version Control, MongoDB"
        } else {
            cell.mLabel.text = "Education & Working Experience"
            cell.mTextView.text = "King Mongkut's University Technology North Bangkok (2012-2016)\nBachelor of Science,Computer Science\nGPA: 2.87\n\n- Internship at Internet Marketing Co., Ltd (Pantip.com)\n(May 2015 - Dec 2015)\n - Internet Marketing Co., Ltd (Pantip.com)\n(July 2016 - Present)"
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.mView.frame.width, height: self.mView.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let visibleRect = CGRect(origin: self.mCollectionView.contentOffset, size: self.mCollectionView.bounds.size)
        let visiblePoint = CGPoint(x: visibleRect.midX, y: visibleRect.midY)
        let visibleIndexPath = self.mCollectionView.indexPathForItem(at: visiblePoint)
        self.mPageControl.currentPage = visibleIndexPath?.item ?? 0
    }
    
}

class PageCell: UICollectionViewCell {
    
    private var mView: UIView = UIView()
    var mLabel: UILabel = UILabel()
    var mTextView: UITextView = UITextView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupView()
    }
    
    private func setupView() {
        self.addSubview(self.mView)
        self.mView.addSubview(self.mLabel)
        self.mView.addSubview(self.mTextView)
        
        self.mView.translatesAutoresizingMaskIntoConstraints = false
        self.mView.backgroundColor = .clear //.red
//        self.mView.setBorderColor()
//        self.mView.setYellowBorder(fBorderWidth: 6.0)
        self.mView.setYellowBorder(fBorderWidth: 5.0)
        
        self.mLabel.translatesAutoresizingMaskIntoConstraints = false
        self.mLabel.backgroundColor = .black
        self.mLabel.textAlignment = .center
        self.mLabel.font = UIFont(name: "HelveticNeue-Bold", size: 30.0)
        self.mLabel.textColor = UIColor.white.withAlphaComponent(0.75)
        
        self.mTextView.translatesAutoresizingMaskIntoConstraints = false
        self.mTextView.backgroundColor = .clear //.blue
        self.mTextView.isEditable = false
        
        self.mView.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        self.mView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        self.mView.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        self.mView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        
        self.mLabel.leftAnchor.constraint(equalTo: self.mView.leftAnchor).isActive = true
        self.mLabel.rightAnchor.constraint(equalTo: self.mView.rightAnchor).isActive = true
        self.mLabel.centerXAnchor.constraint(equalTo: self.mView.centerXAnchor).isActive = true
        self.mLabel.heightAnchor.constraint(equalToConstant: 50.0).isActive = true
        
        self.mTextView.topAnchor.constraint(equalTo: self.mView.topAnchor, constant: 58.0).isActive = true
        self.mTextView.leftAnchor.constraint(equalTo: self.mView.leftAnchor, constant: 8.0).isActive = true
        self.mTextView.rightAnchor.constraint(equalTo: self.mView.rightAnchor, constant: -8.0).isActive = true
        self.mTextView.bottomAnchor.constraint(equalTo: self.mView.bottomAnchor, constant: -32.0).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}



