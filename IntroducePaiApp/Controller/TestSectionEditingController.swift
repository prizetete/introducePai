//
//  TestSectionEditingController.swift
//  IntroducePaiApp
//
//  Created by Komkrit Siratitanan on 7/2/2562 BE.
//  Copyright © 2562 Komkrit Siratitanan. All rights reserved.
//

import UIKit

class TestSectionEditingController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var mTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setHideBackButton()
        self.navigationItem.title = "Edit"
        self.view.backgroundColor = .green
        self.mTableView.dataSource = self
        self.mTableView.delegate = self
        self.mTableView.isEditing = false
        self.mTableView.backgroundColor = .red
        print("Order Editing")
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return self.setup(iSection: section)
    }
    
    private func setup(iSection: Int) -> UIView {
        let mView = UIView()
        let mLabel = UILabel()
        let mButton = UIButton()
//
        mView.addSubview(mLabel)
        mView.addSubview(mButton)
//
        mView.backgroundColor = .green
        mLabel.translatesAutoresizingMaskIntoConstraints = false
        mButton.translatesAutoresizingMaskIntoConstraints = false
//
        mLabel.leftAnchor.constraint(equalTo: mView.leftAnchor, constant: 16.0).isActive = true
//        mLabel.rightAnchor.constraint(equalTo: mView.rightAnchor, constant: -16.0).isActive = true
        mLabel.centerYAnchor.constraint(equalTo: mView.centerYAnchor).isActive = true
        mLabel.text = iSection == 0 ? "ปักหมุด" : "คลับอื่น"
//
        mButton.rightAnchor.constraint(equalTo: mView.rightAnchor, constant: 0.0).isActive = true
        mButton.centerYAnchor.constraint(equalTo: mView.centerYAnchor).isActive = true
        mButton.leftAnchor.constraint(equalTo: mLabel.rightAnchor, constant: 16.0).isActive = true
        mButton.widthAnchor.constraint(equalToConstant: 45.0).isActive = true
        mButton.heightAnchor.constraint(equalToConstant: 20.0).isActive = true
        mButton.setTitle("แก้ไข", for: .normal)
        mButton.titleLabel?.textAlignment = .right
        mButton.isHidden = iSection == 0 ? false : true
        mButton.backgroundColor = .brown
        mButton.addTarget(self, action: #selector(self.editOrder), for: .touchUpInside)
        return mView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 36.0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.mTableView.dequeueReusableCell(withIdentifier: "sortCellID") as! sortCell
        cell.mLabel.text = "\(indexPath.row)"
        cell.backgroundColor = .red
        if indexPath.section == 0 {
            cell.contentView.backgroundColor = .red
        } else {
            cell.contentView.backgroundColor = .yellow
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 56.0
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 56.0
    }

    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .none
    }

    func tableView(_ tableView: UITableView, shouldIndentWhileEditingRowAt indexPath: IndexPath) -> Bool {
        return false
    }
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        
        print("source: \(sourceIndexPath.row) => destination: \(destinationIndexPath.row)")
    }
    
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        if indexPath.section == 0 {
            return self.mTableView.isEditing
        }
        return false
    }
    
    private func setHideBackButton() {
        self.navigationItem.hideBackButton()
        self.navigationItem.addBtnBackToLeft(target: self, action: #selector(self.backAction))
    }
    
    @objc func backAction() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func editOrder() {
        self.mTableView.isEditing = !self.mTableView.isEditing
//        self.mTableView.reloadSections(IndexSet(integer: 0), with: .fade)
        self.mTableView.reloadData()
    }
}
