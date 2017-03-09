//
//  MainViewController.swift
//  BluetoothTest
//
//  Created by CBH_Mac on 2017/3/2.
//  Copyright © 2017年 CBH_Mac. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    var controlView:ControlView!
    var keyBoardView:KeyBoardView!
    var bluetoothViewController:BluetoothViewController!
    
    var IsKeyBoardViewHide = true
    {
        didSet
        {
            guard let hideConstraint = self.HideKeyBoardViewConstraint,
                let showConstraint = self.ShowKeyBoardViewConstraint else {return}
            
            NSLayoutConstraint.deactivate([self.IsKeyBoardViewHide ? showConstraint : hideConstraint])
            NSLayoutConstraint.activate([self.IsKeyBoardViewHide ? hideConstraint : showConstraint])
            
            self.keyBoardView.layoutIfNeeded()
            self.controlView.layoutIfNeeded()
        }
    }
    
    var HideKeyBoardViewConstraint:NSLayoutConstraint!
    var ShowKeyBoardViewConstraint:NSLayoutConstraint!
    
    
    
    
    func addControlView()
    {
        self.controlView = ControlView()
        self.controlView.backgroundColor = UIColor.clear
        self.view.addSubview(self.controlView)
        
        self.controlView!.translatesAutoresizingMaskIntoConstraints = false
        let controlviewLayoutContraint :[NSLayoutConstraint] =
            [self.controlView!.leftAnchor.constraint(equalTo: self.view.leftAnchor),
             self.controlView!.rightAnchor.constraint(equalTo: self.view.rightAnchor),
             self.controlView!.topAnchor.constraint(equalTo: self.topLayoutGuide.bottomAnchor),
             self.controlView!.bottomAnchor.constraint(equalTo: self.keyBoardView.topAnchor)]
        NSLayoutConstraint.activate(controlviewLayoutContraint)
        
        self.controlView.buttonEventdelegate = self
        
    }
    
    func addKeyboardView()
    {
        self.keyBoardView = KeyBoardView()
        self.keyBoardView.backgroundColor = UIColor.clear
        self.view.addSubview(self.keyBoardView)
        
        self.HideKeyBoardViewConstraint = self.keyBoardView.topAnchor.constraint(equalTo: self.bottomLayoutGuide.topAnchor)
        self.ShowKeyBoardViewConstraint = self.keyBoardView.bottomAnchor.constraint(equalTo: self.bottomLayoutGuide.topAnchor)
        
        self.keyBoardView!.translatesAutoresizingMaskIntoConstraints = false
        let keyboardviewLayoutContraint:[NSLayoutConstraint] =
            [self.keyBoardView.leftAnchor.constraint(equalTo: self.view.leftAnchor),
             self.keyBoardView.rightAnchor.constraint(equalTo: self.view.rightAnchor),
             self.keyBoardView.heightAnchor.constraint(equalToConstant: Constant.KeyboardViewHeight),
             self.IsKeyBoardViewHide ? self.HideKeyBoardViewConstraint : self.ShowKeyBoardViewConstraint]
        
        NSLayoutConstraint.activate(keyboardviewLayoutContraint)
        self.keyBoardView.buttonEventDelegate = self
        
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "Background")!)
        addKeyboardView()
        
        addControlView()
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
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

extension MainViewController : ButtonEventDelegate
{
    func button(_ button: UIButton, didTapped value: Int?)
    {
        
        switch button.titleLabel!.text! {
        case Assets.keyboardButton:
            self.IsKeyBoardViewHide = !self.IsKeyBoardViewHide
        case Assets.bluetoothButton:
            bluetoothViewController = BluetoothViewController()
            self.present(bluetoothViewController, animated: true, completion: nil)
            break
        default:
            print("button '\(button.titleLabel!.text)' tapped")
            
        }
    }
}
