//
//  PantipViewModel.swift
//  IntroducePaiApp
//
//  Created by Komkrit Siratitanan on 26/2/2562 BE.
//  Copyright © 2562 Komkrit Siratitanan. All rights reserved.
//

import Foundation
protocol PantipViewModelDelegate: NSObjectProtocol {
    func getDataClub(_ axData: [PantipViewModel.ClubData], _ iNumRow: Int)
//    func getDataYoutubeError(error: Error?)
}

extension PantipViewModelDelegate {
    func getDataClub(_ axData: [PantipViewModel.ClubData], _ iNumRow: Int) { }
//    func getDataYoutubeError(error: Error?) { }
}

class PantipViewModel {
    private let oPantip: Pantip?
    weak var delegate: PantipViewModelDelegate?
    
    struct ClubData {
        let sClubID: String
        let sClubName: String
    }
    
    init() {
        self.oPantip = Pantip()
    }
    
    func getPantipClub() {
        self.oPantip?.getClubPantip(callbackSuccess: { (axData) in
            if let axData = axData as? NSDictionary,
                let oTempData = axData["data"] as? NSArray {
                    var axDataClub: [ClubData] = []
                    for axClubList in oTempData {
                        if let axClub = axClubList as? NSDictionary {

                        var sClubID = ""
                        if let iClubIDCheck = axClub["club_id"] as? Int {
                            sClubID = "\(iClubIDCheck)"
                        }

                        var sClubName = ""
                        if let sClubNameCheck = axClub["club_name"] as? String {
                            sClubName = sClubNameCheck
                        }

                        axDataClub.append(ClubData(
                                sClubID: sClubID,
                                sClubName: sClubName
                            ))
                        }
                    }
//                print("axData: \(axDataClub)")
                self.delegate?.getDataClub(axDataClub, axDataClub.count)
            }
        }, callbackError: { (oError) in
            
        })
    }
}
