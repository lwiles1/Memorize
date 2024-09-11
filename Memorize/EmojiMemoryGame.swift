//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by Lucas Wiles on 6/4/24.
//

import SwiftUI


class EmojiMemoryGame: ObservableObject {
    @Published private var model: MemoryGame<String>
    var theme = themes.randomElement()!
    
    init() {
        model = EmojiMemoryGame.createMemoryGame(theme: theme)
    }
    
    static func createMemoryGame(theme: Theme) -> MemoryGame<String> {
        let emojis = theme.emojis
        return MemoryGame(numberOfPairsOfCards: 12) { pairIndex in
            if emojis.indices.contains(pairIndex) {
                return emojis[pairIndex]
            } else {
                return "🚩"
            }
        }
    }
    
    // MARK: - Intent
    
    func newGame() {
        theme = themes.randomElement()!
        model = EmojiMemoryGame.createMemoryGame(theme: theme)
    }
    
    func shuffle() {
        model.shuffle()
        objectWillChange.send()
    }
   
    var score: Int {
        return model.score
    }
    
    var cards: Array<MemoryGame<String>.Card> {
        return model.cards
    }
    
    func choose(_ card: MemoryGame<String>.Card) {
        model.choose(card)
    }
}
