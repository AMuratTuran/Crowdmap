//
//  HomeTableViewCell.swift
//  Crowdmap
//
//  Created by Murat Turan on 5.03.2019.
//  Copyright © 2019 Murat Turan. All rights reserved.
//

import UIKit

class HomeTableViewCell: UITableViewCell {
    
    @IBOutlet weak var locationNameLabel: UILabel!
    @IBOutlet weak var locationImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureCell()
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configureCell(){
        locationImageView.layer.borderWidth = 2
        locationImageView.layer.borderColor = UIColor.kuRadarTabBar.cgColor
        locationImageView.layer.cornerRadius = 10
        locationImageView.layer.masksToBounds = true
    }
    
}
