//
//  AlbumCollection.swift
//  IntroducePaiApp
//
//  Created by Komkrit Siratitanan on 6/3/2562 BE.
//  Copyright © 2562 Komkrit Siratitanan. All rights reserved.
//

import Foundation
import UIKit
import Photos
import RealmSwift

class AlbumCollection: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, PHPhotoLibraryChangeObserver, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    private var captureSession: AVCaptureSession = AVCaptureSession()
    private var fetchResult: PHFetchResult<PHAsset> = PHFetchResult<PHAsset>()
    private var sCellID: String = "albumCell"
    @IBOutlet weak var mCollectionView: UICollectionView!
    private var imageArray = [UIImage]()
    private var photoSize = CGSize(width: ceil((UIScreen.main.bounds.size.width / 3.0) - 6.0), height: ceil((UIScreen.main.bounds.size.width / 3.0) - 6.0))
    private var oViewController = ViewController()
    private var iNum: Int = 0
    private let realm = try! Realm()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        PHPhotoLibrary.shared().register(self)
        self.setupCollection()
        self.view.backgroundColor = .white
        self.mCollectionView.register(AlbumCell.self, forCellWithReuseIdentifier: "\(self.sCellID)")
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "TakePhoto", style: .done, target: self, action: #selector(self.takePhoto))
        self.grabPhoto()
    }
    
    func photoLibraryDidChange(_ changeInstance: PHChange) {
        if let changeDetails = changeInstance.changeDetails(for: self.fetchResult) {
            self.fetchResult = changeDetails.fetchResultAfterChanges
            DispatchQueue.main.async {
                self.FetchAsset(asset: self.fetchResult)
            }
        }
    }
    
    @objc func takePhoto() {
        AVCaptureDevice.requestAccess(for: AVMediaType.video) { response in
            if response {
                self.openCamera()
            }
        }
    }
    
    func openCamera() {
        self.captureSession.sessionPreset = AVCaptureSession.Preset.low
        let oDevices = AVCaptureDevice.default(.builtInWideAngleCamera, for: AVMediaType.video, position: .back)
        let oPicker = UIImagePickerController()
        oPicker.delegate = self
        oPicker.sourceType = .camera
        present(oPicker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let info = convertFromUIImagePickerControllerInfoKeyDictionary(info)
        
        if let oPhoto = info[convertFromUIImagePickerControllerInfoKey(UIImagePickerController.InfoKey.originalImage)] as? UIImage {
            UIImageWriteToSavedPhotosAlbum(oPhoto, self, nil, nil)
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    func setupCollection() {
        let fNumRow: CGFloat = 4.0
        let fCellWidth = (UIScreen.main.bounds.size.width / fNumRow) - 6.0
        let oLayout = UICollectionViewFlowLayout()
        oLayout.sectionInset = UIEdgeInsets(top: 4, left: 4, bottom: 4, right: 4)
        oLayout.itemSize = CGSize(width: ceil(fCellWidth), height: ceil(fCellWidth))
        oLayout.minimumInteritemSpacing = 4
        oLayout.minimumLineSpacing = 4
        self.mCollectionView!.collectionViewLayout = oLayout
    }
    
    private func grabPhoto() {
        let fetchOptions = PHFetchOptions()
        fetchOptions.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: false)]
        
        self.fetchResult = PHAsset.fetchAssets(with: .image, options: fetchOptions)
        self.FetchAsset(asset: self.fetchResult)
    }
    
    func FetchAsset(asset: PHFetchResult<PHAsset>) {
        self.imageArray.removeAll()
        self.iNum = 0
        
        let requestOptions = PHImageRequestOptions()
        requestOptions.isSynchronous = true
        requestOptions.deliveryMode = .highQualityFormat
        
        if asset.count > 0 {
            for i in 0..<asset.count {
                PHImageManager.default().requestImage(for: fetchResult.object(at: i), targetSize: CGSize(width: 200, height: 200), contentMode: .aspectFill, options: requestOptions) { (image, error) in
                    self.imageArray.append(image!)
                    self.iNum = self.iNum + 1
                }
            }
        }
        print("image: \(self.imageArray.count)")
        self.mCollectionView.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.iNum
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = self.mCollectionView.dequeueReusableCell(withReuseIdentifier: self.sCellID, for: indexPath) as! AlbumCell
        if self.imageArray.indices.contains(indexPath.item) {
            cell.mImage.image = self.imageArray[indexPath.item]
        }
        return cell
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func incrementID() -> Int {
        return (self.realm.objects(MediaRealm.self).max(ofProperty: "id") as Int? ?? 0) + 1
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let oTempImg = self.imageWithImage(sourceImage: self.imageArray[indexPath.item], scaledToWidth: 300.0)
        let ooo = self.realm.objects(MediaRealm.self).isEmpty
        let oMediaRealm = MediaRealm()
        oMediaRealm.id = incrementID()
        oMediaRealm.image = oTempImg.jpegData(compressionQuality: 0.75)!
        try! self.realm.write {
            if ooo {
                self.realm.create(MediaRealm.self, value: oMediaRealm)
            } else {
                self.realm.add(oMediaRealm)
            }
        }
        
        
        print(self.realm.objects(MediaRealm.self))
        
        
        self.navigationController?.popViewController(animated: true)
    }
    
    public func imageWithImage (sourceImage:UIImage, scaledToWidth: CGFloat) -> UIImage {
        let oldWidth = sourceImage.size.width
        let scaleFactor = scaledToWidth / oldWidth
        
        let newHeight = sourceImage.size.height * scaleFactor
        let newWidth = oldWidth * scaleFactor
        
        UIGraphicsBeginImageContext(CGSize(width:newWidth, height:newHeight))
        sourceImage.draw(in: CGRect(x:0, y:0, width:newWidth, height:newHeight))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage!
    }
    
}

class AlbumCell: UICollectionViewCell {
    
    let mImage: UIImageView = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupCell()
    }
    
    private func setupCell() {
        self.addSubview(self.mImage)
        
        self.mImage.translatesAutoresizingMaskIntoConstraints = false
        
        self.mImage.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        self.mImage.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        self.mImage.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        self.mImage.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

fileprivate func convertFromUIImagePickerControllerInfoKeyDictionary(_ input: [UIImagePickerController.InfoKey: Any]) -> [String: Any] {
    return Dictionary(uniqueKeysWithValues: input.map {key, value in (key.rawValue, value)})
}

fileprivate func convertFromUIImagePickerControllerInfoKey(_ input: UIImagePickerController.InfoKey) -> String {
    return input.rawValue
}

class MediaRealm: Object {
    @objc dynamic var id: Int = 0
    @objc dynamic var image: Data? = nil
}
