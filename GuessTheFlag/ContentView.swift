//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Andrea Angiolillo on 06/03/2023.
//

import SwiftUI

struct ContentView: View {
    
    @State private var showingScore = false
    @State private var showingReset = false
    @State private var scoreTitle = ""
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Monaco","Nigeria", "Poland", "Russia", "Spain", "UK", "US"].shuffled()
    @State private var correctAnswer = Int.random(in: 0...2)
    @State private var userScore = 0
    @State private var userAttempts = 0
    
    
    private let FINAL_SCORE = 8
    
    var body: some View {
        ZStack{
            RadialGradient(stops: [
                .init(color: Color(red: 0.1, green: 0.2, blue: 0.45), location: 0.3),
                .init(color: Color(red: 0.76, green: 0.15, blue: 0.26), location: 0.3),
            
            ], center: .top, startRadius: 200, endRadius: 700).ignoresSafeArea()
            
            VStack{
                Spacer()
                Text("Guess the Flag")
                    .font(.largeTitle.bold())
                    .foregroundColor(.white)
                
                Spacer()
                VStack (spacing: 30){
                    VStack {
                        Text("Tab the flag of")
                            .foregroundStyle(.secondary)
                            .font(.subheadline.weight(.heavy))
                        
                        Text(countries[correctAnswer])
                            .font(.largeTitle.weight(.semibold))
                    }
                     
                    ForEach(0..<3) { number in
                        Button{
                            flagTapped(number: number)
                        } label: {
                            Image(countries[number])
                                .renderingMode(.original)
                                .clipShape(RoundedRectangle(cornerRadius: 20))
                                .shadow(radius: 10)
                        }
                    }
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 20)
                .background(.thinMaterial)
                .clipShape(RoundedRectangle(cornerRadius: 20))
            
                Spacer()
                Spacer()
                Text("Score: \(userScore)")
                    .foregroundColor(.white)
                    .font(.title.bold())
                Spacer()
                Text("Attempts: \(userAttempts)")
                    .foregroundColor(.white)
                    .font(.title.bold())
                Spacer()
            }
            .padding()
            
 
        }
        .alert(scoreTitle, isPresented: $showingScore){
            Button("Continue", action: askQuestion)

        } message: {
            Text("Your score is \(userScore)")
                    
        }
        
        .alert("End Game", isPresented: $showingReset){
            Button("New Game", action: reset)
        } message: {
            Text("Congrats! You've reached \(userScore) in \(userAttempts) attempts!")
        }
    }
    
    func flagTapped(number: Int) {
        scoreTitle = "Wrong. The correct answear is \(correctAnswer + 1)"
        userAttempts += 1
        
        if number == correctAnswer {
            userScore += 1
            scoreTitle = userScore < FINAL_SCORE ? "Correct" : "End Game"
        }
        
        if userScore == FINAL_SCORE {
            showingScore = false
            showingReset = true
            return
        }
        
        showingScore = true
    }
    
    func askQuestion() {
        countries = countries.shuffled()
        correctAnswer = Int.random(in: 0...2)
    }
    
    func reset() {
        if (showingScore){
            return
        }
        
        askQuestion()
        userScore = 0
        userAttempts = 0
        showingReset = false
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
