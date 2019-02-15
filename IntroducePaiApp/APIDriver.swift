//
//  APIDriver.swift
//  IntroducePaiApp
//
//  Created by Komkrit Siratitanan on 1/2/2562 BE.
//  Copyright © 2562 Komkrit Siratitanan. All rights reserved.
//

import Foundation
import Alamofire

class APIDriver {
    private var sBASE_URL: String = "https://service.pantip.com/off45pt/"
    private var sURL: String = ""
    private var axParamenters: [String: Any]?
    private var alamoFireManager: Alamofire.SessionManager
    private var axHeader: [String:String]?
    private var oRequest: Request?
//    private var oParamManage: ParameterManagement?
    private static var checkDoRefreshToken = false
    
    init() {
        self.alamoFireManager = Alamofire.SessionManager.default
        self.alamoFireManager.session.configuration.timeoutIntervalForRequest = 30
        self.alamoFireManager.session.configuration.timeoutIntervalForResource = 30
//        self.oParamManage = ParameterManagement()
    }
    
    internal func setURL(sURL:String) {
        self.sURL = self.sBASE_URL + sURL
    }
    
    internal func setParamenters(axParamenters: NSDictionary?) {
        self.axParamenters = axParamenters as? [String: Any]
    }
    
    internal func getDataRetryMethod(Method: Alamofire.HTTPMethod, callbackSuccess: ((_ axData: Any?) -> Void)?, callbackError: ((_ error: Error?) -> Void)?) {
        self.oRequest = self.alamoFireManager.request(self.sURL, method: Method, parameters: self.axParamenters, encoding: URLEncoding.default, headers: self.axHeader).responseJSON(completionHandler: { (response) in
//            print("Result: ",response)
            callbackSuccess?(response.result.value)
        })
    }
    
}
