//
//  PlayerItem.swift
//  Youtube Mini Player simulation-SwiftUI
//
//  Created by Omar Adel on 06/08/2024.
//

import Foundation

let dummyDescription: String = "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book."

struct PlayerItem: Identifiable, Equatable {
    let id: UUID = .init()
    var title: String
    var author: String
    var image: String
    var description: String = dummyDescription
}

var items: [PlayerItem] = [
    .init(title: "Dummy Title for a two lines of title just for testing behavior",
          author: "Dummy",
          image: "Pic 1"),
    .init(title: "Dummy Title",
          author: "Dummy",
          image: "Pic 2"),
    .init(title: "Dummy Title",
          author: "Dummy",
          image: "Pic 3"),
    .init(title: "Dummy Title",
          author: "Dummy",
          image: "Pic 4"),
    .init(title: "Dummy Title",
          author: "Dummy",
          image: "Pic 5")
]
