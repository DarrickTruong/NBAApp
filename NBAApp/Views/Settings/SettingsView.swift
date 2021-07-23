//
//  SettingsView.swift
//  NBAAppChallenge
//
//  Created by Darrick_Truong on 7/7/21.
//

import SwiftUI

struct SettingsView: View {
    
    @EnvironmentObject var model:ContentModel
    @State var conference = "western"
    @State var fave = ""
    
    var titleText:String {
        
        if self.fave == "" {
            return "Pick your favorite team"
        } else {
            return "Your favorite team has been updated to the \(self.fave)"
        }
    }
    
    var body: some View {
        
        VStack {
            
            NavTitle(title:"Settings", svgLogo: model.nbaLogo)
            
            ConferencePicker(conference: $conference)
            
            Spacer()
            
            Text(titleText)
                .bold()
                .multilineTextAlignment(.center)
                .frame(width:200)
            if conference == "western" {
                
                Picker("Favorite Team", selection: $fave) {
                    
                    ForEach(model.western) { team in
                        
                        Text(team.Name!)
                            .tag(team.Key!)
                    }
                }
                
            } else {
                
                Picker("Favorite Team", selection: $fave) {
                    
                    ForEach(model.eastern) { team in
                        
                        Text(team.Name!)
                            .tag(team.Key!)
                    }
                }
            }
            
            Spacer()
            
            
        }.onChange(of: fave, perform: { value in
            model.setFave(favoriteTeamKey: fave)
            model.sortScheduleForFave()
        })
      
        
    }
}

//struct SettingsView_Previews: PreviewProvider {
//    static var previews: some View {
//        SettingsView()
//    }
//}
