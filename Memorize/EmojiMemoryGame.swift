//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by Lucas Wiles on 6/4/24.
//

import SwiftUI


class EmojiMemoryGame: ObservableObject {
    private static let emojis = ["👻", "🕷️", "🎃", "👹", "💀", "❄️", "🧙", "🙀", "😈", "😱", "☠️", "🍭"]

    @Published private var model = EmojiMemoryGame.createMemoryGame()
    
    static func createMemoryGame() -> MemoryGame<String> {
        return MemoryGame(numberOfPairsOfCards: 12) { pairIndex in
            if emojis.indices.contains(pairIndex) {
                return emojis[pairIndex]
            } else {
                return "🚩"
            }
        }
    }
    
    // MARK: - Intent
    
    func shuffle() {
        model.shuffle()
        objectWillChange.send()
    }
    
    var cards: Array<MemoryGame<String>.Card> {
        return model.cards
    }
    
    func choose(_ card: MemoryGame<String>.Card) {
        model.choose(card)
    }
}
