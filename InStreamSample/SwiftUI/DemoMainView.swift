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
    var hasVisiblePlayer: Bool!
    var visiblePlayerPosition: VisiblePlayerPosition!
    var visiblePlayerWidth: Bool!
    let config = DTKISMainPlayerConfig(zone: Constants.zone,
                                       src: Constants.src,
                                       urlreferrer: Constants.urlreferrer,
                                       gdprconsentstring: Constants.gdprconsentstring,
                                       tagparam: Constants.tagparam,
                                       playMode: .user) //playMode)


    var body: some View {
        //TODO: config
        InStreamScrollVStack(config: config, data: MockData.getMockedData(size: 40), playerInsertPosition: 3) { element in
            Text(element.title)
                .frame(width: 300, height: 300)
                .foregroundColor(Color.black)
                .background(Color.blue)
        }
    }
}

struct MockData {
    var id: UUID = UUID()
    let title: String
    let subtitle: String

    static func getMockedData(size: Int) -> [MockData] {
        (1...size).map { index in
            MockData(title: "TITLE \(index)", subtitle: "SUBTITLE \(index)")
        }
    }
}

#Preview {
    DemoMainView()
}
