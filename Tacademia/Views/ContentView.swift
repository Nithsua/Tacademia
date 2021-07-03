//
//  ContentView.swift
//  Tacademia
//
//  Created by Nivas Muthu M G on 03/07/21.
//

import SwiftUI

struct ContentView: View {
    let noOfQuestionsPossible = [5, 10, 15, 20]
    @State private var questionIndex = 1
    @State private var table = 2
    
    var body: some View {
        NavigationView {
                VStack {
                    Text("Select the Table")
                        .font(.title2)
                        .padding()
                    
                    GridView(rows: 3, columns: 4) { row, column in
                        Button(action: {
                            table = row * 4 + column + 1
                        }) {
                            HStack {
                                Spacer()
                                Text("\(row * 4 + column + 1)")
                                    .font(.title)
                                    .foregroundColor(.white)
                                    .padding(.vertical)
                                Spacer()
                            }
                        }
                        .background(Color.blue)
                        .clipShape(RoundedRectangle(cornerRadius: 20.0))
                        .overlay(RoundedRectangle(cornerRadius: 20.0).stroke( Color.green, lineWidth: table == row * 4 + column + 1 ? 5.0 : 0.0))
                        .animation(.easeInOut(duration: 0.2))
                        .shadow(radius: 5)
                    }
                    
                    Text("How many questions do you want")
                        .font(.title2)
                        .padding()
                    
                    HStack {
                        ForEach(0..<noOfQuestionsPossible.count) { i in
                            Button(action: {
                                questionIndex = i
                            }) {
                                HStack {
                                    Spacer()
                                    Text("\(i == 4 ? "All" : String(noOfQuestionsPossible[i]))")
                                        .font(.title2)
                                        .foregroundColor(.white)
                                        .padding(.vertical)
                                    Spacer()
                                }
                            }
                            .background(Color.blue)
                            .clipShape(RoundedRectangle(cornerRadius: 20.0))
                            .overlay(RoundedRectangle(cornerRadius: 20.0).stroke( Color.green, lineWidth: i == questionIndex ?  5.0 : 0.0))
                            .animation(.easeInOut(duration: 0.2))
                            .shadow(radius: 1)
                            .padding(.horizontal, 10)
                        }
                    }
                    Spacer()
                    NavigationLink(destination: GameView(table: table, noOfQuestions: noOfQuestionsPossible[questionIndex])){
                        Text("START GAME")
                            .font(.title)
                            .padding()
                            .background(Color.green)
                            .foregroundColor(.white)
                            .clipShape(RoundedRectangle(cornerRadius: 15.0))
                            .overlay(RoundedRectangle(cornerRadius: 15.0).stroke(Color.white, lineWidth: 2.0))
                            .shadow(radius: 10)
                    }
                    Spacer()
            }
            .navigationBarHidden(true)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
