//
//  ContentView.swift
//  gameCenter
//
//  Created by Arno Pan on 2022-10-12.
//

import SwiftUI

struct ContentView: View {
    @State private var moves = ["", "", "", "", "", "", "", "", ""]
    // there are 9 possible views
    @State private var endGameText = "TicTacToe"
    // when the game ends this is the message
    @State private var gameEnded = false
    // Boolean to see if the game has ended or not
    private var ranges = [(0..<3), (3..<6), (6..<9)]
    // ranges 1 row 2 row 3 row
    
    var body: some View {
        VStack{
            Text(endGameText)
                .alert(endGameText, isPresented: $gameEnded){
                    Button("Reset", role: .destructive, action: resetGame)
                }
            Spacer()
            // Grid
            ForEach(ranges, id: \.self){
                range in HStack{
                    ForEach(range, id: \.self){
                        i in XOButton(letter: $moves[i])
                            .simultaneousGesture(
                                TapGesture()
                                    .onEnded{
                                        _ in playerTap(index: i)
                                    }
                            )
                    }
                }
            }
            Spacer()
            // Grid
            Button("Reset", action: resetGame)
        }
    }
    
    func playerTap(index: Int){
        if moves[index] == ""{
            moves[index] = "X"
            botMove()
        }
        
        for letter in ["X", "O"]{
            if checkWinner(list: moves, letter: letter){
                endGameText = "\(letter) has won!"
                gameEnded = true
                break
            }
        }
    }
    
    func botMove(){
        var availableMoves: [Int] = []
        var movesLeft = 0
        
        for move in moves{
            if move == ""{
                availableMoves.append(movesLeft)
            }
            movesLeft += 1
        }
        
        if availableMoves.count != 0{
            moves[availableMoves.randomElement()!] = "0"
        }
    }
    
    func resetGame(){
        endGameText = "TicTacToe"
        moves = ["", "", "", "", "", "", "", "", ""]
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
