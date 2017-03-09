//
//  DeviceTableViewCell.swift
//  BluetoothTest
//
//  Created by CBH_Mac on 2017/3/6.
//  Copyright © 2017年 CBH_Mac. All rights reserved.
//

import UIKit

class DeviceTableViewCell: UITableViewCell {

    @IBOutlet weak var nameLabel : UILabel!
    @IBOutlet weak var rssiLabel : UILabel!
    @IBOutlet weak var stateLabel : UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
