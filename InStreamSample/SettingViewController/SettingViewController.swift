//
//  SettingViewController.swift
//  InStreamSample
//
//  Created by ARoussel on 03/01/2024.
//

import Foundation
import UIKit
import InStreamSDK
import SwiftUI

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
    @IBOutlet private weak var widthLabel: UILabel!
    @IBOutlet private weak var widthSwitch: UISwitch!
    @IBOutlet private weak var percent50Label: UILabel!
    @IBOutlet private weak var generateDemoViewController: UIButton!
    
    private var positions = ["top_start", "top_end", "bottom_start", "bottom_end"]
    private var position: VisiblePlayerPosition = .TOP_START
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        autoplayLabel.text = "playMode (default 0) :\n- 0 : click utilisateur\n- 1 : automatique\n- 2 : scroll à 50%"
        visiblePlayerLabel.text = "visible player ?"
        visiblePlayerPositionLabel.text = "position du visible player"
        widthLabel.text = "largeur du visible player :   33%"
        percent50Label.text = "50%"
    }
    
    
    @IBAction func openDemoViewController(_ sender: UIButton) {
        let vc = DemoViewController(playMode: autoplayText.text ?? "0", hasVisiblePlayer: visiblePlayerSwitch.isOn, visiblePlayerPosition: position, visiblePlayerWidth: widthSwitch.isOn)
         navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func openSwiftUIDemoViewController(_ sender: UIButton) {
        var playMode: PlayMode = .user
        switch autoplayText.text {
        case "1":
            playMode = .auto
        case "2":
            playMode = .scroll
        default:
            playMode = .user
        }
        let swiftUIView = DemoMainView(playMode: playMode, hasVisiblePlayer: visiblePlayerSwitch.isOn, visiblePlayerPosition: position, visiblePlayerWidth: widthSwitch.isOn)
        let hostingController = UIHostingController(rootView: swiftUIView)
        self.navigationController?.pushViewController(hostingController, animated: true)
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
