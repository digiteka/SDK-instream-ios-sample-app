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
            autoplayLabel.text = "PlayMode (default 0) :\n- 0 : user click\n- 1 : auto\n- 2 : scroll 50%"
        }
    }
    @IBOutlet private weak var autoplayText: UITextField! {
        didSet {
            autoplayText.keyboardType = .decimalPad
            autoplayText.returnKeyType = .done
        }
    }
    @IBOutlet private weak var visiblePlayerLabel: UILabel! {
        didSet {
            visiblePlayerLabel.text = "Visible player ?"
        }
    }
    @IBOutlet private weak var visiblePlayerSwitch: UISwitch!
    @IBOutlet private weak var visiblePlayerPositionLabel: UILabel! {
        didSet {
            visiblePlayerPositionLabel.text = "Visible player position :"
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
            widthLabel.text = "Visible player width\n(default 0.5 = 50%) :"
        }
    }
    @IBOutlet private weak var widthText: UITextField! {
        didSet {
            widthText.keyboardType = .decimalPad
            widthText.returnKeyType = .done
        }
    }
    @IBOutlet private weak var ratioLabel: UILabel! {
        didSet {
            ratioLabel.text = "Visible player ratio\n(default 1.77 = 16:9) :"
        }
    }
    @IBOutlet private weak var ratioText: UITextField! {
        didSet {
            ratioText.keyboardType = .decimalPad
            ratioText.returnKeyType = .done
        }
    }
    @IBOutlet private weak var generateDemoViewController: UIButton!
    
    private var positions: [VisiblePlayerPosition] = VisiblePlayerPosition.allCases
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
    
    private func getPlayerWidth() -> WidthProportion {
        guard let text = widthText.text, let widthFloat = Float(text) else {
            return .w_05
        }
        return .custom(width: CGFloat(widthFloat))
    }
    
    private func getPlayerRatio() -> Ratio {
        guard let text = ratioText.text, let ratioFloat = Float(text) else {
            return .wh_16_9
        }
        return .custom(ratioW_H: ratioFloat)
    }
    
    @IBAction func openDemoViewController(_ sender: UIButton) {
        let vc = DemoViewController(playMode: getPlayMode(), hasVisiblePlayer: visiblePlayerSwitch.isOn, visiblePlayerPosition: position, visiblePlayerWidth: getPlayerWidth(), ratio: getPlayerRatio())
         navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func openSwiftUIDemoViewController(_ sender: UIButton) {
        let swiftUIView = DemoMainView(playMode: getPlayMode(), playerPosition: position, hasVisiblePlayer: visiblePlayerSwitch.isOn, visiblePlayerPosition: position, visiblePlayerWidth: getPlayerWidth(), ratio: getPlayerRatio())
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
        return positions[row].rawValue
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        position = positions[row]
    }
}
