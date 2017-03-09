//
//  FirstView.swift
//  BluetoothTest
//
//  Created by CBH_Mac on 2017/3/2.
//  Copyright © 2017年 CBH_Mac. All rights reserved.
//

import UIKit

class FirstView : UIView
{
    @IBOutlet var mainView: UIView!
    var buttonFirst:UIButton?
    var buttonSecond:UIButton?
    
    
    override init(frame: CGRect)
    {
        super.init(frame: frame)
        print("init1")
        Bundle.main.loadNibNamed("FirstView", owner: self, options: nil)
    }

    required init?(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder)
        print("init2")
    }
    
    func InitView()
    {
//        mainView = self.viewWithTag(Global.TagMainFirstView)

        self.addSubview(self.mainView)
        
        
        buttonFirst = self.viewWithTag(Global.TagButtonFirst) as? UIButton
        buttonSecond = self.viewWithTag(Global.TagButtonSecond) as? UIButton
        
        buttonFirst?.addTarget(self, action: #selector(OnClick), for: .touchUpInside)
        buttonSecond?.addTarget(self, action: #selector(OnClick), for: .touchUpInside)
        
    }
    
    override func draw(_ rect: CGRect)
    {
        print("draw")
        InitView()
    }
    
    
    func OnClick(_ sender:UIButton)
    {
        switch sender.tag {
        case Global.TagButtonFirst:
            print("firstButton pressed")
        case Global.TagButtonSecond:
            print("secondButton pressed")
            
        default:
            break
        }
    }
}
