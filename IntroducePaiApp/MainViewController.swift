//
//  MainViewController.swift
//  Calculator
//
//  Created by Komkrit Siratitanan on 28/1/2562 BE.
//  Copyright © 2562 Komkrit Siratitanan. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        self.navigationItem.title = "MainMenu"
        self.navigationController?.setNavBarColor()
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.orange]
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}


import Foundation
import UIKit

extension UINavigationItem {
    
    func hideBackButton() {
        self.backBarButtonItem = UIBarButtonItem(title:"", style:.plain, target:nil, action:nil)
        self.backBarButtonItem?.isEnabled = false
        self.hidesBackButton = true
    }
    
    func addBtnBackToLeft(target: AnyObject?, action: Selector) {
        let iconBackImage = UIImage(named: "ic-topbar-backpage") //!.alpha(0.6).withRenderingMode(.alwaysOriginal)
        let frameBtn = CGRect(x: 0, y: 0, width: 24, height: 24)
        let closeButton = UIButton(frame: frameBtn)
        closeButton.setBackgroundImage(iconBackImage, for: .normal)
        closeButton.addTarget(target, action: action, for:.touchUpInside)
        closeButton.transform = CGAffineTransform(translationX: -5, y: 4)
        let frameBtnContainer = CGRect(x: 0, y: 0, width: 40, height: 30)
        let closeButtonContainer = UIView(frame: frameBtnContainer)
        let tap = UITapGestureRecognizer(target: target, action: action)
        closeButtonContainer.isUserInteractionEnabled = true
        closeButtonContainer.addGestureRecognizer(tap)
        closeButtonContainer.addSubview(closeButton)
        let closeButtonItem = UIBarButtonItem(customView: closeButtonContainer)
        self.leftBarButtonItems = [closeButtonItem]
    }
    
}

extension UINavigationController {
    func setNavBarColor() {
        self.navigationBar.barTintColor = UIColor.brown
        self.navigationBar.isTranslucent = false
    }
}
