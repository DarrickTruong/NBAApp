//
//  NavTitle.swift
//  NBAAppChallenge
//
//  Created by Darrick_Truong on 7/12/21.
//

import SwiftUI

struct NavTitle: View {
    
    var title:String
    @State var svgLogo: Data
    
    var body: some View {
        
        HStack{
            Text(title)
                .font(.system(size: 36))
                .bold()
            Spacer()
            SVGLogo(data: svgLogo)
                .scaleEffect(CGSize(width: 1.0/2, height: 1.0/2))
                .frame(width: 75, height: 75)
                .padding(.top, 10)
                
        }.padding(.horizontal)
    }
}

//struct NavTitle_Previews: PreviewProvider {
//    static var previews: some View {
//        NavTitle()
//    }
//}
