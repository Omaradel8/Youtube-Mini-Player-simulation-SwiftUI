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
    var body: some View {
        ZStack(alignment: .bottom) {
            TabView(selection: $activeTab) {
                Text(Tab.home.rawValue)
                    .setupTab(.home)
                
                Text(Tab.shorts.rawValue)
                    .setupTab(.shorts)
                
                Text(Tab.subscriptions.rawValue)
                    .setupTab(.subscriptions)
                
                Text(Tab.you.rawValue)
                    .setupTab(.you)
            }
            .padding(.bottom, tabBarHeight)
            
            CustomTabBar()
        }
        .ignoresSafeArea()
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
}

#Preview {
    ContentView()
}
