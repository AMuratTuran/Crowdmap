//
//  DetailsTableViewCell.swift
//  Crowdmap
//
//  Created by Murat Turan on 25.03.2019.
//  Copyright © 2019 Murat Turan. All rights reserved.
//

import UIKit
import ChameleonFramework

class DetailsTableViewCell: UITableViewCell {

    @IBOutlet weak var locationImage: UIImageView!
    @IBOutlet weak var topStackView: UIStackView!
    @IBOutlet weak var numberOfPeopleLabel: UILabel!
    @IBOutlet weak var chairLabel: UILabel!
    @IBOutlet weak var estimatedTimeLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
       
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureCell(location: Buildings){
     self.locationImage.image = location.locationType?.image
     self.numberOfPeopleLabel.text = String(location.numberOfPeople!)
        self.chairLabel.text = String(location.locationType!.capacity - location.numberOfPeople!)
        let crowdedness = Double(location.ringValue!)
        self.estimatedTimeLabel.text = {
            if crowdedness >= 75 {
                return ">10 mins"
            }else if crowdedness < 75 && crowdedness >= 55 {
                return "~6 mins"
            }else if crowdedness < 55 && crowdedness >= 30 {
                return "~3 mins"
            }else if crowdedness < 30 {
                return "<1 min"
            }else {
                return ""
            }
        }()
    }
    
}

