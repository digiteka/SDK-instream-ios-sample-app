//
//  VideoCellView.swift
//  InStreamSample
//
//  Created by ARoussel on 09/01/2024.
//

import SwiftUI
import InStreamSDK

struct VideoCellView: View {
    @State var playMode: PlayMode
    
    var body: some View {
        let config = DTKISMainPlayerConfig(zone: Constants.zone, src: Constants.src, urlreferrer: Constants.urlreferrer, gdprconsentstring: Constants.gdprconsentstring, tagparam: Constants.tagparam, playMode: playMode)
        
        if let view = try? InStream.shared.initMainPlayerRepresentable(config: config) {
            view
                .frame(width: 393, height: 350)
        }
    }
}

#Preview {
    VideoCellView(playMode: .user)
}
