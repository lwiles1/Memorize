//
//  ContentView.swift
//  Memorize
//
//  Created by Lucas Wiles on 5/14/24.
//

import SwiftUI

struct EmojiMemoryGameView: View {
    @ObservedObject var viewModel: EmojiMemoryGame
    
    @State var emojis: Array<String> = []
    @State private var theme = "Halloween"
    @State var cardCount = 10
    @State var begin: Bool = false
    
    var body: some View {
        VStack {
            title
            Text("\(viewModel.theme.name)")
            cards
                .animation(.default, value: viewModel.cards)
            Spacer()
            HStack {
                Button("New Game"){
                    viewModel.newGame()
                }
                Spacer()
                Text("Score: \(viewModel.score)")
                Spacer()
                Button("Shuffle") {
                    viewModel.shuffle()
                }
            }
        }
        .padding()
    }
    
    var title: some View {
        Text("Memorize")
            .font(.title)
            .fontWeight(.bold)
    }
    
    @ViewBuilder
    var cards: some View {
        let aspectRatio: CGFloat = 2/3;
        GeometryReader { geometry in
            let gridItemSize = gridItemWidthThatFits(
                count: viewModel.cards.count,
                size: geometry.size,
                atAspectRatio: aspectRatio
            )
            LazyVGrid(columns: [GridItem(.adaptive(minimum: gridItemSize), spacing: 0)], spacing: 0) {
                ForEach(viewModel.cards) { card in
                    CardView(card)
                        .aspectRatio(aspectRatio, contentMode: .fit)
                        .padding(4)
                        .onTapGesture {
                            viewModel.choose(card)
                        }
                }
            }
        }
        .foregroundColor(.orange)
    }
    
    func gridItemWidthThatFits (
        count: Int,
        size: CGSize,
        atAspectRatio aspectRatio: CGFloat
    ) -> CGFloat {
        let count = CGFloat(count);
        var columnCount = 1.0;
        repeat {
            let width = size.width / columnCount;
            let height = width / aspectRatio;
            
            let rowCount = (count / columnCount).rounded(.up)
            if rowCount * height < size.height {
                return (size.width / columnCount).rounded(.down)
            }
            columnCount += 1
        } while columnCount < count
        
        
        return min(size.width / count, size.height / aspectRatio).rounded(.down);
    }
}

struct CardView: View {
    let card: MemoryGame<String>.Card
    
    init(_ card: MemoryGame<String>.Card) {
        self.card = card
    }
    
    var body: some View {
        ZStack {
            let base = RoundedRectangle(cornerRadius: /*@START_MENU_TOKEN@*/25.0/*@END_MENU_TOKEN@*/)
            Group {
                base.fill(.white)
                base.strokeBorder(lineWidth: 2)
                Text(card.content)
                    .font(.system(size: 200))
                    .minimumScaleFactor(0.01)
                    .aspectRatio(1, contentMode: .fit)
            }.opacity(card.isFaceUp ? 1 : 0)
            base.fill()
                .opacity(card.isFaceUp ? 0 : 1)
        }
        .opacity(card.isFaceUp || !card.isMatched ? 1 : 0)
    }
}

#Preview {
    EmojiMemoryGameView(viewModel: EmojiMemoryGame())
}
