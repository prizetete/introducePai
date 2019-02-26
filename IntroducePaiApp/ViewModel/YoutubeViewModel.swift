//
//  YoutubeViewModel.swift
//  IntroducePaiApp
//
//  Created by Komkrit Siratitanan on 25/2/2562 BE.
//  Copyright © 2562 Komkrit Siratitanan. All rights reserved.
//

import Foundation

protocol YoutubeViewModelDelegate: NSObjectProtocol {
    func getDataYoutube(_ axData: [YoutubeViewModel.YoutubeData], _ iNumRow: Int)
    func getDataYoutubeError(error: Error?)
}

extension YoutubeViewModelDelegate {
    func getDataYoutube(_ axData: [YoutubeViewModel.YoutubeData], _ iNumRow: Int) { }
    func getDataYoutubeError(error: Error?) { }
}

class YoutubeViewModel {
    private let oYoutube: Youtube?
    weak var delegate: YoutubeViewModelDelegate?
    
    struct YoutubeData {
        let desc: String
        let img_cover: String
        let img_profile_url: String
        let limit_time: String
        let title: String
    }
    
    init() {
        self.oYoutube = Youtube()
    }
    
    func getDataYoutube() {
        self.oYoutube?.getFeedYoutubeData(callbackSuccess: { (axData) in
            var axDataYoutube: [YoutubeData] = []
            if let axData = axData as? NSDictionary {
                if let oTempData = axData["data"] as? NSArray {
                    for oData in oTempData {
                        if let oData = oData as? NSDictionary {
                            var sTempDESC: String = ""
                            if let sDesc = oData["desc"] as? String {
                                sTempDESC = sDesc
                            }
                            
                            var sTempImgCover: String = ""
                            if let sImgCover = oData["img_cover"] as? String {
                                sTempImgCover = sImgCover
                            }
                            
                            var sTempImgProfile: String = ""
                            if let sImgProfile = oData["img_profile_url"] as? String {
                                sTempImgProfile = sImgProfile
                            }
                            
                            var sTempLimitTime: String = ""
                            if let sLimitTime = oData["limit_time"] as? String {
                                sTempLimitTime = sLimitTime
                            }
                            
                            var sTempTitle: String = ""
                            if let sTitle = oData["title"] as? String {
                                sTempTitle = sTitle
                            }
                            
                            axDataYoutube.append(YoutubeViewModel.YoutubeData(desc: sTempDESC, img_cover: sTempImgCover, img_profile_url: sTempImgProfile, limit_time: sTempLimitTime, title: sTempTitle))
                        }
                    }
                }
            }
            self.delegate?.getDataYoutube(axDataYoutube, axDataYoutube.count)
        }, callbackError: { (oError) in
//            print("err: \(oError)")
        })
    }
}
