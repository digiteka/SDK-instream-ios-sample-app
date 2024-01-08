//
//  SettingViewController.swift
//  InStreamSample
//
//  Created by ARoussel on 03/01/2024.
//

import Foundation
import UIKit
import InStreamSDK

class SettingViewController: UIViewController {
    @IBOutlet private weak var autoplayLabel: UILabel!
    @IBOutlet private weak var autoplayText: UITextField!
    @IBOutlet private weak var visiblePlayerLabel: UILabel!
    @IBOutlet private weak var visiblePlayerSwitch: UISwitch!
    @IBOutlet private weak var visiblePlayerPositionLabel: UILabel!
    @IBOutlet private weak var positionPicker: UIPickerView! {
        didSet {
            positionPicker.dataSource = self
            positionPicker.delegate = self
        }
    }
    @IBOutlet private weak var generateDemoViewController: UIButton!
    
    private var positions = ["top_start", "top_end", "bottom_start", "bottom_end"]
    private var position: VisiblePlayerPosition = .TOP_START
    
    override func viewDidLoad() {
        super.viewDidLoad()
        autoplayLabel.text = "autoplay (default 0) :\n- 0 : click utilisateur\n- 1 : automatique\n- 2 : scroll à 50%"
        visiblePlayerLabel.text = "visible player ?"
        visiblePlayerPositionLabel.text = "position du visible player"
    }
    
    
    @IBAction func openDemoViewController(_ sender: UIButton) {
        
        let vc = DemoViewController(autoplay: autoplayText.text ?? "0", visiblePlayer: visiblePlayerSwitch.isOn, visiblePlayerPosition: position)
         navigationController?.pushViewController(vc, animated: true)
    }
}

extension SettingViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return positions.count
    }

}

extension SettingViewController: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return positions[row]
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch row {
        case 0:
            position = .TOP_START
        case 1:
            position = .TOP_END
        case 3:
            position = .BOTTOM_END
        default:
            position = .BOTTOM_START
        }
    }

}
