//
//  MapTableViewCell.swift
//  Crowdmap
//
//  Created by Murat Turan on 25.03.2019.
//  Copyright © 2019 Murat Turan. All rights reserved.
//

import UIKit
import Pulsator

class MapTableViewCell: UITableViewCell {
    
    @IBOutlet weak var haloRightFrontView: UIView!
    @IBOutlet weak var haloRightMiddleView: UIView!
    @IBOutlet weak var haloRightBackView: UIView!
    @IBOutlet weak var haloLeftMiddleView: UIView!
    @IBOutlet weak var haloLeftBackView: UIView!
    @IBOutlet weak var haloLeftFrontView: UIView!
    @IBOutlet weak var haloFrontMiddleView: UIView!
    @IBOutlet weak var haloRightView: UIView!
    @IBOutlet weak var haloLeftView: UIView!
    var viewsArray:[UIView] = []
    var location: Buildings?
    var groupedAPs: [[Buildings]]?
    var isFirstTime:Bool = true
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        viewsArray = [ haloFrontMiddleView, haloLeftView, haloLeftBackView, haloLeftFrontView, haloLeftMiddleView, haloRightView, haloRightBackView, haloRightFrontView, haloRightMiddleView ]
        self.selectionStyle = .none
    }
    
    func assignPulsators(){
        if isFirstTime{
            var count = 0
            viewsArray.forEach { (view) in
                let pulsator = Pulsator()
                view.layer.addSublayer(pulsator)
                colorPulsators(pulsator, count)
                pulsator.numPulse = 5
                pulsator.animationDuration = 5.0
                pulsator.start()
                if groupedAPs != nil {
                    if groupedAPs!.count < 9 {
                        if count != 8{
                            count += 1
                        }
                    }
                }
            }
        }
            isFirstTime = false
        }

    
    func colorPulsators(_ pulsator: Pulsator, _ count: Int) {
        if self.groupedAPs != nil {
            var ap = self.groupedAPs![0][count]
            
            let value = CGFloat((ap.numberOfPeople!*100) / ap.detailedLocationType!.capacity)
            if value >= 70.0 {
                pulsator.backgroundColor = UIColor.locationCrowdedColor.cgColor
            } else if value >= 35 && value < 70 {
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
