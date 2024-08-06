//
//  MiniPlayerView.swift
//  Youtube Mini Player simulation-SwiftUI
//
//  Created by Omar Adel on 06/08/2024.
//

import SwiftUI

struct MiniPlayerView: View {
    
    var size: CGSize
    @Binding var config: PlayerConfig
    
    var body: some View {
        Rectangle()
            .fill(.background)
            .clipped()
            .contentShape(.rect)
            .offset(y: config.progress * -tabBarHeight)
            .frame(height: size.height - config.position, alignment: .top)
            .frame(maxHeight: .infinity, alignment: .bottom)
            .gesture(
                DragGesture()
                    .onChanged({ value in
                        let height = config.lastPosition + value.translation.height
                        config.position = min(height, size.height - 50)
                        generateProgress()
                    })
                    .onEnded({ value in
                        let velocity = value.velocity.height * 5
                        withAnimation(.smooth(duration: 0.3)) {
                            if (config.position + velocity) > (size.height * 0.6) {
                                config.position = size.height - 50
                                config.lastPosition = config.position
                                config.progress = 1
                            }else {
                                config.resetPosition()
                            }
                        }
                    })
            )
        /// Sliding In out
            .transition(.offset(y: size.height))
    }
    
    func generateProgress() {
        let progress = max(min(config.position / (size.height - 50), 1.0), .zero)
        config.progress = progress
    }
}

#Preview {
    ContentView()
}
