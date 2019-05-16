//
//  FoldingTableViewCell.swift
//  Crowdmap
//
//  Created by Murat Turan on 17.03.2019.
//  Copyright © 2019 Murat Turan. All rights reserved.
//

import FoldingCell
import UIKit
import UICircularProgressRing
import ChameleonFramework

class FoldingTableViewCell: FoldingCell {
    
    
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var progressRing: UICircularProgressRing!
    @IBOutlet weak var detailProgressRing: UICircularProgressRing!
    @IBOutlet weak var detailLocationLabel: UILabel!
    @IBOutlet weak var FirstContainerView: UIView!
    @IBOutlet weak var SecondContainerView: RotatedView!
    @IBOutlet weak var detailsButton: UIButton!
    @IBOutlet weak var numberOfPeopleLabel: UILabel!
    @IBOutlet weak var avaibleChairsLabel: UILabel!
    @IBOutlet weak var numberOfPeopleIV: UIImageView!
    @IBOutlet weak var chairIV: UIImageView!
    
    var ringValue: CGFloat = 0.0
    var capacity: Int = 1
    var seats: Int = 0
    
    override func awakeFromNib() {
        foregroundView.layer.masksToBounds = false
        foregroundView.backgroundColor = UIColor.mainCellColor
        FirstContainerView.backgroundColor = UIColor.mainCellColor
        SecondContainerView.backgroundColor = UIColor.mainCellColor
        super.awakeFromNib()
        foregroundView.layer.shadowColor = UIColor.black.cgColor
        foregroundView.layer.shadowOffset = CGSize(width: -5.0, height: -5.0)
        foregroundView.layer.shadowOpacity = 0.1
        progressRing.style = .ontop
        progressRing.font = UIFont(name: "OpenSans-Semibold", size: 18)!
        detailProgressRing.style = .dashed(pattern: [3.0 , 7.0])
        detailProgressRing.font = UIFont(name: "OpenSans-Semibold", size: 32)!
        detailProgressRing.innerRingWidth = 10.0
        numberOfPeopleIV.image = numberOfPeopleIV.image?.withRenderingMode(.alwaysTemplate)
        chairIV.image = chairIV.image?.withRenderingMode(.alwaysTemplate)
        
    }
    
    override func animationDuration(_ itemIndex: NSInteger, type: FoldingCell.AnimationType) -> TimeInterval {
        let durations = [0.26, 0.2, 0.2]
        return durations[itemIndex]
    }
    
    func updateCell(location: inout Buildings){
        let count: Int = location.numberOfPeople!
        var locationType: LocationType?
        progressRing.isHidden = false
        switch location.locationName {
        case LocationType.libraryminus.text:
            locationType = LocationType.libraryminus
            capacity = locationType!.capacity
            locationLabel.text = LocationType.libraryminus.displayText
        case LocationType.libraryfirst.text:
            locationType = LocationType.libraryfirst
            capacity = locationType!.capacity
            locationLabel.text = LocationType.libraryfirst.displayText
        case LocationType.librarysecond.text:
            locationType = LocationType.librarysecond
            capacity = locationType!.capacity
            locationLabel.text = LocationType.librarysecond.displayText
        case LocationType.librarytwentyfour.text:
            locationType = LocationType.librarytwentyfour
            capacity = locationType!.capacity
            locationLabel.text = LocationType.librarytwentyfour.displayText
        case LocationType.libraryzero.text:
            locationType = LocationType.libraryzero
            capacity = locationType!.capacity
            locationLabel.text = LocationType.libraryzero.displayText
        case LocationType.neroCAS.text:
            locationType = LocationType.neroCAS
            capacity = locationType!.capacity
            locationLabel.text = LocationType.neroCAS.displayText
        case LocationType.neroSC.text:
            locationType = LocationType.neroSC
            capacity = locationType!.capacity
            locationLabel.text = LocationType.neroSC.displayText
        case LocationType.ice.text:
            locationType = LocationType.ice
            capacity = locationType!.capacity
            locationLabel.text = LocationType.ice.displayText
        case LocationType.foodCourt.text:
            locationType = LocationType.foodCourt
            capacity = locationType!.capacity
            locationLabel.text = LocationType.foodCourt.displayText
        case LocationType.yemekhane.text:
            locationType = LocationType.yemekhane
            capacity = locationType!.capacity
            locationLabel.text = LocationType.yemekhane.displayText
        case LocationType.gym.text:
            locationType = LocationType.gym
            capacity = locationType!.capacity
            locationLabel.text = LocationType.gym.displayText
        default:
            progressRing.isHidden = true
            locationLabel.text = "Location info not available."
        }
        
        location.locationType = locationType
        
  
        ringValue = CGFloat((location.numberOfPeople! * 100) / capacity)
        
       
        detailLocationLabel.text = locationLabel.text
        if locationType == .libraryfirst || locationType == .libraryzero || locationType == .libraryminus || locationType == .librarytwentyfour || locationType == .librarysecond || locationType == .neroSC {
            numberOfPeopleLabel.text = String(Int(Double(location.numberOfPeople!) * 0.7))
            seats = capacity - Int(Double(location.numberOfPeople!) * 0.7)
            ringValue = ringValue * 0.7
        } else {
            numberOfPeopleLabel.text = String(location.numberOfPeople!)
            seats = capacity - location.numberOfPeople!
        }
        if seats < 0 { seats = 0 }
        location.ringValue = ringValue
        avaibleChairsLabel.text = String(seats)
        colorRing(value: ringValue)
    }
    
    private func colorRing(value: CGFloat){
        if value >= 90.0 {
            numberOfPeopleIV.tintColor = UIColor.locationExtraCrowdedColor
            chairIV.tintColor = UIColor.locationExtraCrowdedColor
            progressRing.innerRingColor = UIColor.locationExtraCrowdedColor
            detailProgressRing.innerRingColor = UIColor.locationExtraCrowdedColor
        } else if value < 90 && value >= 80 {
            numberOfPeopleIV.tintColor = UIColor.locationCrowdedColor
            chairIV.tintColor = UIColor.locationCrowdedColor
            progressRing.innerRingColor = UIColor.locationCrowdedColor
            detailProgressRing.innerRingColor = UIColor.locationCrowdedColor
        } else if value >= 65 && value < 80 {
            numberOfPeopleIV.tintColor = UIColor.locationMediumColor
            chairIV.tintColor = UIColor.locationMediumColor
            progressRing.innerRingColor = UIColor.locationMediumColor
            detailProgressRing.innerRingColor = UIColor.locationMediumColor
        } else if value >= 45 && value < 65 {
            numberOfPeopleIV.tintColor = UIColor.locationNormalColor
            chairIV.tintColor = UIColor.locationNormalColor
            progressRing.innerRingColor = UIColor.locationNormalColor
            detailProgressRing.innerRingColor = UIColor.locationNormalColor
        } else {
            numberOfPeopleIV.tintColor = UIColor.locationAvailableColor
            chairIV.tintColor = UIColor.locationAvailableColor
            progressRing.innerRingColor = UIColor.locationAvailableColor
            detailProgressRing.innerRingColor = UIColor.locationAvailableColor
        }
    }
}
