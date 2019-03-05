//
//  MenuTableViewCell.swift
//  Crowdmap
//
//  Created by Murat Turan on 5.03.2019.
//  Copyright © 2019 Murat Turan. All rights reserved.
//


import UIKit

class MenuTableViewCell: UITableViewCell {
    
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var menuTextLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func update(T:Module){
        self.menuTextLabel.text = ModulesType.getTitleFor(title: T.type)
        self.iconImageView.image = UIImage(named: T.icon)
        self.isUserInteractionEnabled = true
        self.iconImageView.isUserInteractionEnabled = true
        self.menuTextLabel.isEnabled = true
        self.menuTextLabel.isUserInteractionEnabled = true
        if T.type == .logout {
            menuTextLabel.textColor = UIColor.red
        } else {
            menuTextLabel.textColor = .black
        }
    }
    
}
