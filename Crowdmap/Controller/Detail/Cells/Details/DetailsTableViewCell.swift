//
//  DetailsTableViewCell.swift
//  Crowdmap
//
//  Created by Murat Turan on 25.03.2019.
//  Copyright © 2019 Murat Turan. All rights reserved.
//

import UIKit
import ChameleonFramework
import UICircularProgressRing

class DetailsTableViewCell: UITableViewCell {
    
    @IBOutlet weak var locationImage: UIImageView!
    @IBOutlet weak var topStackView: UIStackView!
    @IBOutlet weak var numberOfPeopleLabel: UILabel!
    @IBOutlet weak var chairLabel: UILabel!
    @IBOutlet weak var estimatedTimeLabel: UILabel!
    @IBOutlet weak var progressRing: UICircularProgressRing!
    @IBOutlet weak var numberOfPeopleIV: UIImageView!
    @IBOutlet weak var chairIV: UIImageView!
    @IBOutlet weak var watchIV: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
        numberOfPeopleIV.image = numberOfPeopleIV.image?.withRenderingMode(.alwaysTemplate)
        chairIV.image = chairIV.image?.withRenderingMode(.alwaysTemplate)
        watchIV.image = watchIV.image?.withRenderingMode(.alwaysTemplate)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func configureCell(location: Buildings){
        
        let crowdedness = Double(location.ringValue!)
        let locationType = location.locationType
        var seats = 0
        if locationType == .libraryfirst || locationType == .libraryzero || locationType == .libraryminus || locationType == .librarytwentyfour || locationType == .librarysecond || locationType == .neroSC {
            numberOfPeopleLabel.text = String(Int(Double(location.numberOfPeople!) * 0.7))
            seats = locationType!.capacity - Int(Double(location.numberOfPeople!) * 0.7)
        } else {
            numberOfPeopleLabel.text = String(location.numberOfPeople!)
            seats = locationType!.capacity - location.numberOfPeople!
        }
        if seats < 0 { seats = 0 }
        self.chairLabel.text = String(seats)
        self.locationImage.image = location.locationType?.image
        colorRing(value: CGFloat(crowdedness))
       
        self.estimatedTimeLabel.text = {
            if crowdedness >= 85 {
                return ">10 mins"
            }else if crowdedness < 85 && crowdedness >= 55 {
                return "~6 mins"
            }else if crowdedness < 55 && crowdedness >= 30 {
                return "~3 mins"
            }else if crowdedness < 30 {
                return "<1 min"
            }else {
                return ""
            }
        }()
        progressRing.startProgress(to: CGFloat(crowdedness), duration: 1)
    }
    
    func colorRing(value: CGFloat){
        if value >= 90.0 {
            numberOfPeopleIV.tintColor = UIColor.locationExtraCrowdedColor
            chairIV.tintColor = UIColor.locationExtraCrowdedColor
            watchIV.tintColor = UIColor.locationExtraCrowdedColor
            progressRing.innerRingColor = UIColor.locationExtraCrowdedColor
        } else if value < 90 && value >= 80 {
            numberOfPeopleIV.tintColor = UIColor.locationCrowdedColor
            chairIV.tintColor = UIColor.locationCrowdedColor
            watchIV.tintColor = UIColor.locationCrowdedColor
            progressRing.innerRingColor = UIColor.locationCrowdedColor
        } else if value >= 65 && value < 80 {
            numberOfPeopleIV.tintColor = UIColor.locationMediumColor
            chairIV.tintColor = UIColor.locationMediumColor
            watchIV.tintColor = UIColor.locationMediumColor
            progressRing.innerRingColor = UIColor.locationMediumColor
        } else if value >= 45 && value < 65 {
            numberOfPeopleIV.tintColor = UIColor.locationNormalColor
            chairIV.tintColor = UIColor.locationNormalColor
             watchIV.tintColor = UIColor.locationNormalColor
            progressRing.innerRingColor = UIColor.locationNormalColor
        } else {
            numberOfPeopleIV.tintColor = UIColor.locationAvailableColor
            chairIV.tintColor = UIColor.locationAvailableColor
            watchIV.tintColor = UIColor.locationAvailableColor
            progressRing.innerRingColor = UIColor.locationAvailableColor
        }
    }
    
}

