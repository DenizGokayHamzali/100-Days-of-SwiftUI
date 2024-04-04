//  Created by Deniz Gökay Hamzalı on 22.02.2024.

import SwiftUI

struct FlagImage: View {
    var countries: String
    
    var body: some View {
        Image(countries)
            .clipShape(.capsule)
            .shadow(radius: 10)
            .overlay(
                Capsule()
                    .stroke(.white, lineWidth: 3)
            )
    }
}

struct ContentView: View {
    
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Spain", "UK", "Ukraine", "US"]
    @State private var correctAnswer = Int.random(in: 0...2)
    
    @State private var showingScore = false
    @State private var scoreTitle = ""
    @State private var userScore = 0
    @State private var showingWrong = false
    @State private var tappedFlag = ""
    @State private var questionCount = 1
    @State private var gameFinished = false
    
    @State private var spinAmount = 0.0
    @State private var tappedButtonIndex: Int?
    
    var body: some View {
        ZStack {
            RadialGradient(stops: [
                .init(color: Color(red: 0.3, green: 0.3, blue: 0.85), location: 0.3),
                .init(color: Color(red: 0.2, green: 0.15, blue: 0.3), location: 0.3)
            ], center: .top, startRadius: 200, endRadius: 700)
            .ignoresSafeArea()
            
            VStack {
                Spacer()
                
                Text("Guess the Flag")
                    .font(.largeTitle.weight(.bold))
                    .foregroundColor(.white)
                
                VStack(spacing: 15) {
                    VStack {
                        Text("Tap the flag of")
                            .foregroundStyle(.secondary)
                            .font(.subheadline.weight(.heavy))
                        
                        Text(countries[correctAnswer])
                            .font(.largeTitle.weight(.semibold))
                    }
                    
                    ForEach(0..<3) { number in
                        Button {
                            flagTapped(number)
                        }
                    label: {
                            FlagImage(countries: countries[number])
                            .rotation3DEffect(.degrees(number == correctAnswer ? spinAmount : 0), axis: (x: 0, y: 1, z: 0))
                            .opacity(tappedButtonIndex != nil && tappedButtonIndex != number ? 0.25 : 1)
                            .scaleEffect(tappedButtonIndex != nil && tappedButtonIndex != number ? 0.75 : 1)
                        }
                    }
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 20)
                .background(.thinMaterial)
                .clipShape(.rect(cornerRadius: 20))
                
                Spacer()
                Spacer()
                
                Text("Score: \(userScore)")
                    .foregroundStyle(Color.white)
                    .font(.title.bold())
                
                Spacer()
            }
            .padding()
        }
        .alert(scoreTitle, isPresented: $showingScore) {
            Button("Continue", action: askQuestions)
        } message: {
            Text("Your score is \(userScore)")
        }
        .alert("Wrong! That's the flag of \(tappedFlag)", isPresented: $showingWrong) {
            Button("Continue", action: askQuestions)
        } message: {
            Text("Your score is \(userScore) \n Do not lose your hope :)")
        }
        .alert("Your score is \(userScore)\\8, congrats!", isPresented: $gameFinished) {
            Button("Play Again", action: resetGame)
        }
        
    }
    
    func flagTapped (_ number: Int) {
        tappedButtonIndex = number
        if number == correctAnswer {
            withAnimation(.easeIn(duration: 0.5)){
                spinAmount += 360
            }
            scoreTitle = "Correct"
            userScore += 1
            showingScore = true
                
        } else {
            scoreTitle = "Wrong"
            userScore -= 1
            showingWrong = true
            tappedFlag = countries[number]
        }
    }
    
    func askQuestions() {
        if questionCount < 8 {
            countries.shuffle()
            correctAnswer = Int.random(in: 0...2)
            questionCount += 1
        } else {
            gameFinished = true
            countries.shuffle()
            correctAnswer = Int.random(in: 0...2)
        }
        tappedButtonIndex = nil
    }
    
    func resetGame() {
        askQuestions()
        userScore = 0
        questionCount = 1
    }
}

#Preview {
    ContentView()
}
