//
//  TeamPicker.swift
//  NBAAppChallenge
//
//  Created by Darrick_Truong on 7/9/21.
//

import SwiftUI

struct ConferencePicker: View {
    
    @EnvironmentObject var model:ContentModel
    @Binding var conference:String
    
    var body: some View {
        
        Picker("Conference", selection: $conference) {
            Text("Western")
                .tag("western")
            Text("Eastern")
                .tag("eastern")
        }.padding(.horizontal)
        .pickerStyle(SegmentedPickerStyle())
        .onAppear {
            
            
            UISegmentedControl.appearance().selectedSegmentTintColor = UIColor.red
            UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor.white], for: .selected)
//            UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor.systemGray6], for: .normal)
        }
        
    }
}

//struct TeamPicker_Previews: PreviewProvider {
//    static var previews: some View {
//        TeamPicker()
//    }
//}
