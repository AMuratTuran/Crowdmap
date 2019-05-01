//
//  Location.swift
//  Crowdmap
//
//  Created by Murat Turan on 6.03.2019.
//  Copyright © 2019 Murat Turan. All rights reserved.
//

import UIKit
import CoreLocation

struct Buildings: Decodable {
    
    var ringValue: CGFloat?
    var locationType: LocationType?
    var locationName: String?
    var numberOfPeople: Int?
    var detailedLocationType: detailedLibrary?
    
    private enum CodingKeys: String, CodingKey {
        case locationName = "APName"
        case numberOfPeople = "APCount"
    }
    init() {
        self.ringValue = 0.0
        self.locationType = nil
        self.detailedLocationType = nil
        self.locationName = nil
        self.numberOfPeople = 0
    }
}

