//  Created by Deniz Gökay Hamzalı on 9.04.2024.

import SwiftUI

struct Question {
    let text: String
    let answer: Int
}

struct ContentView: View {
    let images = ["chick", "chicken", "frog", "duck", "penguin", "parrot", "giraffe", "bear", "walrus", "rhino", "monkey", "narwhal"]
    let imagesActive = ["chickA", "chickenA", "frogA", "duckA", "penguinA", "parrotA", "giraffeA", "bearA", "walrusA", "rhinoA", "monkeyA", "narwhalA"]
    
    @State private var selectedTable = 0
    @State private var selectedNumOfQuestions = 0
    @State private var questions: [Question] = []
    @State private var isGameActive = false
    @State private var userAnswer: Int?
    @State private var userScore = 0
    @State private var questionNumber = 0
    @State private var scoreTitle = ""
    @State private var showingScore = false
    @State private var gameFinished = false
    
    @State private var animationAmount: CGFloat = 1
    
    let numOfQuestions = [5, 10, 20]
    var allQuestions: [Question] {
        generateQuestions(timesTable: selectedTable, numberOfQuestions: selectedNumOfQuestions)
    }
    
    var body: some View {
        if isGameActive {
            GeometryReader { geometry in
                VStack {
                    Spacer()
                    Image(imagesActive[selectedTable - 2])
                        .padding(.top, geometry.size.height * 0.3)
                        .padding(.bottom, geometry.size.height * 0.15)
                        .scaleEffect(animationAmount)
                        .animation(
                            .easeInOut(duration: 2)
                                .repeatForever(autoreverses: true),
                            value: animationAmount
                        )
                        .onAppear {
                            animationAmount = 2
                        }
                        
                    HStack {
                        Text(questions[questionNumber].text)
                        TextField("Answer", value: $userAnswer, format: .number)
                            .keyboardType(.numberPad)
                            .frame(width: geometry.size.width * 0.15)
                        Button("Check", action: checkAnswer)
                            .buttonStyle(.borderedProminent)
                            .tint(.green)
                    }
                    Spacer()
                    Spacer()
                    .frame(width: geometry.size.width, height: geometry.size.height)
                    .alert("Your score is \(userScore), congratulations!", isPresented: $gameFinished) {
                        Button("Play Again", action: resetGame)
                    }
                    .alert(scoreTitle, isPresented: $showingScore) {
                        Button("Continue", action: askQuestions)
                    }
                }
            }
                
        } else {
            NavigationStack {
                VStack() {
                    Spacer()
                    Text("Choose your multiplication table")
                        .font(.title3)
                        .fontWeight(.semibold)
                    let columns = Array(repeating: GridItem(.flexible()), count: 3)
                    GeometryReader { geometry in
                        LazyVGrid(columns: columns) {
                            ForEach(2..<14) { number in
                                Button {
                                    selectedTable = number
                                } label: {
                                    ZStack {
                                        Image(images[number - 2])
                                            .frame(width: geometry.size.width * 0.32, height: geometry.size.height * 0.3)
                                            .clipShape(Circle())
                                            .overlay(Circle().stroke(number == selectedTable ? Color.primary : Color.clear, lineWidth: 4))
                                        VStack {
                                            Text("\(number)")
                                                .padding(.top, geometry.size.height * 0.2)
                                                .fontWeight(.semibold)
                                        }
                                    }
                                }
                                .frame(width: geometry.size.width * 0.25, height: geometry.size.height * 0.2)
                                .padding(10)
                                .foregroundColor(.green)
                                .font(.title)
                            }
                        }
                        .frame(height: geometry.size.height * 0.9)
                        .padding()
                    }
                    
                    Text("Choose your number of question")
                        .font(.title3)
                        .fontWeight(.semibold)
                    Picker("Number of questions", selection: $selectedNumOfQuestions) {
                        ForEach(numOfQuestions, id: \.self) {
                            Text($0, format: .number)
                        }
                    }
                    .pickerStyle(.segmented)
                    .padding(.bottom)
                    
                    Button("Start Game") {
                        if selectedNumOfQuestions != 0 && selectedTable != 0 {
                            isGameActive = true
                            questions = allQuestions
                        }
                    }
                    .padding(.bottom)
                    .buttonStyle(.bordered)
                    .tint(.green)
                    
                    .navigationBarTitleDisplayMode(.inline)
                    .toolbar {
                        ToolbarItem(placement: .principal) {
                            Text("Edutainment")
                                .foregroundStyle(.green)
                                .font(.title2)
                                .fontWeight(.semibold)
                        }
                    }
                    Spacer()
                    Spacer()
                }
            }
        }
    }
    
    func generateQuestions(timesTable: Int, numberOfQuestions: Int) -> [Question] {
        
        for _ in 1...selectedNumOfQuestions {
            let randomMultiplier = Int.random(in: 1...12)
            let questionText = "\(timesTable) x \(randomMultiplier) ?"
            let answer = timesTable * randomMultiplier
            
            let question = Question(text: questionText, answer: answer)
            questions.append(question)
        }
        return questions
    }
    
    func checkAnswer() {
        if let userAnswer = userAnswer, userAnswer == questions[questionNumber].answer {
            scoreTitle = "Correct!"
            userScore += 1
        } else {
            scoreTitle = "Incorrect but no problem! \n The answer was \(questions[questionNumber].answer)"
        }
        showingScore = true
        userAnswer = nil
    }
    
    func askQuestions() {
        if questionNumber < questions.count - 1 {
            questionNumber += 1
        } else {
            gameFinished = true
        }
    }
    
    func resetGame() {
        questions = []
        questionNumber = 0
        userScore = 0
        selectedNumOfQuestions = 0
        selectedTable = 0
        gameFinished = false
        isGameActive = false
    }
    
}

#Preview {
    ContentView()
}
