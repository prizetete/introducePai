//
//  Pantip.swift
//  IntroducePaiApp
//
//  Created by Komkrit Siratitanan on 26/2/2562 BE.
//  Copyright © 2562 Komkrit Siratitanan. All rights reserved.
//

import Foundation

class Pantip {
    private var oAPIDriver:APIDriver?
    
    init() {
        self.oAPIDriver = APIDriver()
    }
    
    func getClubPantip(callbackSuccess: ((_ axData: Any?) -> Void)?, callbackError: ((_ error: Error?) -> Void)?) {
        self.oAPIDriver?.setFullURL(sURL: "https://api.myjson.com/bins/x6pje")
        self.oAPIDriver?.getDataRetryMethod(Method: .get, callbackSuccess: { (axData) in
            callbackSuccess?(axData)
        }, callbackError: { (error) in
            callbackError?(error)
        })
    }
}
