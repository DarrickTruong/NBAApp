//
//  StandingsView.swift
//  NBAAppChallenge
//
//  Created by Darrick_Truong on 7/7/21.
//

import SwiftUI

struct StandingsView: View {
    
    @EnvironmentObject var model:ContentModel
    @State var conference = "western"
    
    var body: some View {
        
        VStack {
            
            NavTitle(title:"Standings", svgLogo: model.nbaLogo)
            
            ConferencePicker(conference: $conference)
            
            HStack {
                
                HStack {
                    Text("#")
                    Text("Team")
                    
                    Spacer()
                    
                    Text("W-L")
                }
            }.padding(.horizontal, 30)
            .padding(.trailing, 20)
            
            
            ScrollView {
                LazyVStack(spacing: 10) {
                    
                    if conference == "western" {
                        
                        ForEach(model.western) { team in
                            StandingsRowView(team: team)
                                .padding(.horizontal)
                            
                        }
                    } else {
                        
                        ForEach(model.eastern) { team in
                            StandingsRowView(team: team)
                                .padding(.horizontal)
                            
                        }
                    }
                }.padding(.top)
            }
            
        }
    }
    
    //    struct StandingsView_Previews: PreviewProvider {
    //        static var previews: some View {
    //            StandingsView()
    //        }
    //    }
}
