//
//  Device.swift
//  BluetoothTest
//
//  Created by CBH_Mac on 2017/3/6.
//  Copyright © 2017年 CBH_Mac. All rights reserved.
//

import Foundation
import CoreBluetooth

class Device
{
    let peripheral: CBPeripheral
    var advertisementData: [String : AnyObject]?
    
    
    init(_ peripheral: CBPeripheral)
    {
        self.peripheral = peripheral
    }
    
    func writeValue(_ data: Data)
    {
        if let characteristic = peripheral.services?.first?.characteristics?.first
        {
            peripheral.writeValue(data, for: characteristic, type: .withResponse)
        }
    }
    
    static func ==(lhs:Device , rhs:Device) -> Bool
    {
        return rhs.peripheral == lhs.peripheral
    }
    
}


