//
//  FirstView.swift
//  BluetoothTest
//
//  Created by CBH_Mac on 2017/3/2.
//  Copyright © 2017年 CBH_Mac. All rights reserved.
//

import UIKit

class ControlView : UIView
{
    @IBOutlet var mainView: UIView!
    
    @IBOutlet var ControlButtons:Array<UIButton>!
    @IBOutlet var BehaveButtons:Array<UIButton>!
    
    weak var buttonEventdelegate:ButtonEventDelegate?
    
    override init(frame: CGRect)
    {
        super.init(frame: frame)
        Bundle.main.loadNibNamed("ControlView", owner: self, options: nil)
    }

    required init?(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder)
    }
    
    func InitView()
    {
        self.addSubview(self.mainView)
        
        self.mainView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.mainView.leftAnchor.constraint(equalTo: self.leftAnchor),
            self.mainView.rightAnchor.constraint(equalTo: self.rightAnchor),
            self.mainView.topAnchor.constraint(equalTo: self.topAnchor),
            self.mainView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
            ])

        //父类视图加载后才能使用viewWithTag函数
        //buttonFirst = self.viewWithTag(Global.TagButtonFirst) as? UIButton
        //buttonSecond = self.viewWithTag(Global.TagButtonSecond) as? UIButton
        for button1 in self.ControlButtons
        {
            button1.addTarget(self, action: #selector(OnControlClick), for: .touchUpInside)
        }
        
        for button2 in self.BehaveButtons
        {
            button2.addTarget(self, action: #selector(OnBehaveClick), for: .touchUpInside)
        }
        
//        buttonFirst.addTarget(self, action: #selector(OnClick), for: .touchUpInside)
//        buttonSecond.addTarget(self, action: #selector(OnClick), for: .touchUpInside)
        
    }
    
    override func draw(_ rect: CGRect)
    {
        print("draw")
        InitView()
    }
    
    
    func OnControlClick(_ sender:UIButton)
    {
        
        print("Control:+\(sender.titleLabel?.text)")
        if let titleLabel = sender.titleLabel
        {
            let value = Global.keyCodes[titleLabel.text!]
            self.buttonEventdelegate?.button(sender, didTapped: value?.rawValue)
        }
    }
    
    func OnBehaveClick(_ sender:UIButton)
    {
        print("Behave:+\(sender.titleLabel?.text)")
        if let titleLabel = sender.titleLabel
        {
            let value = Global.keyCodes[titleLabel.text!]
            self.buttonEventdelegate?.button(sender, didTapped: value?.rawValue)
        }
    }
}
