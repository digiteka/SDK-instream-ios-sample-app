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
    @IBOutlet private weak var logoImageView: UIImageView! {
        didSet {
            logoImageView.layer.cornerRadius = 10
            logoImageView.layer.masksToBounds = true
        }
    }
    @IBOutlet private weak var clickToPlayButton: UIButton! {
        didSet {
            clickToPlayButton.layer.cornerRadius = 10
        }
    }
    @IBOutlet private weak var scrollToPlayButton: UIButton! {
        didSet {
            scrollToPlayButton.layer.cornerRadius = 10
        }
    }
    @IBOutlet private weak var autoPlayButton: UIButton! {
        didSet {
            autoPlayButton.layer.cornerRadius = 10
        }
    }
    @IBOutlet private weak var customButton: UIButton! {
        didSet {
            customButton.layer.cornerRadius = 10
        }
    }
    
    static func loadFromNib() -> FirstViewController {
        FirstViewController(nibName: "FirstViewController", bundle: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "Digiteka InStream Demo App"
    }
    
    @IBAction func openClickToPlayVC(_ sender: UIButton) {
        let vc = DemoViewController(playMode: .UserClick, hasVisiblePlayer: false, visiblePlayerPosition: .BottomEnd, visiblePlayerWidth: .w_05, ratio: .wh_16_9)
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func openScrollToPlayVC(_ sender: UIButton) {
        let vc = DemoViewController(playMode: .Scroll, hasVisiblePlayer: true, visiblePlayerPosition: .TopEnd, visiblePlayerWidth: .w_05, ratio: .wh_16_9)
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func openAutoPlayVC(_ sender: UIButton) {
        let vc = DemoViewController(playMode: .Auto, hasVisiblePlayer: true, visiblePlayerPosition: .BottomStart, visiblePlayerWidth: .w_05, ratio: .wh_16_9)
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func goToCustomVC(_ sender: UIButton) {
        let vc = SettingViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
}
