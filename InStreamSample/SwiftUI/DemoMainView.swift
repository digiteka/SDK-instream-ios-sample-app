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
        
        let visiblePlayerConfig = DTKISVisiblePlayerConfig(playerPosition: playerPosition, widthPercent: visiblePlayerWidth ? 0.5 : 0.33, ratio: "16:9", horizontalMargin: 20.0, verticalMargin: 20.0)
        
        InStreamScrollVStack(config: config, visiblePlayerConfig: hasVisiblePlayer ? visiblePlayerConfig : nil, data: MockData.getMockedData(size: 40), playerInsertPosition: 10) { element in
            Text("Ligne \(element.index), 1\nLigne \(element.index), 2\nLigne \(element.index), 3\nLigne \(element.index), 4")
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
