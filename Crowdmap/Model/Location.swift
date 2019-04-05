//
//  Location.swift
//  Crowdmap
//
//  Created by Murat Turan on 6.03.2019.
//  Copyright © 2019 Murat Turan. All rights reserved.
//

import UIKit
import CoreLocation

struct Location: Decodable {
    
    var ringValue: CGFloat?
    var locationType: LocationType?
    var locationName: String?
    var numberOfPeople: Int?

    private enum CodingKeys: String, CodingKey {
        case locationName = "Region"
        case numberOfPeople = "crowdedness"
    }
}

