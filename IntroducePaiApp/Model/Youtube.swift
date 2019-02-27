//
//  Youtube.swift
//  IntroducePaiApp
//
//  Created by Komkrit Siratitanan on 25/2/2562 BE.
//  Copyright © 2562 Komkrit Siratitanan. All rights reserved.
//

import Foundation
import UIKit

class Youtube {
    private var oAPIDriver: APIDriver?
    
    init() {
        self.oAPIDriver = APIDriver()
    }
    
    func getFeedYoutubeData(callbackSuccess: ((_ axData: Any?) -> Void)?, callbackError: ((_ error: Error?) -> Void)?) {
//        self.oAPIDriver?.setURL(sURL: "get_club")
//        self.oAPIDriver?.setParamenters(axParamenters: [:], bEncode: true)
//        self.oAPIDriver?.getDataRetryMethod(Method: .post, callbackSuccess: { (axData) in
//            callbackSuccess?(axData)
//        }, callbackError: { (error) in
//            callbackError?(error)
//        })
        self.oAPIDriver?.setFullURL(sURL: "https://api.myjson.com/bins/o4pfe")
        self.oAPIDriver?.getDataRetryMethod(Method: .get, callbackSuccess: { (axData) in
//            print("get Data: \(axData)")
            callbackSuccess!(axData)
        }) { (err) in
//            print("err ja: \(err)")
            callbackError!(err)
        }
    }
}
