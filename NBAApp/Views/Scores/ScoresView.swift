//
//  ScoresView.swift
//  NBAAppChallenge
//
//  Created by Darrick_Truong on 7/7/21.
//

import SwiftUI

struct ScoresView: View {
    
    @EnvironmentObject var model:ContentModel
    @State var day = "today"
    
    var body: some View {
        
        VStack {
            
            if model.games.capacity != 0 && model.logosDone{
                
                NavTitle(title:"Scores", svgLogo: model.nbaLogo)
                
                Picker("Day", selection: $day) {
                    Text("Yesterday")
                        .tag("yesterday")
                    Text("Today")
                        .tag("today")
                    Text("Tomorrow")
                        .tag("tomorrow")
                }
                .padding(.horizontal)
                .pickerStyle(SegmentedPickerStyle())
                .onAppear{
                    
                    UISegmentedControl.appearance().selectedSegmentTintColor = UIColor.red
                    UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor.white], for: .selected)
//                    UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor.systemGray], for: .normal)
                }
                
                ScrollView {
                    LazyVStack(spacing:10){
                                                
                        if day == "yesterday" {
                            
                            if model.games["yesterday"] != nil{
                                
                                ForEach(model.games["yesterday"]!) { game in
                                    
                                    ScoreRowView(game:game)
                                }
                            } else {
                                Text("No scheduled games")
                                    .padding(.top, 30)
                            }
                        } else if day == "today" {
                            
                            if model.games["today"] != nil {
                                ForEach(model.games["today"]!) { game in
                                    
                                    ScoreRowView(game:game)
                                }
                            } else {
                                Text("No scheduled games")
                                    .padding(.top, 30)
                            }
                        } else if day == "tomorrow" {
                            
                            if model.games["tomorrow"] != nil {
                                ForEach(model.games["tomorrow"]!) { game in
                                    
                                    ScoreRowView(game:game)
                                }
                            } else {
                                Text("No scheduled games")
                                    .padding(.top, 30)
                            }
                        }
                        
                    }.padding(.top)
                }
            } else {
                ProgressView()
            }
        }
    }
}

//struct ScoresView_Previews: PreviewProvider {
//    static var previews: some View {
//        ScoresView()
//    }
//}
