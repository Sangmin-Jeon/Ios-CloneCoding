//
//  ViewController.swift
//  Flashlight
//
//  Created by 전상민 on 2021/02/10.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var switchButton: UIButton!
    @IBOutlet weak var flashimageView: UIImageView!
    
    var isOn = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func SwitchTapped(_ sender: Any) {
        isOn = !isOn
        if isOn == true{
            switchButton.setImage(UIImage(named: "onSwitch"), for: .normal)
            flashimageView.image = UIImage(named: "onBG")
            flashimageView.image = #imageLiteral(resourceName: "onBG")
        }else{
            switchButton.setImage(UIImage(named: "offSwitch"), for: .normal)
            flashimageView.image = UIImage(named: "offBG")
            flashimageView.image = #imageLiteral(resourceName: "offBG")
        }
        
        // 위 코드를 2줄로 줄일수 있다.
        flashimageView.image = isOn ? #imageLiteral(resourceName: "onBG") : #imageLiteral(resourceName: "offBG")
        switchButton.setImage(isOn ? #imageLiteral(resourceName: "onSwitch") : #imageLiteral(resourceName: "offSwitch") , for: .normal)
        
    }
    
}




