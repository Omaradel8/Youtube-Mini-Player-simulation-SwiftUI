//
//  Home.swift
//  Youtube Mini Player simulation-SwiftUI
//
//  Created by Omar Adel on 06/08/2024.
//

import SwiftUI

struct Home: View {
    
    // VIEW PROPERTIES
    @State private var activeTab: Tab = .home
    @State private var config: PlayerConfig = .init()
    
    var body: some View {
        ZStack(alignment: .bottom) {
            TabView(selection: $activeTab) {
                HomeTabView()
                    .setupTab(.home)
                
                Text(Tab.shorts.rawValue)
                    .setupTab(.shorts)
                
                Text(Tab.subscriptions.rawValue)
                    .setupTab(.subscriptions)
                
                Text(Tab.you.rawValue)
                    .setupTab(.you)
            }
            .padding(.bottom, tabBarHeight)
            
            
            /// Mini player view
            GeometryReader {
                let size = $0.size
                
                if config.showMiniPlayer {
                    MiniPlayerView(size: size, config: $config)
                }
            }
            
            CustomTabBar()
                .offset(y: config.showMiniPlayer ? tabBarHeight - (config.progress * tabBarHeight) : 0)
        }
        .ignoresSafeArea()
    }
    
    /// Home Tab View
    @ViewBuilder
    func HomeTabView() -> some View {
        NavigationStack {
            ScrollView(.vertical) {
                LazyVStack(spacing: 15) {
                    ForEach(items) { item in
                        PlayerItemCardView(item) {
                            config.selectedPlayerItem = item
                            withAnimation(.easeInOut(duration: 0.3)) {
                                config.showMiniPlayer = true
                            }
                        }
                    }
                }
                .padding(15)
            }
            .navigationTitle("Youtube")
            .toolbarBackground(.visible, for: .navigationBar)
            .toolbarBackground(.background, for: .navigationBar)
        }
    }
    
    /// Player Item Card View
    @ViewBuilder
    func PlayerItemCardView(_ item: PlayerItem, onTap: @escaping () -> ()) -> some View {
        VStack(alignment: .leading, spacing: 6) {
            Image(item.image)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(height: 170)
                .clipShape(.rect(cornerRadius: 10))
                .contentShape(.rect)
                .onTapGesture{ onTap() }
            
            HStack(spacing: 10) {
                Image(systemName: "person.circle.fill")
                    .font(.title)
                
                VStack(alignment: .leading, spacing: 4) {
                    Text(item.title)
                        .font(.callout)
                    
                    HStack(spacing: 6) {
                        Text(item.author)
                        
                        Text("' 2 Days Ago")
                    }
                    .font(.caption)
                    .foregroundColor(.gray)
                }
            }
        }
    }
    
    /// Custom Tab Bar
    @ViewBuilder
    func CustomTabBar() -> some View {
        HStack(spacing: 0) {
            ForEach(Tab.allCases, id: \.rawValue) { tab in
                VStack(spacing: 4) {
                    Image(systemName: tab.symbol)
                        .font(.title3)
                    Text(tab.rawValue)
                        .font(.caption2)
                }
                .foregroundColor(activeTab == tab ? Color.primary : .gray)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .contentShape(.rect)
                .onTapGesture {
                    activeTab = tab
                }
            }
        }
        .frame(height: 49)
        .overlay(alignment: .top) {
            Divider()
        }
        .frame(maxHeight: .infinity, alignment: .top)
        .frame(height: tabBarHeight)
        .background(.background)
    }
}

#Preview {
    ContentView()
}

/// SafeArea Value
var safeArea: UIEdgeInsets {
    if let safeArea = (UIApplication.shared.connectedScenes.first as? UIWindowScene)?.keyWindow?.safeAreaInsets {
        return safeArea
    }
    
    return .zero
}

var tabBarHeight: CGFloat {
    return 49 + safeArea.bottom
}
