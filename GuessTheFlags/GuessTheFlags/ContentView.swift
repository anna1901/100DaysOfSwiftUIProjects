//
//  ContentView.swift
//  GuessTheFlags
//
//  Created by Anna Olak on 03/01/2024.
//

import SwiftUI

struct FlagImage: View {
    var imageName: String
    var body: some View {
        Image(imageName)
            .clipShape(.capsule)
            .shadow(radius: 5)
    }
}

struct WhiteBoldTitle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .foregroundStyle(.white)
            .font(.title.bold())
    }
}

extension View {
    func whiteBoldTitle() -> some View {
        modifier(WhiteBoldTitle())
    }
}

struct ContentView: View {
    let numberOfRounds = 8
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Spain", "UK", "Ukraine", "US"].shuffled()
    @State private var correctAnswer = Int.random(in: 0...2)
    @State private var showingScore = false
    @State private var scoreTitle = ""
    @State private var userScore = 0
    @State private var selectedFlag = 0
    @State private var round = 1
    @State private var showEndGame = false
    @State private var animationAmounts = [0.0, 0.0, 0.0]
    @State private var tappedFlag: Int?
    
    var body: some View {
        ZStack {
            RadialGradient(stops: [
                .init(color: Color(red: 0.1, green: 0.2, blue: 0.45), location: 0.3),
                .init(color: Color(red: 0.76, green: 0.15, blue: 0.26), location: 0.3)
            ],center: .top, startRadius: 200, endRadius: 700)
                .ignoresSafeArea()
            
            VStack {
                Spacer()
                Text("Guess the Flag")
                    .font(.largeTitle.bold())
                    .foregroundStyle(.white)
                VStack(spacing: 15) {
                    VStack {
                        Text("Tap the flag of")
                            .foregroundStyle(.secondary)
                            .font(.subheadline.weight(.heavy))
                        Text(countries[correctAnswer])
                            .font(.largeTitle.weight(.semibold))
                    }
                    
                    ForEach(0..<3) {number in
                        Button {
                            withAnimation(.spring(duration: 1, bounce: 0.2)) {
                                tappedFlag = number
                            }
                            flagTapped(number)
                        } label: {
                            FlagImage(imageName: countries[number])
                        }
                        .rotation3DEffect(
                            .degrees(tappedFlag == number ? 360 : 0), axis: (x: 0.0, y: 1.0, z: 0.0)
                        )
                    }
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 20)
                .background(.regularMaterial)
                .clipShape(.rect(cornerRadius: 20))
                
                Spacer()
                Spacer()
                
                Text("Score: \(userScore)")
                    .whiteBoldTitle()
                Text("Round: \(round) of \(numberOfRounds)")
                    .whiteBoldTitle()
                Spacer()
            }
            .padding()
        }
        .alert(scoreTitle, isPresented: $showingScore) {
            Button("Continue", action: askQuestion)
        } message: {
            if scoreTitle == "Correct" {
                Text("Your score is \(userScore)")
            } else {
                Text("Wrong! This is the flag of \(countries[selectedFlag])")
            }
        }
        .alert("Game finished!", isPresented: $showEndGame) {
            Button("Reset", action: reset)
        } message: {
            Text("Your score is \(userScore)")
        }
    }
    
    func flagTapped(_ number: Int) {
        selectedFlag = number
        if number == correctAnswer {
            scoreTitle = "Correct"
            userScore += 1
        } else {
            scoreTitle = "Wrong"
            userScore -= 1
        }
        
        if round >= numberOfRounds {
            showEndGame = true
        } else {
            showingScore = true
        }
    }
    
    func askQuestion() {
        round += 1
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
        tappedFlag = nil
    }
    
    func reset() {
        userScore = 0
        round = 1
        tappedFlag = nil
    }
}

#Preview {
    ContentView()
}
