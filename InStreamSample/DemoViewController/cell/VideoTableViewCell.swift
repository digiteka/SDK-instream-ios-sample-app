//
//  VideoTableViewCell.swift
//  InStreamSample
//
//  Created by ARoussel on 03/01/2024.
//

import Foundation
import UIKit
import InStreamSDK

class VideoTableViewCell: UITableViewCell {
    @IBOutlet weak var videoViewContainer: UIView!
    
    private(set) var mainPlayerView: MainPlayerView?
    
    private var isSetup: Bool = false

    func setUp(playMode: PlayMode) {
        if !isSetup {
            do {
                try mainPlayerView = InStream.shared.initMainPlayerWith(config: DTKISMainPlayerConfig(zone: Constants.zone, src: Constants.src, urlreferrer: Constants.urlreferrer, gdprconsentstring: Constants.gdprconsentstring, tagparam: Constants.tagparam, playMode: playMode))
            }
            catch {
            }
            mainPlayerView?.setIn(containerView: videoViewContainer)
            isSetup = true
        }
    }
    
    func setVideoView(_ mainPlayerView: MainPlayerView) {
        self.mainPlayerView = mainPlayerView
        self.mainPlayerView?.setIn(containerView: videoViewContainer)
    }
}
