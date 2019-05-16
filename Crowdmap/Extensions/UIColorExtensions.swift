//
//  UIColorExtensions.swift
//  Crowdmap
//
//  Created by Murat Turan on 5.03.2019.
//  Copyright © 2019 Murat Turan. All rights reserved.
//

import Foundation
import UIKit

extension UIColor{
    
    // MARK: - Custom colors
    open class var kuRadarNavigationBar:UIColor {
        return UIColor(red: 183/255, green: 0/255, blue: 3/255, alpha: 1.0)
    }
    
    open class var kuRadarTabBar:UIColor{
        return UIColor(red: 183/255, green: 0/255, blue: 3/255, alpha: 1.0)
    }
    
    open class var kuRadarTabBarIcon:UIColor{
        return UIColor(red: 183/255, green: 0/255, blue: 3/255, alpha: 1.0)
    }
    
    open class var locationExtraCrowdedColor:UIColor{
        return UIColor(hexString: "#891325")!
    }
    open class var locationCrowdedColor:UIColor{
        return UIColor(hexString: "#DF2F47")!
    }
    
    open class var locationMediumColor:UIColor{
        return UIColor(hexString: "#EA4D22")!
    }
    
    open class var locationNormalColor:UIColor{
        return UIColor(hexString: "#ecb939")!
    }
    
    open class var locationAvailableColor:UIColor{
        return UIColor(hexString: "#20b212")!
    }
    
    open class var mainBackgroundColor:UIColor{
        return UIColor(hexString: "#273337")!
    }
    
    open class var navigationBarColor:UIColor{
        return UIColor(hexString: "#0c171a")!
    }
    
    open class var mainCellColor:UIColor{
        return UIColor(hexString: "#131d21")!
    }
}

