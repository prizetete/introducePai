//
//  SettingController.swift
//  Calculator
//
//  Created by Komkrit Siratitanan on 28/1/2562 BE.
//  Copyright © 2562 Komkrit Siratitanan. All rights reserved.
//

import UIKit

class SettingController: UIViewController {
    
    private var mTableview: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.setNavBarColor()
        
        self.mTableview = UITableView()
        self.mTableview.delegate = self
        self.mTableview.dataSource = self
        
        self.mTableview.translatesAutoresizingMaskIntoConstraints = false
        self.mTableview.backgroundColor = .yellow
        self.mTableview.register(SettingCell.self, forCellReuseIdentifier: "SettingCell")
        
        self.view.addSubview(self.mTableview)
        
        self.mTableview.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        self.mTableview.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
        self.mTableview.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true
        self.mTableview.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        
    }
    

}

extension SettingController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 56.0
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 56.0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.mTableview.dequeueReusableCell(withIdentifier: "SettingCell") as! SettingCell
        cell.mLabel.text = "\(indexPath.row)"
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}

class SettingCell: UITableViewCell {
    
    private var mMainView: UIView = UIView()
    var mLabel: UILabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setupTableView()
        self.backgroundColor = .green
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupTableView() {
        self.mMainView.translatesAutoresizingMaskIntoConstraints = false
        self.mLabel.translatesAutoresizingMaskIntoConstraints = false
        
        self.addSubview(self.mMainView)
        self.mMainView.addSubview(self.mLabel)
        
        self.mMainView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        self.mMainView.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        self.mMainView.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        self.mMainView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        
        self.mLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        self.mLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        self.mLabel.widthAnchor.constraint(equalToConstant: 75.0).isActive = true
        self.mLabel.heightAnchor.constraint(equalToConstant: 30.0).isActive = true
        self.mLabel.text = "Hello"
        self.mLabel.textAlignment = .center
    }
    
}
