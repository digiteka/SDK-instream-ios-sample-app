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
            autoplayLabel.text = "PlayMode"
        }
    }
    @IBOutlet private weak var autoPlayPicker: UIPickerView! {
        didSet {
            autoPlayPicker.dataSource = self
            autoPlayPicker.delegate = self
        }
    }
    @IBOutlet private weak var visiblePlayerLabel: UILabel! {
        didSet {
            visiblePlayerLabel.text = "Visible player ?"
        }
    }
    @IBOutlet private weak var visiblePlayerSwitch: UISwitch! {
        didSet {
            visiblePlayerSwitch.addTarget(self, action: #selector(visiblePlayerSwitchValueChanged), for: .valueChanged)
        }
    }
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
            widthLabel.text = "Visible player width (in %)"
        }
    }
    @IBOutlet private weak var widthSlider: UISlider! {
        didSet {
            widthSlider.minimumValue = 0
            widthSlider.maximumValue = 1
            widthSlider.value = 0.5
            widthSlider.addTarget(self, action: #selector(widthSliderValueChanged), for: .valueChanged)
        }
    }
    @IBOutlet private weak var ratioLabel: UILabel! {
        didSet {
            ratioLabel.text = "Visible player ratio (W/H)"
        }
    }
    @IBOutlet private weak var ratioSlider: UISlider! {
        didSet {
            ratioSlider.minimumValue = 0
            ratioSlider.maximumValue = 2
            ratioSlider.value = 1.77
            ratioSlider.addTarget(self, action: #selector(ratioSliderValueChanged), for: .valueChanged)
        }
    }
    @IBOutlet private weak var horizontalMarginLabel: UILabel! {
        didSet {
            horizontalMarginLabel.text = "Horizontal Margin"
        }
    }
    @IBOutlet private weak var horizontalMarginSlider: UISlider! {
        didSet {
            horizontalMarginSlider.minimumValue = 0
            horizontalMarginSlider.maximumValue = 100
            horizontalMarginSlider.value = 20
            horizontalMarginSlider.addTarget(self, action: #selector(horizontalMarginSliderValueChanged), for: .valueChanged)
        }
    }
    @IBOutlet private weak var verticalMarginLabel: UILabel! {
        didSet {
            verticalMarginLabel.text = "Vertical Margin"
        }
    }
    @IBOutlet private weak var verticalMarginSlider: UISlider! {
        didSet {
            verticalMarginSlider.minimumValue = 0
            verticalMarginSlider.maximumValue = 100
            verticalMarginSlider.value = 20
            verticalMarginSlider.addTarget(self, action: #selector(verticalMarginSliderValueChanged), for: .valueChanged)
        }
    }
    @IBOutlet private weak var showDemoUIKitButton: UIButton! {
        didSet {
            showDemoUIKitButton.layer.cornerRadius = 10
        }
    }
    @IBOutlet private weak var showDemoSwiftUIButton: UIButton! {
        didSet {
            showDemoSwiftUIButton.layer.cornerRadius = 10
        }
    }
    
    private var playModes: [PlayMode] = PlayMode.allCases
    private var playMode: PlayMode = .UserClick
    private var positions: [VisiblePlayerPosition] = VisiblePlayerPosition.allCases
    private var position: VisiblePlayerPosition = .TopStart
    
    private func getPlayerWidth() -> WidthProportion {
        return .custom(width: CGFloat(widthSlider.value))
    }
    
    private func getPlayerRatio() -> Ratio {
        return .custom(ratioW_H: ratioSlider.value)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        widthSliderValueChanged()
        ratioSliderValueChanged()
        horizontalMarginSliderValueChanged()
        verticalMarginSliderValueChanged()
    }
    
    @IBAction func openDemoViewController(_ sender: UIButton) {
        let vc = DemoViewController(playMode: playMode, hasVisiblePlayer: visiblePlayerSwitch.isOn, visiblePlayerPosition: position, visiblePlayerWidth: getPlayerWidth(), ratio: getPlayerRatio(), horizontalMargin: CGFloat(horizontalMarginSlider.value), verticalMargin: CGFloat(verticalMarginSlider.value))
         navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func openSwiftUIDemoViewController(_ sender: UIButton) {
        let swiftUIView = DemoMainView(playMode: playMode, playerPosition: position, hasVisiblePlayer: visiblePlayerSwitch.isOn, visiblePlayerPosition: position, visiblePlayerWidth: getPlayerWidth(), ratio: getPlayerRatio(), horizontalMargin: CGFloat(horizontalMarginSlider.value), verticalMargin: CGFloat(verticalMarginSlider.value))
        let hostingController = UIHostingController(rootView: swiftUIView)
        self.navigationController?.pushViewController(hostingController, animated: true)
    }
    
    @objc private func widthSliderValueChanged() {
        widthLabel.text = "Visible player width (in %)\nCurrent value : \(String(format: "%.0f", widthSlider.value * 100)) %"
    }
    
    @objc private func ratioSliderValueChanged() {
        ratioLabel.text = "Visible player ratio (W/H - 16/9 = 1.77)\nCurrent value : \(String(format: "%.2f", ratioSlider.value))"
    }
    
    @objc private func visiblePlayerSwitchValueChanged() {
        visiblePlayerPositionLabel.isHidden = !visiblePlayerSwitch.isOn
        positionPicker.isHidden = !visiblePlayerSwitch.isOn
    }
    
    @objc private func horizontalMarginSliderValueChanged() {
        horizontalMarginLabel.text = "Horizontal Margin\nCurrent value : \(String(format: "%.0f", horizontalMarginSlider.value))"
    }
    
    @objc private func verticalMarginSliderValueChanged() {
        verticalMarginLabel.text = "Vertical Margin\nCurrent value : \(String(format: "%.0f", verticalMarginSlider.value))"
    }
}

//MARK: UIPickerViewDataSource
extension SettingViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView == autoPlayPicker {
            return playModes.count
        }
        return positions.count
    }
}

//MARK: UIPickerViewDelegate
extension SettingViewController: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == autoPlayPicker {
            return playModes[row].rawValue
        }
        return positions[row].rawValue
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == autoPlayPicker {
            playMode = playModes[row]
        } else if pickerView == positionPicker {
            position = positions[row]
        }
    }
}
