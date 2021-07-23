//
//  SVGLogo.swift
//  NBAAppChallenge
//
//  Created by Darrick_Truong on 7/8/21.
//

import SwiftUI
import SVGKit

struct SVGLogo: UIViewRepresentable {
    
    var data:Data?
    
    func makeUIView(context: Context) -> UIImageView {
        
        let imgViewObj = UIImageView()
        
        let logoSVG:SVGKImage? = SVGKImage(data: data ?? Data())
        
        guard logoSVG != nil else {
            return imgViewObj
        }
        
        logoSVG!.scaleToFit(inside: CGSize(width: 100, height: 100))

        imgViewObj.contentMode = .scaleAspectFit
        
        imgViewObj.image = logoSVG!.uiImage!
        
        return imgViewObj
    }
    
    func updateUIView(_ uiView: UIImageView, context: Context) {
        
        // update element if needed
    }
}

//struct SVGLogo_Previews: PreviewProvider {
//    static var previews: some View {
//        SVGLogo()
//    }
//}
