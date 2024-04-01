//  RockPaperScissors
//  Created by Deniz Gökay Hamzalı on 3.03.2024.

import SwiftUI

struct ContentView: View {
    
    @State private var moves = ["Rock", "Paper", "Scissors"]
    @State private var symbolsOfMove = ["👊", "🤚", "✌️" ]
    @State private var shouldWin = Bool.random()
    
    @State private var random = Int.random(in: 0...2)
    @State private var state = ["Victory!", "Oh no"]
    
    @State private var scoreTitle = ""
    @State private var showingScore = false
    
    @State private var userScore = 0
    @State private var questionCount = 1
    
    @State private var gameFinished = false
    
    var winOrLoseText: String {
        shouldWin ? "Win" : "Lose"
    }
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [.yellow, .orange, .red, .purple, .blue, .green, .yellow]), startPoint: .topLeading, endPoint: .bottomTrailing)
                .ignoresSafeArea()
            VStack {
                Text("You should")
                    .font(.title.weight(.bold))
                    .foregroundStyle(.primary)
                Spacer()
                Spacer()
                Spacer()
                Text(winOrLoseText)
                    .font(.largeTitle.weight(.regular))
                    .foregroundColor(.white)
                   
                Spacer()
                Text("Against")
                    .font(.headline.weight(.semibold))
                Spacer()
                Text(moves[random])
                    .font(.largeTitle.weight(.heavy))
                    .foregroundColor(.white)
                Spacer()
                Spacer()
                Spacer()
                HStack {
                    ForEach(0..<3) { number in
                        Button {
                            print(buttonTapped(number))
                        } label: {
                            Text("\(symbolsOfMove[number])")
                        }
                    }
                }
                .font(.system(size: 100))
            }
            .alert(scoreTitle, isPresented: $showingScore) {
                Button("Continue", action: nextGame)
            } message: {
                Text("Your score is \(userScore)")
            }
            .alert("Your score is \(userScore)\\10, Boom!", isPresented: $gameFinished) {
                Button("Play again", action: resetGame)
            }
        }
    }
    
    func buttonTapped (_ number: Int) {
        if shouldWin {
            if (number == 0 && (moves[random] == "Scissors"))
                || (number == 1 && (moves[random] == "Rock"))
                || (number == 2 && (moves[random] == "Paper")) {
                scoreTitle = state[0]
                userScore += 1
            } else {
                scoreTitle = state[1]
                userScore -= 1
            }
        } else {
            if (number == 0 && (moves[random] == "Paper"))
                || (number == 1 && (moves[random] == "Scissors"))
                || (number == 2 && (moves[random] == "Rock")) {
                scoreTitle = state[0]
                userScore += 1
            } else {
                scoreTitle = state[1]
                userScore -= 1
            }
        }
        
        showingScore = true
    }
    
    func nextGame() {
        if questionCount < 10 {
            shouldWin = Bool.random()
            random = Int.random(in: 0...2)
            questionCount += 1
        } else {
            gameFinished = true
            shouldWin = Bool.random()
            random = Int.random(in: 0...2)
        }
    }
    
    func resetGame() {
        nextGame()
        userScore = 0
        questionCount = 1
    }
}

#Preview {
    ContentView()
}
