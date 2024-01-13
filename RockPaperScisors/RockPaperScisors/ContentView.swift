//
//  ContentView.swift
//  RockPaperScisors
//
//  Created by Anna Olak on 07/01/2024.
//

import SwiftUI

enum Move: String {
    case rock = "🪨"
    case paper = "📜"
    case scisors = "✂️"
}

struct MoveButton: View {
    var option: Move
    var action: (Move) -> Void
    var body: some View {
        Button(action: {
            action(option)
        }, label: {
            Text("\(option.rawValue)")
                .font(.system(size: 50))
        })
        .padding()
        .background(.thinMaterial)
        .clipShape(Circle())
        .background(.blue)
        .clipShape(Circle())
        .shadow(radius: 8, x: 2, y: 8)
    }
}

struct ContentView: View {
    let possibleMoves: [Move] = [.rock, .paper, .scisors]
    @State private var appsCurrentChoice = [Move.rock, .paper, .scisors][Int.random(in: 0..<3)]
    @State private var shouldWin = Bool.random()
    @State private var playersScore = 0
    @State private var playerChose = false
    @State private var gameEnded = false
    @State private var alertTitle = ""
    @State private var round = 1
    let numberOfRounds = 5
    
    var body: some View {
        VStack {
            VStack(spacing: 40) {
                Text("Make a move that makes you:")
                    .font(.title)
                    .bold()
                    .multilineTextAlignment(.center)
                Text("\(shouldWin ? "WIN" : "LOSE")")
                    .font(.title)
                    .bold()
                    .shadow(radius: 10)
                HStack(spacing: 15) {
                    Text("Apps move:")
                        .font(.title)
                    Text("\(appsCurrentChoice.rawValue)")
                        .font(.system(size: 45))
                }
            }
            .foregroundStyle(.white)
            .padding()
            Spacer()
            HStack(spacing: 30) {
                MoveButton(option: .rock, action: selected)
                MoveButton(option: .paper, action: selected)
                MoveButton(option: .scisors, action: selected)
            }
            Spacer()
            Text("Score: \(playersScore)")
                .font(.title)
                .foregroundStyle(.white)
            Text("Round: \(round) / \(numberOfRounds)")
                .font(.headline)
                .foregroundStyle(.white)
                .padding(.top, 1)
            Spacer()
            
        }
        .frame(maxWidth: .infinity)
        .background(.indigo.gradient)
        .alert(alertTitle, isPresented: $playerChose) {
            Button("Ok") { nextRound() }
        }
        .alert("The End", isPresented: $gameEnded) {
            Button("Ok") { reset() }
        } message: {
            Text("Your final score is: \(playersScore)")
        }
    }
    
    func selected(_ playerMove: Move) {
        if playerSelectedWell(playerMove) {
            alertTitle = "Correct!"
            playersScore += 1
        } else {
            alertTitle = "Wrong"
            playersScore -= 1
        }
        playerChose = true
    }
    
    func playerSelectedWell(_ playerMove: Move) -> Bool {
        switch appsCurrentChoice {
        case .rock:
            return shouldWin && playerMove == .paper || !shouldWin && playerMove == .scisors
        case .paper:
            return shouldWin && playerMove == .scisors || !shouldWin && playerMove == .rock
        case .scisors:
            return shouldWin && playerMove == .rock || !shouldWin && playerMove == .paper
        }
    }
    
    func nextRound() {
        guard round < numberOfRounds else {
            gameEnded.toggle()
            return
        }
        appsCurrentChoice = [Move.rock, .paper, .scisors][Int.random(in: 0..<3)]
        shouldWin = Bool.random()
        round += 1
    }
    
    func reset() {
        appsCurrentChoice = [Move.rock, .paper, .scisors][Int.random(in: 0..<3)]
        shouldWin = Bool.random()
        round = 1
        playersScore = 0
    }
}

#Preview {
    ContentView()
}
