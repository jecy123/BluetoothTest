//
//  BluetoothViewController.swift
//  BluetoothTest
//
//  Created by CBH_Mac on 2017/3/6.
//  Copyright © 2017年 CBH_Mac. All rights reserved.
//

import UIKit
import CoreBluetooth

class BluetoothViewController: UIViewController
{
    @IBOutlet weak var backButtonItem: UIBarButtonItem!
    @IBOutlet weak var refreshButtonItem: UIBarButtonItem!
    @IBOutlet weak var spaceButtonItem: UIBarButtonItem!
    @IBOutlet weak var tableview : UITableView!
    
    var centralManager:CBCentralManager = CBCentralManager()
    var connectedDevice : Device?
    var hasConnected = false
    
    var devices:[Device] = [Device]()
    
    var activityIndicator:UIActivityIndicatorView!
    
    @IBAction func OnBack()
    {
        self.dismiss(animated: true, completion: nil)
    }

    @IBAction func OnRefresh()
    {
        scanforPeripherals()
        print("Refresh Device")
    }
    
    func InitView()
    {
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "Background")!)
        self.spaceButtonItem.setTitleTextAttributes([NSForegroundColorAttributeName:UIColor.white], for : .disabled)
        self.spaceButtonItem.setTitleTextAttributes([NSForegroundColorAttributeName:UIColor.white], for : .normal)
        self.spaceButtonItem.isEnabled = false
        
        activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: .whiteLarge)
        activityIndicator.center = self.view.center
        
        let tapSingle=UITapGestureRecognizer(target:self,action:#selector(stopIndicator))
        tapSingle.numberOfTapsRequired = 1
        tapSingle.numberOfTouchesRequired = 1
        activityIndicator.addGestureRecognizer(tapSingle)
        self.view.addGestureRecognizer(tapSingle)
        
        self.view.addSubview(activityIndicator)
    }
    
    func stopIndicator()
    {
        if activityIndicator.isAnimating
        {
            activityIndicator.stopAnimating()
        }
        if centralManager.isScanning
        {
            centralManager.stopScan()
        }
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        InitView()
        

        tableview.tableFooterView = UIView()
        tableview.separatorInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        tableview.tintColor = UIColor.white
        tableview.backgroundColor = UIColor(patternImage: UIImage(named: Assets.background)!)
        
        centralManager.delegate = self
        
        //scanforPeripherals()
        
        tableview.delegate = self
        tableview.dataSource = self


        // Do any additional setup after loading the view.
    }
    
    
    func scanforPeripherals()
    {
        activityIndicator.startAnimating()
        centralManager.scanForPeripherals(withServices: nil, options: nil)
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

extension BluetoothViewController : CBCentralManagerDelegate
{
    func centralManagerDidUpdateState(_ central: CBCentralManager)
    {
        switch central.state
        {
        case .unknown:
            print("The current state of the central manager is unknown.")
        case .resetting:
            print("The connection with the system service was momentarily lost.")
        case .unsupported:
            print("The platform does not support Bluetooth low energy.")
            //refreshButtonItem.isEnabled = false
        case .unauthorized:
            print("The app is not authorized to use Bluetooth low energy.")
        case .poweredOff:
            print("Bluetooth is currently powered off.")
            
        case .poweredOn:
            print("Bluetooth is currently powered on and available to use.")
            //timer = Timer.scheduledTimer(timeInterval: RescanInterval, target: self, selector: 
            //#selector(scanfForPeripherals), userInfo: nil, repeats: true)
            // Scan for devices if BLE is powered on.
            print("Discovering...")
            central.scanForPeripherals(withServices: nil, options: nil)
        }
    }
    
    func centralManager(_ central: CBCentralManager, didConnect peripheral: CBPeripheral)
    {
        hasConnected = true
        centralManager.stopScan()
        connectedDevice = Device(peripheral)
    }
    
    
    func centralManager(_ central: CBCentralManager, didFailToConnect peripheral: CBPeripheral, error: Error?)
    {
        
    }
    
    func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral, advertisementData: [String : Any], rssi RSSI: NSNumber)
    {
        activityIndicator.stopAnimating()
        let device : Device = Device(peripheral)
        if devices.contains(where: {$0 == device})
        {
            print("Object Already contains in this array")
        }
        else
        {
            device.advertisementData = advertisementData as [String : AnyObject]?
            devices.append(device)
            self.tableview.reloadData()
        }
    }
    
    func centralManager(_ central: CBCentralManager, didDisconnectPeripheral peripheral: CBPeripheral, error: Error?)
    {
        hasConnected = false
        
    }
    

}


extension BluetoothViewController : CBPeripheralDelegate
{
    func peripheral(_ peripheral: CBPeripheral, didDiscoverServices error: Error?)
    {
        print("Did discover service")
        for service in peripheral.services!
        {
            peripheral.discoverCharacteristics(nil, for: service)
        }
    }
    
    func peripheral(_ peripheral: CBPeripheral, didDiscoverCharacteristicsFor service: CBService, error: Error?)
    {
        print("Did discover characteristic")
        for characteristic in service.characteristics!
        {
            peripheral.discoverDescriptors(for: characteristic)
            peripheral.setNotifyValue(true, for: characteristic)
            peripheral.readValue(for: characteristic)
        }
    }
    
    func peripheral(_ peripheral: CBPeripheral, didUpdateValueFor descriptor: CBDescriptor, error: Error?)
    {
    }
    
    func peripheral(_ peripheral: CBPeripheral, didWriteValueFor descriptor: CBDescriptor, error: Error?)
    {
    }
    
    func peripheral(_ peripheral: CBPeripheral, didWriteValueFor characteristic: CBCharacteristic, error: Error?)
    {
    }
}


extension BluetoothViewController : UITableViewDelegate
{

}



extension BluetoothViewController : UITableViewDataSource
{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return devices.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        //connect to the peripheral device
        centralManager.connect(devices[indexPath.row].peripheral, options: nil)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableview.dequeueReusableCell(withIdentifier: "DeviceCell") as? DeviceTableViewCell
        if cell == nil
        {
            cell = DeviceTableViewCell(style: .default, reuseIdentifier: "DeviceCell")
            
        }
        let peripheral = devices[indexPath.row].peripheral
        let name = peripheral.name
        if name == nil || name!.isEmpty
        {
            cell!.nameLabel.text = "[Unnamed]"
        }
        else
        {
            cell!.nameLabel.text = name
        }
        cell!.nameLabel.textColor = UIColor.white
        cell!.rssiLabel.text = "[---]"
        cell!.rssiLabel.textColor = UIColor.white
        cell!.stateLabel.text = "Unconnected"
        cell!.stateLabel.textColor = UIColor.white
        
        cell!.backgroundColor = UIColor(patternImage: UIImage(named: Assets.background)!)
        return cell!
        
    }
    
}
