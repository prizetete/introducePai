//
//  ReorderableController.swift
//  IntroducePaiApp
//
//  Created by Komkrit Siratitanan on 6/2/2562 BE.
//  Copyright © 2562 Komkrit Siratitanan. All rights reserved.
//

import UIKit
import Photos
import RealmSwift

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var mAddImageBtn: UIButton!
    @IBOutlet weak var mImageLabel: UILabel!
    @IBOutlet weak var mTableView: UITableView!
    
    static var axImage: [Media] = []
    static var iNumRow: Int = 0
    
    private let realm = try! Realm()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.checkPermissionPhotoOnDevice()
        self.setDefault()
    }
    
    struct Media {
        var id: Int
        var oImg: UIImage
    }
    
    private func setDefault() {
        self.mTableView.delegate = self
        self.mTableView.dataSource = self
        self.mTableView.register(cellImage.self, forCellReuseIdentifier: "cell")
        self.mTableView.layer.cornerRadius = 10.0
        self.mTableView.layer.borderColor = UIColor.blue.cgColor
        self.mTableView.layer.borderWidth = 3.0
        
        
        self.mAddImageBtn.setTitle("Add Image", for: .normal)
        self.mAddImageBtn.backgroundColor = UIColor.blue.withAlphaComponent(0.5)
        self.mAddImageBtn.setTitleColor(.white, for: .normal)
        self.mAddImageBtn.layer.cornerRadius = 10.0
        self.mAddImageBtn.layer.borderColor = UIColor.blue.cgColor
        self.mAddImageBtn.layer.borderWidth = 3.0
        
        self.mImageLabel.backgroundColor = UIColor.red.withAlphaComponent(0.5)
        self.mImageLabel.text = "Image list"
        self.mImageLabel.textColor = .black
        self.mImageLabel.layer.cornerRadius = 10.0
        self.mImageLabel.layer.borderColor = UIColor.red.cgColor
        self.mImageLabel.layer.borderWidth = 3.0
        self.mImageLabel.clipsToBounds = true
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let oRealObject = self.realm.objects(MediaRealm.self)
        ViewController.axImage = []
        ViewController.iNumRow = 0
        let oSortByID = oRealObject.sorted(byKeyPath: "id", ascending: true)
        for oData in oSortByID {
            ViewController.axImage.append(ViewController.Media(id: oData.id, oImg: UIImage(data: oData.image!)!))
            ViewController.iNumRow = ViewController.iNumRow + 1
        }
        self.mTableView.reloadData()
    }
    
    func addImage(iId: Int, oImg: UIImage) {
        ViewController.iNumRow = ViewController.iNumRow + 1
        ViewController.axImage.append(Media(id: iId, oImg: oImg))
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.mTableView.dequeueReusableCell(withIdentifier: "cell") as! cellImage
        cell.selectionStyle = .none
        cell.isSelected = false
        cell.mImage.image = ViewController.axImage[indexPath.row].oImg
        cell.mButton.addTarget(self, action: #selector(self.del), for: .touchUpInside)
        return cell
    }
    
    @objc func del(sender: UIButton) {
        let refreshAlert = UIAlertController(title: "แจ้งเตือน", message: "คุณต้องการลบรูปภาพดังกล่าวใช่หรือไม่?", preferredStyle: UIAlertController.Style.alert)
        
        refreshAlert.addAction(UIAlertAction(title: "ตกลง", style: .default, handler: { (action: UIAlertAction!) in
            let point = self.mTableView.convert(CGPoint.zero, from: sender)
            if let indexPath = self.mTableView.indexPathForRow(at: point) {
                let iTempIDDel = ViewController.axImage[indexPath.row].id
                
                let itemRemove = self.realm.objects(MediaRealm.self).filter("id == \(iTempIDDel)")
                
                try! self.realm.write {
                    self.realm.delete(itemRemove)
                }
                
                ViewController.axImage.remove(at: indexPath.row)
                ViewController.iNumRow = ViewController.iNumRow - 1
                self.mTableView.beginUpdates()
                self.mTableView.deleteRows(at: [indexPath], with: .fade)
                self.mTableView.endUpdates()
            }
        }))
        
        refreshAlert.addAction(UIAlertAction(title: "ยกเลิก", style: .cancel, handler: nil))
        self.present(refreshAlert, animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return ViewController.axImage[indexPath.row].oImg.size.height + 32.0
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return ViewController.axImage[indexPath.row].oImg.size.height + 32.0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ViewController.iNumRow
    }
    
    func checkPermissionPhotoOnDevice() {
        let iStatus = PHPhotoLibrary.authorizationStatus()
        switch iStatus {
        case .authorized: break
            
        case .denied: break
            
        case .notDetermined:
            PHPhotoLibrary.requestAuthorization({ (iUnknowStatus) in
                
            })
        case .restricted: break
            
        }
    }
}


class cellImage: UITableViewCell {
    private var mView: UIView = UIView()
    var mImage: UIImageView = UIImageView()
    var mButton: UIButton = UIButton()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setupView()
    }
    
    func setupView() {
        self.addSubview(self.mView)
        self.mView.addSubview(self.mImage)
        self.mView.addSubview(self.mButton)
        
        self.mView.translatesAutoresizingMaskIntoConstraints = false
        self.mView.backgroundColor = .black
        self.mImage.translatesAutoresizingMaskIntoConstraints = false
        self.mImage.backgroundColor = .red
        self.mImage.clipsToBounds = true
        self.mButton.translatesAutoresizingMaskIntoConstraints = false
        self.mButton.backgroundColor = .red
        
        self.mView.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        self.mView.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        self.mView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        self.mView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        
        self.mImage.topAnchor.constraint(equalTo: self.mView.topAnchor, constant: 16.0).isActive = true
        self.mImage.bottomAnchor.constraint(equalTo: self.mView.bottomAnchor, constant: -16.0).isActive = true
        self.mImage.leftAnchor.constraint(equalTo: self.mView.leftAnchor, constant: 16.0).isActive = true
        self.mImage.rightAnchor.constraint(equalTo: self.mButton.leftAnchor, constant: -16.0).isActive = true
        
        self.mButton.centerYAnchor.constraint(equalTo: self.mView.centerYAnchor).isActive = true
        self.mButton.rightAnchor.constraint(equalTo: self.mView.rightAnchor, constant: -16.0).isActive = true
        self.mButton.widthAnchor.constraint(equalToConstant: 30.0).isActive = true
        self.mButton.heightAnchor.constraint(equalToConstant: 10.0).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
