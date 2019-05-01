//
//  StringParser.swift
//  Crowdmap
//
//  Created by KS Murat Turan on 27.04.2019.
//  Copyright © 2019 Murat Turan. All rights reserved.
//

import Foundation

class StringParser {
    func parseLocationName(_ apName: String) -> LocationType{
        let delimiter = "_"
        var token = apName.components(separatedBy: delimiter)
        let locName = token
        if apName.contains("LIB_0") && !apName.contains("24"){
            return LocationType.libraryzero
        }else if apName.contains("LIB_1"){
            return LocationType.libraryfirst
        }else if apName.contains("LIB-1"){
            return LocationType.libraryminus
        }else if apName.contains("LIB_2"){
            return LocationType.librarysecond
        }else if apName.contains("24"){
            return LocationType.librarytwentyfour
        }else if apName.contains("Buz"){
            return LocationType.ice
        }else if apName.contains("Gym") && !apName.contains("Buz"){
            return LocationType.gym
        }else if apName.contains("STDCnt") && !(apName.contains("CafeNero") || apName.contains("Yemekhane")) {
            return LocationType.foodCourt
        }else if apName.contains("STDCnt-1_CafeNero"){
            return LocationType.neroSC
        }else if apName.contains("Yemekhane"){
            return LocationType.yemekhane
        }else if apName.contains("CAS_CaffeNero"){
            return LocationType.neroCAS
        }else {
            return LocationType.error
        }
    }
    
    func detailedParse(_ apName: String) -> detailedLibrary {
        if apName == "LIB_2_On_Orta"{
            return detailedLibrary.LibrarySecondFrontMiddle
        }else if apName == "LIB_2_Sag"{
            return detailedLibrary.LibrarySecondRight
        }else if apName == "LIB_2_Sag_Arka"{
            return detailedLibrary.LibrarySecondRightBack
        }else if apName == "LIB_2_Sag_On"{
            return detailedLibrary.LibrarySecondRightFront
        }else if apName == "LIB_2_Sag_Orta"{
            return detailedLibrary.LibrarySecondRightMiddle
        }else if apName == "LIB_2_Sol"{
            return detailedLibrary.LibrarySecondLeft
        }else if apName == "LIB_2_Sol_Arka"{
            return detailedLibrary.LibrarySecondLeftBack
        }else if apName == "LIB_2_Sol_On"{
            return detailedLibrary.LibrarySecondLeftFront
        }else if apName == "LIB_2_Sol_Orta"{
            return detailedLibrary.LibrarySecondLeftMiddle
        }else{
            return detailedLibrary.error
        }
    }
}

