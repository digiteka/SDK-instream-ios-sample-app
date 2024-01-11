//
//  VideoCellView.swift
//  InStreamSample
//
//  Created by ARoussel on 09/01/2024.
//

import SwiftUI
import InStreamSDK

struct VideoCellView: View {
    @State var playMode: PlayMode = .user
    
    var mainPlayerView: MainPlayerViewRepresentable? {
        let config = DTKISMainPlayerConfig(zone: Constants.zone, src: Constants.src, urlreferrer: Constants.urlreferrer, gdprconsentstring: Constants.gdprconsentstring, tagparam: Constants.tagparam, playMode: playMode)
        do {
            return try InStream.shared.initMainPlayerRepresentable(config: config)
        } catch {
            return nil
        }
    }
    
    var body: some View {
        mainPlayerView
                .frame(width: 393, height: 350)
    }
}

#Preview {
    VideoCellView(playMode: .user)
}
