//
//  MemorizeApp.swift
//  Memorize
//
//  Created by Lucas Wiles on 5/14/24.
//

import SwiftUI

@main
struct MemorizeApp: App {
    @StateObject var game = EmojiMemoryGame()
    var body: some Scene {
        WindowGroup {
            EmojiMemoryGameView(viewModel: game)
        }
    }
}
