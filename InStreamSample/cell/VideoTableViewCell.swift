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
    
    private(set) var videoView: VideoView?
    
    private var isSetup: Bool = false

    func setUp(playMode: PlayMode) {
        if !isSetup {
            do {
                try videoView = InStream.shared.initMainPlayerWith(config: DTKISMainPlayerConfig(zone: Constants.zone, src: Constants.src, urlreferrer: Constants.urlreferrer, gdprconsentstring: Constants.gdprconsentstring, tagparam: Constants.tagparam, playMode: playMode))
            }
            catch {
            }
            videoView?.setIn(containerView: videoViewContainer)
            isSetup = true
        }
    }
    
    func setVideoView(_ videoView: VideoView) {
        self.videoView = videoView
        self.videoView?.setIn(containerView: videoViewContainer)
    }
}
