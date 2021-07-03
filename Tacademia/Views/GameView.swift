//
//  GameView.swift
//  Tacademia
//
//  Created by Nivas Muthu M G on 03/07/21.
//

import SwiftUI

struct GameView: View {  
    let table: Int
    let noOfQuestions: Int
    
    @State var questionCount = 0
    @State var score = 0
    @State var question: [Int]
    @State var answers: [Int]
    @State var correctAnswer: Int
    @State var isScoreboardShown: Bool = false
    @State var choosenAnswer: Int? = nil
    
    init(table: Int, noOfQuestions: Int) {
        self.table = table
        self.noOfQuestions = noOfQuestions
        (question, answers, correctAnswer) = generateQuestion(table: table)
    }
    
    var body: some View {
        return VStack {
            Text("What is \(question[0]) x \(question[1])?")
                .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                .animation(/*@START_MENU_TOKEN@*/.easeIn/*@END_MENU_TOKEN@*/)
                .padding()
            
            HStack {
                ForEach(0..<answers.count) { i in
                    Button(action: {
                        choosenAnswer = i
                    }) {
                        HStack {
                            Spacer()
                            Text("\(answers[i])")
                                .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                                .foregroundColor(.white)
                                .padding(.vertical)
                                .animation(.easeIn(duration: 0.2))
                                .transition(.scale)
                            Spacer()
                        }
                    }
                    .background(Color.blue)
                    .clipShape(RoundedRectangle(cornerRadius: 20.0))
                    .overlay(RoundedRectangle(cornerRadius: 20.0).stroke(i == choosenAnswer ? Color.green : Color.white, lineWidth: 5.0))
                    .animation(.easeInOut(duration: 0.2))
                    .shadow(radius: 1)
                    .padding(.horizontal, 10)
                }
            }
            
            Button( action: {
                questionCount += 1
                if answers[correctAnswer] == answers[choosenAnswer!]{
                    score += 1
                }
                if questionCount < noOfQuestions {
                    (question, answers, correctAnswer) = generateQuestion(table: table)
                    choosenAnswer = nil
                } else {
                    isScoreboardShown = true
                }
            }){
                Text(questionCount < noOfQuestions - 1 ? "Next Question" : "End Quiz")
                    .foregroundColor(.white)
            }
            .padding()
            .background(questionCount < noOfQuestions - 1 ? Color.blue : Color.red)
            .animation(.default)
            .clipShape(RoundedRectangle(cornerRadius: /*@START_MENU_TOKEN@*/25.0/*@END_MENU_TOKEN@*/))
            .padding()
            .disabled(choosenAnswer == nil)
        }
        .alert(isPresented: $isScoreboardShown, content: {
            Alert(title: Text("Completed"), message: Text("Your Score is \(score) out of \(noOfQuestions)"), primaryButton: .default(Text("Play Again"), action: reset), secondaryButton: .cancel(Text("Exit"), action: {
            }))
        })
    }
    
    func reset() {
        score = 0
        questionCount = 0
        choosenAnswer = nil
        (question, answers, correctAnswer) = generateQuestion(table: table)
    }
}

func generateQuestion(table: Int) -> ([Int], [Int], Int) {
    let question = [Int.random(in: 1...12), table].shuffled()
    var answers = [question[0] * question[1]]
    var correctAnswer: Int = 0
    
    while answers.count < 4 {
        var temp = Int.random(in: 1...12) * Int.random(in: 1...12)
        while answers.contains(temp) {
//            print(temp)
            temp = Int.random(in: 1...12) * Int.random(in: 1...12)
        }
        answers.append(temp)
    }
    
    //crate a mechanism to remove duplicates
    
    answers = answers.shuffled()
    
    for (i, answer) in answers.enumerated() {
        if answer == question[0] * question[1] {
            correctAnswer = i
            break
        }
    }
    
    return (question, answers, correctAnswer)
}

struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        GameView(table: 2, noOfQuestions: 10)
    }
}
