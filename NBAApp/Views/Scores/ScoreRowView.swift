//
//  ScoreRowView.swift
//  NBAAppChallenge
//
//  Created by Darrick_Truong on 7/9/21.
//

import SwiftUI

struct ScoreRowView: View {
    
    @EnvironmentObject var model:ContentModel
    var game:Games
    
    var gameTime:String {
        
        let df = DateFormatter()
        df.dateFormat = "MMM dd, yyyy h:mm a"
        let gameTime = df.date(from: game.DateTime!)
        
        let today = Date()
        
        if gameTime! < today {
            return "Final"
        } else {
            return String("\(game.DateTime!) on \(game.Channel)")
        }
    }
    
    var body: some View {
        
        ScoreCard(game: game, gameTime: gameTime)
        
        
    }
}

//struct ScoreRowView_Previews: PreviewProvider {
//    static var previews: some View {
//        ScoreRowView()
//    }
//}
