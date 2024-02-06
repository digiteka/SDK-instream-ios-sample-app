//
//  DemoMainView.swift
//  InStreamSample
//
//  Created by ARoussel on 09/01/2024.
//

import SwiftUI
import InStreamSDK

struct DemoMainView: View {
    var playMode: PlayMode = .user
    var playerPosition: VisiblePlayerPosition!
    var hasVisiblePlayer: Bool!
    var visiblePlayerPosition: VisiblePlayerPosition!
    var visiblePlayerWidth: Bool!

    var body: some View {
        let config = DTKISMainPlayerConfig(zone: Constants.zone,
                                           src: Constants.src,
                                           urlreferrer: Constants.urlreferrer,
                                           gdprconsentstring: Constants.gdprconsentstring,
                                           tagparam: Constants.tagparam,
                                           playMode: playMode)
        
        let visiblePlayerConfig = DTKISVisiblePlayerConfig(playerPosition: playerPosition, widthPercent: .w_033, ratio: .wh_16_9, horizontalMargin: 20.0, verticalMargin: 20.0)
        
        InStreamScrollVStack(config: config, visiblePlayerConfig: hasVisiblePlayer ? visiblePlayerConfig : nil, data: MockData.getMockedData(size: 40), playerInsertPosition: 10) { element in
            Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.")
                .fixedSize(horizontal: false, vertical: true)
                .padding(.leading)
        }
    }
}

struct MockData {
    var id: UUID = UUID()
    let index: Int
    let title: String
    let subtitle: String

    static func getMockedData(size: Int) -> [MockData] {
        (1...size).map { index in
            MockData(index: index, title: "TITLE \(index)", subtitle: "SUBTITLE \(index)")
        }
    }
}

#Preview {
    DemoMainView()
}
