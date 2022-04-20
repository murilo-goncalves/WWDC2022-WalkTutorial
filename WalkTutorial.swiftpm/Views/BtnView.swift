//
//  BtnView.swift
//  
//
//  Created by Murilo Gonçalves on 19/04/22.
//

import SwiftUI

struct BtnView: View {
    let image: String
    
    var body: some View {
        Image(image)
            .resizable()
            .renderingMode(.original)
            .frame(width: UIScreen.screenWidth * 0.5, height: UIScreen.screenHeight * 0.2, alignment: .top)
    }
}
