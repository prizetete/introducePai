
//: Playground - noun: a place where people can play
import UIKit
import PlaygroundSupport

class LoginViewController: UIViewController {
    
    
    private var oMenusheet: MenuSheet!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        
        self.oMenusheet = MenuSheet()
        
        
//        self.mView = UIView()
//        self.mView.backgroundColor = .white
//        self.view.addSubview(self.mView)
//
//        self.mView.translatesAutoresizingMaskIntoConstraints = false
//
//        self.mView.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
//        self.mView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
//        self.mView.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true
//        self.mView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        
        
        
        
    }
}

class MenuSheet: NSObject, UIGestureRecognizerDelegate {
    
    private var mView: UIView!
    private var mBlackBG: UIView!
    
    override init() {
        super.init()
//        self.mBlackBG = UIView()
        
//        self.setupView()
        let axSearchData: NSDictionary = [
            "username": "123"
        ]
        print(self.setParam(axData: axSearchData))
    }
    
    private func setParam(axData: NSDictionary) -> NSDictionary {
        let axTempData: NSMutableDictionary = [
            "device_id": "PTConfig.shared.UUID",
            "device_os":  "IOS",
            "device_version": "PTConfig.shared.sDeviceVersion",
            "app_version": "PTConfig.shared.sAppVersion",
            "client_id": "PTConfig.shared.sClientID",
            "client_secret": "PTConfig.shared.sClientSecret"
        ]
        for (key, value) in axData {
            axTempData.setValue("\(value)", forKey: "\(key)")
        }
        return axTempData
    }
    
    private func setupView() {
//        print("333")
//        if let mWindow = UIApplication.shared.keyWindow {
//            print("123")
//            mWindow.addSubview(self.mBlackBG)
//
//            self.mBlackBG.backgroundColor = UIColor.red.withAlphaComponent(0.75)
//            self.mBlackBG.translatesAutoresizingMaskIntoConstraints = false
//
//            self.mBlackBG.leftAnchor.constraint(equalTo: mWindow.leftAnchor).isActive = true
//            self.mBlackBG.topAnchor.constraint(equalTo: mWindow.topAnchor).isActive = true
//            self.mBlackBG.rightAnchor.constraint(equalTo: mWindow.rightAnchor).isActive = true
//            self.mBlackBG.bottomAnchor.constraint(equalTo: mWindow.bottomAnchor).isActive = true
//
//        }
        let axxx: NSDictionary = [
            "dwqd": "123213",
            "dll": 123
        ]
//            let addVerifyParam = NSMutableDictionary()
            let axParam: NSMutableDictionary = [
                "device_id": "PTConfig.shared.UUID",
                "device_os":  "IOS",
                "device_version": "PTConfig.shared.sDeviceVersion",
                "app_version": "PTConfig.shared.sAppVersion",
                "client_id": "PTConfig.shared.sClientID",
                "client_secret": "PTConfig.shared.sClientSecret"
            ]
            print(axxx)
            for (key, value) in axxx {
                axParam.setValue("\(value)", forKey: "\(key)")
            }
//
            print(axParam)
//            print(addVerifyParam)

        
        
        
    }
    
}

let myVC = LoginViewController()
PlaygroundPage.current.liveView = myVC

