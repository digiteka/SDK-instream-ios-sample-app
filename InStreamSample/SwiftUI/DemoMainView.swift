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
    
    @State private var scrollOffset = CGFloat.zero
    
    @State var visiblePlayerOn: Bool = false
    
    var videoCell: VideoCellView {
        VideoCellView(playMode: playMode)
    }
    
    var visiblePlayerOverlayView: VisiblePlayerOverlayView? {
        do {
            return try InStream.shared.initVisiblePlayerOverlayView(config: DTKISVisiblePlayerConfig(playerPosition: visiblePlayerPosition, widthPercent: visiblePlayerWidth ? 0.5 : 0.33, ratio: "16:9", horizontalMargin: 30, verticalMargin: 20))
        } catch {
            return nil
        }
    }
    
    var body: some View {
        ZStack {
            ScrollView {
                LazyVStack(
                    alignment: .leading,
                    spacing: 10
                ) {
                    ForEach(0..<30, id: \.self) { index in
                        if index == 10 {
                            videoCell
                                .onAppear {
                                    visiblePlayerOn = false
                                }
                                .onDisappear {
                                    visiblePlayerOn = true
                                }
                        } else {
                            HStack {
                                Spacer()
                                Text("Ligne \(index), 1\nLigne \(index), 2\nLigne \(index), 3\nLigne \(index), 4")
                                    .fixedSize(horizontal: false, vertical: true)
                                Spacer()
                            }
                        }
                    }
                }
                .frame(maxWidth: .infinity)
            }
            visiblePlayerOverlayView.opacity(visiblePlayerOn ? 1 : 0)
        }
    }
}

#Preview {
    DemoMainView()
}
