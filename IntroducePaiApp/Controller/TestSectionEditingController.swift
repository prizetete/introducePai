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
    private var oPantipViewModel: PantipViewModel!
    private var axDataClub: [PantipViewModel.ClubData]!
    private var axFavoriteClub: [PantipViewModel.ClubData]!
    private var iNumRow: Int!
    private var iNumFavRow: Int!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setHideBackButton()
        self.navigationItem.title = "Edit"
        self.view.backgroundColor = .green
        self.mTableView.dataSource = self
        self.mTableView.delegate = self
        self.mTableView.isEditing = false
        self.mTableView.backgroundColor = .red
        self.axDataClub = []
        self.axFavoriteClub = []
        self.iNumRow = 0
        self.iNumFavRow = 0
        self.setDefault()
        self.oPantipViewModel = PantipViewModel()
        self.oPantipViewModel.delegate = self
        self.oPantipViewModel.getPantipClub()
        print("Order Editing")
    }
    
    private func setDefault() {
        self.mTableView.register(UINib(nibName: "NoDataCell", bundle: nil), forCellReuseIdentifier: "NoDataCell")
        self.mTableView.separatorStyle = .singleLine
        self.mTableView.separatorInset = UIEdgeInsets.init(top: 0.0, left: 8.0, bottom: 0.0, right: 8.0)
        self.mTableView.separatorColor = UIColor.white.withAlphaComponent(0.25)
        self.mTableView.backgroundColor = UIColor.black.withAlphaComponent(0.9)
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.9)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return self.iNumFavRow <= 0 ? 1 : self.iNumFavRow
        } else {
            return self.iNumRow
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return self.setup(iSection: section)
    }
    
    private func setup(iSection: Int) -> UIView {
        let mView = UIView()
        let mLabel = UILabel()
        let mButton = UIButton()
        
        mView.addSubview(mLabel)
        mView.addSubview(mButton)
        
        mView.backgroundColor = .orange
        mLabel.translatesAutoresizingMaskIntoConstraints = false
        mButton.translatesAutoresizingMaskIntoConstraints = false
        
        mLabel.leftAnchor.constraint(equalTo: mView.leftAnchor, constant: 16.0).isActive = true
        mLabel.centerYAnchor.constraint(equalTo: mView.centerYAnchor).isActive = true
        mLabel.text = iSection == 0 ? "ปักหมุด" : "คลับอื่น"
        //        mLabel.textColor = UIColor(named: "#CCCCCC")
        mButton.rightAnchor.constraint(equalTo: mView.rightAnchor, constant: -8.0).isActive = true
        mButton.centerYAnchor.constraint(equalTo: mView.centerYAnchor).isActive = true
        mButton.leftAnchor.constraint(equalTo: mLabel.rightAnchor, constant: 16.0).isActive = true
        mButton.widthAnchor.constraint(equalToConstant: 40.0).isActive = true
        mButton.heightAnchor.constraint(equalToConstant: 20.0).isActive = true
        mButton.setTitle("แก้ไข", for: .normal)
        mButton.titleLabel?.textAlignment = .center
        mButton.isHidden = iSection == 0 ? false : true
        mButton.addTarget(self, action: #selector(self.editOrder), for: .touchUpInside)
        return mView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 36.0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 && self.iNumFavRow <= 0 {
            let cell = self.mTableView.dequeueReusableCell(withIdentifier: "NoDataCell") as! NoDataCell
            cell.selectionStyle = .none
            cell.mLabel.text = self.mTableView.isEditing ? "แตะที่ \"+\" เพื่อปักหมุด" : "ไม่มีคลับที่ปักหมุด แตะที่\"แก้ไข\""
            cell.mLabel.textAlignment = .center
            cell.mLabel.textColor = UIColor.white.withAlphaComponent(0.6)
            cell.mView.backgroundColor = UIColor.black.withAlphaComponent(0.9)
            cell.backgroundColor = UIColor.black.withAlphaComponent(0.9)
            return cell
        } else {
            let cell = self.mTableView.dequeueReusableCell(withIdentifier: "sortCellID") as! sortCell
            var oData: PantipViewModel.ClubData = PantipViewModel.ClubData(sClubID: "", sClubName: "")
            if indexPath.section == 0 {
                if self.axFavoriteClub.indices.contains(indexPath.row) {
                    oData = self.axFavoriteClub[indexPath.row]
                }
            } else {
                if self.axDataClub.indices.contains(indexPath.row) {
                    oData = self.axDataClub[indexPath.row]
                }
            }
            cell.selectionStyle = .none
            cell.mLabel.text = oData.sClubName
            cell.backgroundColor = UIColor.black.withAlphaComponent(0.9)
            cell.mLabel.textColor = UIColor.white.withAlphaComponent(0.6)
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 56.0
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 56.0
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        if indexPath.section == 0 {
            return self.axFavoriteClub.count > 0 ? .delete : .none
        } else {
            return .insert
        }
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .insert {
            let axData = self.axDataClub[indexPath.row]
            self.mTableView.beginUpdates()
            self.iNumRow = self.iNumRow - 1
            self.axDataClub.remove(at: indexPath.row)
            
            self.iNumFavRow = self.iNumFavRow + 1
            self.axFavoriteClub.append(PantipViewModel.ClubData(sClubID: axData.sClubID, sClubName: axData.sClubName))
            if self.iNumFavRow == 1 {
                self.mTableView.reloadRows(at: [IndexPath(row: 0, section: 0)], with: .fade)
            } else {
                self.mTableView.insertRows(at: [IndexPath(row: self.axFavoriteClub.count - 1, section: 0)], with: .fade)
            }
            
            self.mTableView.deleteRows(at: [IndexPath(row: indexPath.row, section: 1)], with: .fade)
            self.mTableView.endUpdates()
        } else {
            self.axFavoriteClub.remove(at: indexPath.row)
            self.iNumFavRow = self.iNumFavRow - 1
            
            self.mTableView.beginUpdates()
            if self.iNumFavRow == 0 {
                self.mTableView.reloadRows(at: [IndexPath(row: 0, section: 0)], with: .fade)
            } else {
                self.mTableView.deleteRows(at: [IndexPath(row: indexPath.row, section: 0)], with: .fade)
            }
            
            self.oPantipViewModel.getPantipClub()
            self.mTableView.endUpdates()
            print("delete")
        }
    }
    
    private func swapOrder() {
        
    }
    
//    func tableView(_ tableView: UITableView, targetIndexPathForMoveFromRowAt sourceIndexPath: IndexPath, toProposedIndexPath proposedDestinationIndexPath: IndexPath) -> IndexPath {
//        print("destination: \(proposedDestinationIndexPath.row) => source: \(sourceIndexPath.row)")
//
//        return proposedDestinationIndexPath
//    }
    
    func tableView(_ tableView: UITableView, shouldIndentWhileEditingRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let axFavData = self.axFavoriteClub[sourceIndexPath.row]
        let axTempData = PantipViewModel.ClubData(sClubID: axFavData.sClubID, sClubName: axFavData.sClubName)
        self.axFavoriteClub.remove(at: sourceIndexPath.row)
        self.axFavoriteClub.insert(axTempData, at: destinationIndexPath.row)
    }
    
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        if indexPath.section == 0 && self.axFavoriteClub.count > 1 {
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

extension TestSectionEditingController: PantipViewModelDelegate {
    func getDataClub(_ axData: [PantipViewModel.ClubData], _ iNumRow: Int) {
        self.axDataClub = axData
        self.iNumRow = iNumRow
        
        for axData in self.axFavoriteClub {
            if let idx = self.axDataClub.index(where: {$0.sClubName == axData.sClubName}) {
                print("remove: \(axData.sClubName)")
                self.axDataClub.remove(at: idx)
                self.iNumRow = self.iNumRow - 1
            }
        }
        
        self.mTableView.reloadSections(IndexSet(integer: 1), with: .fade)
    }
}
