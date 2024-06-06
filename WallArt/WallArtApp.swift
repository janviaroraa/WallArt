//
//  WallArtApp.swift
//  WallArt
//
//  Created by Janvi Arora on 06/06/24.
//

import SwiftUI

@main
struct WallArtApp: App {

    @State private var viewModel = ContentViewModel()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(viewModel)
        }.windowStyle(.plain)

        ImmersiveSpace(id: "ImmersiveSpace") {
            ImmersiveView()
        }
    }
}
