//
//  HistoryTableViewCell.swift
//  Crowdmap
//
//  Created by Murat Turan on 27.03.2019.
//  Copyright © 2019 Murat Turan. All rights reserved.
//

import UIKit

class HistoryTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        self.backgroundColor = .clear
        self.selectionStyle = .none
        let myAttribute = [ NSAttributedString.Key.font: UIFont(name: "OpenSans-Semibold", size: 18.0)! , NSAttributedString.Key.foregroundColor: UIColor.white]
        let myAttrString = NSAttributedString(string: "Coming Soon...", attributes: myAttribute)
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 50))
        label.center = CGPoint(x: 70, y: 20)
        label.textAlignment = .center
        label.attributedText = myAttrString
        self.addSubview(label)
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
