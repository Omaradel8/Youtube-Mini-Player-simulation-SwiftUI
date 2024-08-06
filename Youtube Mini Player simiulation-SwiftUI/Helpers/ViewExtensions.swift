//
//  ViewExtensions.swift
//  Youtube Mini Player simulation-SwiftUI
//
//  Created by Omar Adel on 06/08/2024.
//

import SwiftUI

extension View {
    @ViewBuilder
    func setupTab(_ tab: Tab) -> some View {
        self
            .tag(tab)
            .toolbar(.hidden, for: .tabBar)
    }
}
