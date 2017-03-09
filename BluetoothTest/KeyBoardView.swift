//
//  KeyBoardView.swift
//  BluetoothTest
//
//  Created by CBH_Mac on 2017/3/3.
//  Copyright © 2017年 CBH_Mac. All rights reserved.
//

import UIKit

class KeyBoardView: UIView
{
    @IBOutlet var markButtons: Array<UIButton>!
    @IBOutlet var qwertyButtons: Array<UIButton>!
    @IBOutlet var numericButtons: Array<UIButton>!
    @IBOutlet var functionButtons: Array<UIButton>!
    
    @IBOutlet var qwertyKeyboardView: UIView!
    @IBOutlet var numericKeyboardView: UIView!
    
    var qwertKeyboardConstraint:[NSLayoutConstraint]!
    var numericKeyboardConstraint:[NSLayoutConstraint]!
    
    weak var buttonEventDelegate : ButtonEventDelegate?
    
    var qwertyKeyboardLowerCase = true
    {
        didSet
        {
            for button in qwertyButtons
            {
                let text = button.titleLabel!.text!
                let title = qwertyKeyboardLowerCase ? text.lowercased() : text.uppercased()
                button.setTitle(title, for: UIControlState())
            }
            
            for (index , button) in markButtons.enumerated()
            {
                let title = qwertyKeyboardLowerCase ? Global.marks[index] : Global.marks[index + 10]
                button.setTitle(title, for: UIControlState())
            }

        }
    }
    
    func buttonTapped(_ sender: UIButton)
    {
        guard let title = sender.titleLabel!.text else{ return }
        
        switch title {
        case "switch":
            qwertyKeyboardLowerCase = true
            qwertyKeyboardView.isHidden = !qwertyKeyboardView.isHidden
            numericKeyboardView.isHidden = !numericKeyboardView.isHidden
        case "shift":
            qwertyKeyboardLowerCase = !qwertyKeyboardLowerCase
        default:
            let value = Global.keyCodes[sender.titleLabel!.text!]
            buttonEventDelegate?.button(sender, didTapped: value?.rawValue)
            
        }
    }
    
    override init(frame: CGRect)
    {
        super.init(frame: frame)
        Bundle.main.loadNibNamed("KeyBoardView", owner: self, options: nil)
    }
    
    required init?(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder)
    }
    
    override func draw(_ rect: CGRect)
    {
        self.addSubview(qwertyKeyboardView)
        qwertyKeyboardView.translatesAutoresizingMaskIntoConstraints = false
        qwertKeyboardConstraint =
            [qwertyKeyboardView.leftAnchor.constraint(equalTo: self.leftAnchor),
             qwertyKeyboardView.rightAnchor.constraint(equalTo: self.rightAnchor),
             qwertyKeyboardView.topAnchor.constraint(equalTo: self.topAnchor),
             qwertyKeyboardView.bottomAnchor.constraint(equalTo: self.bottomAnchor)]
        NSLayoutConstraint.activate(qwertKeyboardConstraint)
        qwertyKeyboardView.isHidden = false
        
        
        
        self.addSubview(numericKeyboardView)
        numericKeyboardView.translatesAutoresizingMaskIntoConstraints = false
        numericKeyboardConstraint =
            [numericKeyboardView.leftAnchor.constraint(equalTo: self.leftAnchor),
             numericKeyboardView.rightAnchor.constraint(equalTo: self.rightAnchor),
             numericKeyboardView.topAnchor.constraint(equalTo: self.topAnchor),
             numericKeyboardView.bottomAnchor.constraint(equalTo: self.bottomAnchor)]
        NSLayoutConstraint.activate(numericKeyboardConstraint)
        numericKeyboardView.isHidden = true
        
        configureButtons(qwertyButtons)
        configureButtons(markButtons)
        configureButtons(functionButtons)
        configureButtons(numericButtons)
        
    }
    
    func configureButtons(_ buttons: Array<UIButton>)
    {
        for button in buttons
        {
            button.layer.cornerRadius = 5
            button.layer.masksToBounds = true
            button.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
        }
    }
}
