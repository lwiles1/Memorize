//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by Lucas Wiles on 6/4/24.
//

import SwiftUI


class EmojiMemoryGame {
    private static let emojis = ["👻", "🕷️", "🎃", "👹", "💀", "❄️", "🧙", "🙀", "😈", "😱", "☠️", "🍭"]
    
    private var model = EmojiMemoryGame.createMemoryGame()
    
    static func createMemoryGame() -> MemoryGame<String> {
        return MemoryGame(numberOfPairsOfCards: 4) { pairIndex in
            return emojis[pairIndex]
        }
    }
    
    var cards: Array<MemoryGame<String>.Card> {
        return model.cards
    }
    
    func choose(_ card: MemoryGame<String>.Card) {
        model.choose(card)
    }
}
