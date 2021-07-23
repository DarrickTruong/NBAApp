//
//  StandingsRowView.swift
//  NBAAppChallenge
//
//  Created by Darrick_Truong on 7/7/21.
//

import SwiftUI

struct StandingsRowView: View {
    
    @EnvironmentObject var model:ContentModel
    
    @ObservedObject var team:Teams
    
    var body: some View {
        
        ZStack {
            
            Rectangle()
                .foregroundColor(Color(UIColor.systemGray6))
                .cornerRadius(10)
                .shadow(color: .gray, radius:5)
                .frame(height:60)
            
            
            HStack {
                
                HStack {
                    Text(String(team.ConferenceRank ?? 0))
                    
                    if team.Name == "Jazz" || team.Name == "Spurs" {
                        SVGLogo(data: team.imageData ?? Data())
                            .frame(width: 75, height: 40, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                            .scaleEffect(CGSize(width: (1.0/4), height: (1.0/4)))
                    } else {
                        SVGLogo(data: team.imageData ?? Data())
                            .frame(width: 75, height: 40, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                            .scaleEffect(CGSize(width: (1.0/3), height: (1.0/3)))
                    }
                    Text(team.Name ?? "")
                    
                    if model.faveKey == team.Key {
                        
                        Image(systemName: "star.circle.fill")
                            .font(.system(size: 36))
                            .foregroundColor(Color(hex: team.PrimaryColor ?? team.SecondaryColor ?? "000000"))
                        
                    }
                    
                    Spacer()
                    
                    
                    // TODO: implement if favorite, show yellow star
                    Text("\(String(team.Wins ?? 0)) - \(String(team.Losses ?? 0))")
                }
            }.padding(.horizontal)
            
        }
    }
    
}

//struct StandingsRowView_Previews: PreviewProvider {
//    static var previews: some View {
//        StandingsRowView()
//    }
//}
