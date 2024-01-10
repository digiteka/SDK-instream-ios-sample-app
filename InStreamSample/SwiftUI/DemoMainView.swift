//
//  DemoMainView.swift
//  InStreamSample
//
//  Created by ARoussel on 09/01/2024.
//

import SwiftUI

struct DemoMainView: View {
    var body: some View {
        ScrollView {
            VStack(
                alignment: .leading,
                spacing: 10
            ) {
                ForEach(0..<30, id: \.self) { index in
                    if index == 10 {
                        VideoCellView(playMode: .scroll)
                    } else {
                        Text("Ligne \(index), 1\nLigne \(index), 2\nLigne \(index), 3\nLigne \(index), 4")
                    }
                }
            }
            .frame(maxWidth: .infinity)
            .padding()
        }
    }
}

#Preview {
    DemoMainView()
}
