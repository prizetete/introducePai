//
//  NoDataCell.swift
//  IntroducePaiApp
//
//  Created by Komkrit Siratitanan on 27/2/2562 BE.
//  Copyright © 2562 Komkrit Siratitanan. All rights reserved.
//

import UIKit

class NoDataCell: UITableViewCell {

    @IBOutlet weak var mLabel: UILabel!
    @IBOutlet weak var mView: UIView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
