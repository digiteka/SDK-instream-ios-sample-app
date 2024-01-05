//
//  SettingViewController.swift
//  InStreamSample
//
//  Created by ARoussel on 03/01/2024.
//

import Foundation
import UIKit

class SettingViewController: UIViewController {
    @IBOutlet private weak var generateDemoViewController: UIButton!
    
    
    @IBAction func openDemoViewController(_ sender: UIButton) {
        let vc = DemoViewController()
         self.present(vc, animated: true)
    }
}
