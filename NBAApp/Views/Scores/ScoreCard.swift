//
//  ScoreCard.swift
//  NBAAppChallenge
//
//  Created by Darrick_Truong on 7/12/21.
//

import SwiftUI

struct ScoreCard: View {
    
    @EnvironmentObject var model:ContentModel
    
    var game:Games
    var gameTime:String
    
    var body: some View {
        ZStack {
            
            if model.faveKey == game.AwayTeam || model.faveKey == game.HomeTeam && model.faveColorString != nil{
            
                Rectangle()
                    .frame(height: 300)
                    .cornerRadius(10)
                    .foregroundColor(Color(UIColor.systemGray6))
                    .shadow(color: Color(hex: model.faveColorString ?? "000000"), radius: 8)
            } else {
                Rectangle()
                    .frame(height: 300)
                    .cornerRadius(10)
                    .foregroundColor(Color(UIColor.systemGray6))
                    .shadow(color: .gray, radius: 5)
            }
            
            
            VStack(spacing: 10) {
                
                HStack(spacing: 40) {
                    VStack {
                        
                        if game.AwayTeam == "SA" || game.AwayTeam == "UTA" {
                           
                            SVGLogo(data: model.getTeamLogo(teamKey:game.AwayTeam!) ?? Data() )
                                .scaleEffect(CGSize(width: (1.0/2), height: (1.0/2)))
                                .frame(width: 75, height: 120, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                                .padding(.bottom)
                        } else {
                            
                            SVGLogo(data: model.getTeamLogo(teamKey:game.AwayTeam!) ?? Data() )
                                //                            .scaleEffect(CGSize(width: (1.0/2), height: (1.0/2)))
                                .frame(width: 75, height: 120, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                                .padding(.bottom)
                        }
                        Text(game.AwayTeam!)
                        
                        
                        Text(game.AwayTeamScore != nil ? String(game.AwayTeamScore!) : "-")
                            .bold()
                            .font(.title)
                    }
                    
                    Text("VS")
                    
                    VStack {
                        
                        if game.HomeTeam == "SA" || game.HomeTeam == "UTA" {
                           
                            SVGLogo(data: model.getTeamLogo(teamKey:game.HomeTeam!) ?? Data() )
                                .scaleEffect(CGSize(width: (1.0/2), height: (1.0/2)))
                                .frame(width: 75, height: 120, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                                .padding(.bottom)
                        } else {
                            
                            SVGLogo(data: model.getTeamLogo(teamKey:game.HomeTeam!) ?? Data() )
                                .frame(width: 75, height: 120, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                                .padding(.bottom)
                        }
                        
                        Text(game.HomeTeam!)
                        Text(game.HomeTeamScore != nil ? String(game.HomeTeamScore!) : "-")
                            .bold()
                            .font(.title)
                    }
                    
                }
                
                HStack {
                    Text(gameTime)
                }
            }
        }.padding(.horizontal)
    }
}

//struct ScoreCard_Previews: PreviewProvider {
//    static var previews: some View {
//        ScoreCard()
//    }
//}
