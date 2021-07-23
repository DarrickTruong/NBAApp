//
//  NBAAppApp.swift
//  NBAApp
//
//  Created by Darrick_Truong on 7/13/21.
//

import SwiftUI

@main
struct NBAAppApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(ContentModel())
        }
    }
}
