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

    @IBOutlet weak var haloView: UIView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        let pulsator = Pulsator()
        haloView.layer.addSublayer(pulsator)
        pulsator.backgroundColor = UIColor(red: 1, green: 0, blue: 0, alpha: 1).cgColor
        pulsator.position = haloView.center
        pulsator.numPulse = 5
        pulsator.animationDuration = 5.0
        pulsator.start()
        
        
        
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
