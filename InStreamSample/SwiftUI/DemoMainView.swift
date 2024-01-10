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
    
    var videoCell: VideoCellView {
        VideoCellView(playMode: playMode)
    }
    
    private var visiblePlayer: VisiblePlayer {
        InStream.shared.initVisiblePlayerWith(config: DTKISVisiblePlayerConfig(playerPosition: .BOTTOM_END, widthPercent: 0.5, ratio: "16:9", horizontalMargin: 20.0, verticalMargin: 30.0), in: self.body as! UIView, scrollView: tableView)
    }
    
    var body: some View {
        ScrollView {
            GeometryReader { geometry in
                Color.clear
                    .frame(height: 1)
                    .onAppear {
                        self.updateScrollOffset(with: geometry)
                    }
                    .onChange(of: geometry.frame(in: .global).minY) { _ in
                        self.updateScrollOffset(with: geometry)
                    }
            }
            VStack(
                alignment: .leading,
                spacing: 10
            ) {
                ForEach(0..<30, id: \.self) { index in
                    if index == 10 {
                        videoCell
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
            .padding()
        }
    }
    
    private func updateScrollOffset(with geometry: GeometryProxy) {
            DispatchQueue.main.async {
                self.scrollOffset = geometry.frame(in: .global).minY
            }
        }
}

#Preview {
    DemoMainView()
}
