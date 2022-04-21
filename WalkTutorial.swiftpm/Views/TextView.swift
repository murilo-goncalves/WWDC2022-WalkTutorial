//
//  TextView.swift
//  
//
//  Created by Murilo Gonçalves on 19/04/22.
//

import SwiftUI

struct TextView: View {
    let text: String
    
    var body: some View {
        Text(text)
            .font(.custom("ChalkboardSE-Light", size: 48))
            .padding()
            .padding()
            .foregroundColor(Color(UIColor(red: 0.2, green: 0.2, blue: 0.2, alpha: 1)))
            .minimumScaleFactor(0.2)
    }
}
