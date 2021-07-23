//
//  ContentView.swift
//  NBAAppChallenge
//
//  Created by Darrick_Truong on 7/7/21.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        
        TabView {
            
            ScoresView()
                .tabItem {
                    VStack {
                        Image(systemName: "sportscourt")
                        Text("Scores")
                    }
                }
            
            StandingsView()
                .tabItem {
                    VStack {
                        Image(systemName: "list.number")
                        Text("Standings")
                    }
                }
            
            SettingsView()
                .tabItem {
                    VStack {
                        Image(systemName: "gearshape")
                        Text("Settings")
                    }
                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
