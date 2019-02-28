//
//  CustomView.swift
//  Calculator
//
//  Created by Komkrit Siratitanan on 30/1/2562 BE.
//  Copyright © 2562 Komkrit Siratitanan. All rights reserved.
//

import UIKit

class CustomView: NSObject, UIGestureRecognizerDelegate {
    
    private var mBGBlack: UIView = {
        let mView = UIView()
        mView.backgroundColor = UIColor.black.withAlphaComponent(0.75)
        return mView
    }()
    
    private var mView: UIView = {
        let mView = UIView()
        mView.backgroundColor = .clear
        return mView
    }()
    
    private var mTouchBar: UIView = {
        let mView = UIView()
        mView.backgroundColor = UIColor.white.withAlphaComponent(0.75)
        mView.layer.cornerRadius = 3.0
        return mView
    }()
    
    private var mContentView: UIView = {
        let mView = UIView()
        mView.backgroundColor = .brown
        mView.layer.cornerRadius = 10.0
        return mView
    }()
    
    private var mCustomTable: CustomTableController!
    
    private var fHeightTop: CGFloat!
    private var bCustomViewIsShowing: Bool!
    
    var ePosition: showPosition = .none
    
    enum showPosition {
        case mid
        case top
        case none
    }
    
    override init() {
        super.init()
        self.mCustomTable = CustomTableController()
        self.mCustomTable.oCustomView = self
        self.fHeightTop = UIApplication.shared.statusBarFrame.height - 4.0
        self.bCustomViewIsShowing = false
    }
    
    private func setupView() {
        self.mBGBlack.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.closeCustomView)))
        let mPanGesScroll = UIPanGestureRecognizer(target: self, action: #selector(self.handleScroll(_:)))
        mPanGesScroll.delegate = self
        self.mView.addGestureRecognizer(mPanGesScroll)
        
        if let mWindow = UIApplication.shared.keyWindow {
            mWindow.addSubview(self.mBGBlack)
            mWindow.addSubview(self.mView)
            self.mView.addSubview(self.mTouchBar)
            self.mView.addSubview(self.mContentView)
            self.mContentView.addSubview(self.mCustomTable)
            
            self.mBGBlack.translatesAutoresizingMaskIntoConstraints = false
            self.mBGBlack.centerYAnchor.constraint(equalTo: mWindow.centerYAnchor).isActive = true
            self.mBGBlack.centerXAnchor.constraint(equalTo: mWindow.centerXAnchor).isActive = true
            self.mBGBlack.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width).isActive = true
            self.mBGBlack.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height).isActive = true
            
            self.mView.frame = CGRect(x: 0.0, y: mWindow.frame.height, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
            
            self.mTouchBar.translatesAutoresizingMaskIntoConstraints = false
            self.mTouchBar.heightAnchor.constraint(equalToConstant: 6.0).isActive = true
            self.mTouchBar.widthAnchor.constraint(equalToConstant: 44.0).isActive = true
            self.mTouchBar.topAnchor.constraint(equalTo: self.mView.topAnchor, constant: 8.0).isActive = true
            self.mTouchBar.centerXAnchor.constraint(equalTo: self.mView.centerXAnchor).isActive = true
            
            self.mContentView.translatesAutoresizingMaskIntoConstraints = false
            self.mContentView.topAnchor.constraint(equalTo: self.mTouchBar.bottomAnchor, constant: 8.0).isActive = true
            self.mContentView.leftAnchor.constraint(equalTo: self.mView.leftAnchor).isActive = true
            self.mContentView.rightAnchor.constraint(equalTo: self.mView.rightAnchor).isActive = true
            self.mContentView.bottomAnchor.constraint(equalTo: self.mView.bottomAnchor).isActive = true
            
            self.mCustomTable.translatesAutoresizingMaskIntoConstraints = false
            self.mCustomTable.topAnchor.constraint(equalTo: self.mContentView.topAnchor).isActive = true
            self.mCustomTable.leftAnchor.constraint(equalTo: self.mContentView.leftAnchor).isActive = true
            self.mCustomTable.rightAnchor.constraint(equalTo: self.mContentView.rightAnchor).isActive = true
            self.mCustomTable.bottomAnchor.constraint(equalTo: self.mContentView.bottomAnchor).isActive = true
        }
    }
    
    func showCustomView() {
        if !self.bCustomViewIsShowing {
            self.setupView()
            self.ePosition = .mid
            self.displayMenu()
        }
    }
    
    func displayMenu(bIsShowMid: Bool = true) {
        UIView.animate(withDuration: 0.5, delay: 0.0, usingSpringWithDamping: 0.66, initialSpringVelocity: 1.0, options: .curveEaseOut, animations: {
            self.mBGBlack.alpha = 1
            self.mView.frame = CGRect(x: 0.0, y: bIsShowMid ? UIScreen.main.bounds.height / 2 : 16.0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        }) { (_) in
            self.ePosition = bIsShowMid ? .mid : .top
            self.bCustomViewIsShowing = true
        }
    }
    
    @objc func closeCustomView() {
        if self.bCustomViewIsShowing {
            UIView.animate(withDuration: 0.5, delay: 0.0, usingSpringWithDamping: 0.66, initialSpringVelocity: 1.0, options: .curveEaseOut, animations: {
                self.mBGBlack.alpha = 0
                self.mView.frame = CGRect(x: 0.0, y: UIScreen.main.bounds.height, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
            }) { (_) in
                self.mBGBlack.removeFromSuperview()
                self.mView.removeFromSuperview()
                self.bCustomViewIsShowing = false
            }
        }
    }
    
    @objc func handleScroll(_ recognizer: UIPanGestureRecognizer) {
        let translation = recognizer.translation(in: self.mBGBlack)
        let velocity = recognizer.velocity(in: self.mBGBlack)
        let fPosY = min(UIScreen.main.bounds.height, max(self.fHeightTop, self.mView.frame.origin.y + translation.y))
        
        
        
        let fTotalTabHeight = UIScreen.main.bounds.height
        let fTabYPosChange = UIScreen.main.bounds.height - self.mView.frame.origin.y
        let fPercentPos = (fTabYPosChange * 100) / fTotalTabHeight
        
        switch recognizer.state {
        case .began:
            if fPercentPos > 75.0 {
                self.ePosition = .top
                self.mCustomTable.mTableView.isScrollEnabled = true
                self.mCustomTable.mTableView.bounces = true
            } else if fPercentPos > 30.0 {
                self.ePosition = .mid
                self.mCustomTable.mTableView.isScrollEnabled = false
                self.mCustomTable.mTableView.bounces = false
            } else {
                self.ePosition = .none
                self.mCustomTable.mTableView.isScrollEnabled = false
                self.mCustomTable.mTableView.bounces = false
            }
        case .changed:
            self.mView.frame.origin.y = fPosY
            recognizer.setTranslation(CGPoint.zero, in: self.mView)
            if fPercentPos > 75.0 {
                self.ePosition = .top
                self.mCustomTable.mTableView.isScrollEnabled = true
                self.mCustomTable.mTableView.bounces = true
            } else if fPercentPos > 30.0 {
                self.ePosition = .mid
                self.mCustomTable.mTableView.isScrollEnabled = false
                self.mCustomTable.mTableView.bounces = false
            } else {
                self.ePosition = .none
                self.mCustomTable.mTableView.isScrollEnabled = false
                self.mCustomTable.mTableView.bounces = false
            }
        case .ended:
            var progressYPositionAfterShortTime = abs(translation.y + velocity.y * 0.2) / self.mView.frame.height
            progressYPositionAfterShortTime = min(1, max(0, progressYPositionAfterShortTime))
            if progressYPositionAfterShortTime > 0.5 {
                if velocity.y >= 0 {
                    self.closeCustomView()
                } else {
                    self.displayMenu()
                }
            } else {
                if fPercentPos > 75.0 {
                    self.displayMenu(bIsShowMid: false)
                } else if fPercentPos > 30.0 {
                    self.displayMenu()
                } else {
                    self.closeCustomView()
                }
            }
        default:
            break
        }
    }
}
