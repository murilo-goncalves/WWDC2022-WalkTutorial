//
//  SixthPageView.swift
//  
//
//  Created by Murilo Gonçalves on 20/04/22.
//

import SwiftUI
import SpriteKit

struct SixthPageView: View {
    private static let sceneWidth = UIScreen.screenWidth
    private static let sceneHeight = UIScreen.screenHeight * 0.5
    
    var scene: SixthPageScene = {
        let scene = SixthPageScene()
        scene.size = CGSize(width: sceneWidth, height: sceneHeight)
        scene.scaleMode = .fill
        return scene
    }()
    
    var body: some View {
        ZStack {
            Color(red: 1, green: 0.937, blue: 0.776, opacity: 1)
                .ignoresSafeArea()
            VStack {
                
                Group {
                    Text(Texts.sixth) +
                    Text(" clockwise ").foregroundColor(Color(UIColor(red: 0.762, green: 0.309, blue: 0.975, alpha: 1))) + Text("or") +
                    Text(" counter-clockwise ").foregroundColor(Color(UIColor(red: 0.309, green: 0.455, blue: 0.975, alpha: 1))) +
                    Text("directions.")
                }
                .font(.custom("ChalkboardSE-Light", size: 48))
                .padding()
                .padding()
                .foregroundColor(Color(UIColor(red: 0.2, green: 0.2, blue: 0.2, alpha: 1)))
                .minimumScaleFactor(0.2)
                
                SpriteView(scene: scene)
                    .frame(width: SixthPageView.sceneWidth, height: SixthPageView.sceneHeight)
                    .ignoresSafeArea()
                
                HStack {
                    NavigationLink(destination: FourthPageView().navigationBarBackButtonHidden(true)) {
                        BtnView(image: "backBtn")
                    }
                    Spacer()
                    NavigationLink(destination: FifthPageView()) {
                        BtnView(image: "nextBtn")
                    }
                }
                
                Spacer()
            }
        }
        .navigationTitle("")
        .navigationBarHidden(true)
        .navigationViewStyle(StackNavigationViewStyle())
    }
}


