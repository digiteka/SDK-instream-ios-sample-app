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
    @IBOutlet private weak var autoplayLabel: UILabel! {
        didSet {
            autoplayLabel.text = "playMode (default 0) :\n- 0 : user click\n- 1 : auto\n- 2 : scroll 50%"
        }
    }
    @IBOutlet private weak var autoplayText: UITextField!
    @IBOutlet private weak var visiblePlayerLabel: UILabel! {
        didSet {
            visiblePlayerLabel.text = "Visible player ?"
        }
    }
    @IBOutlet private weak var visiblePlayerSwitch: UISwitch!
    @IBOutlet private weak var visiblePlayerPositionLabel: UILabel! {
        didSet {
            visiblePlayerPositionLabel.text = "Visible player position"
        }
    }
    @IBOutlet private weak var positionPicker: UIPickerView! {
        didSet {
            positionPicker.dataSource = self
            positionPicker.delegate = self
        }
    }
    @IBOutlet private weak var widthLabel: UILabel! {
        didSet {
            widthLabel.text = "Visible player width :"
        }
    }
    @IBOutlet private weak var widthSwitch: UISwitch!
    @IBOutlet private weak var generateDemoViewController: UIButton!
    
    private var positions = ["top_start", "top_end", "bottom_start", "bottom_end"]
    private var position: VisiblePlayerPosition = .TOP_START
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    private func getPlayMode() -> PlayMode {
        switch autoplayText.text {
        case "1":
            return .auto
        case "2":
            return .scroll
        default:
            return .user
        }
    }
    
    @IBAction func openDemoViewController(_ sender: UIButton) {
        let vc = DemoViewController(playMode: getPlayMode(), hasVisiblePlayer: visiblePlayerSwitch.isOn, visiblePlayerPosition: position, visiblePlayerWidth: widthSwitch.isOn)
         navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func openSwiftUIDemoViewController(_ sender: UIButton) {
        let swiftUIView = DemoMainView(playMode: getPlayMode(), playerPosition: position, hasVisiblePlayer: visiblePlayerSwitch.isOn, visiblePlayerPosition: position, visiblePlayerWidth: widthSwitch.isOn)
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
