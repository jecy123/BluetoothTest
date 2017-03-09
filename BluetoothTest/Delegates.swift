//
//  Delegates.swift
//  BluetoothTest
//
//  Created by CBH_Mac on 2017/3/6.
//  Copyright © 2017年 CBH_Mac. All rights reserved.
//

import Foundation
import UIKit

protocol ButtonEventDelegate : class{
    func button(_ button :UIButton,didTapped value:Int?)
}
