//
//  LibraryTwentyFourTableViewCell.swift
//  Crowdmap
//
//  Created by KS Murat Turan on 29.04.2019.
//  Copyright © 2019 Murat Turan. All rights reserved.
//

import UIKit
import Pulsator

class LibraryTwentyFourTableViewCell: UITableViewCell {

    @IBOutlet weak var haloFrontView: UIView!
    @IBOutlet weak var haloBackView: UIView!
    @IBOutlet weak var haloMiddleView: UIView!
    var viewsArray:[UIView] = []
    var groupedAPs: [[Buildings]]?
    override func awakeFromNib() {
        super.awakeFromNib()
        viewsArray = [ haloBackView, haloFrontView, haloMiddleView ]
        assignPulsators()
        self.selectionStyle = .none
    }
    
    func assignPulsators(){
        var count = 0
        viewsArray.forEach { (view) in
            let pulsator = Pulsator()
            view.layer.addSublayer(pulsator)
            colorPulsators(pulsator, count)
            pulsator.numPulse = 5
            pulsator.animationDuration = 5.0
            pulsator.start()
            count += 1
        }
    }
    
    func colorPulsators(_ pulsator: Pulsator, _ count: Int) {
        if self.groupedAPs != nil {
            var ap = self.groupedAPs![1][count]
            
            let value = CGFloat((ap.numberOfPeople!*100) / ap.detailedLocationType!.capacity)
            if value >= 50.0 {
                pulsator.backgroundColor = UIColor.locationCrowdedColor.cgColor
            } else if value >= 35 && value < 50 {
                pulsator.backgroundColor = UIColor.locationNormalColor.cgColor
            }else {
                pulsator.backgroundColor = UIColor.locationAvailableColor.cgColor
            }
            
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
