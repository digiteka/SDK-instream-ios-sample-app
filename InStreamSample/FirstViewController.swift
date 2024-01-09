//
//  FirstViewController.swift
//  InStreamSample
//
//  Created by ARoussel on 09/01/2024.
//

import Foundation
import InStreamSDK
import UIKit

class FirstViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "Application de démonstration Digiteka"
    }
    
    @IBAction func openClickToPlayVC(_ sender: UIButton) {
        let vc = DemoViewController(autoplay: "0", visiblePlayer: false, visiblePlayerPosition: .BOTTOM_END, visiblePlayerWidth: false)
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func openScrollToPlayVC(_ sender: UIButton) {
        let vc = DemoViewController(autoplay: "2", visiblePlayer: true, visiblePlayerPosition: .TOP_END, visiblePlayerWidth: false)
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func openAutoPlayVC(_ sender: UIButton) {
        let vc = DemoViewController(autoplay: "1", visiblePlayer: true, visiblePlayerPosition: .BOTTOM_START, visiblePlayerWidth: true)
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func goToCustomVC(_ sender: UIButton) {
        let vc = SettingViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
}
