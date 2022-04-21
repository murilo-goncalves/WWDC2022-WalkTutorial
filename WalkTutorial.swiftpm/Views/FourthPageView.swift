//
//  FourthPageView.swift
//  
//
//  Created by Murilo Gonçalves on 20/04/22.
//

import SwiftUI
import SpriteKit

struct FourthPageView: View {
    private let sceneWidth = UIScreen.screenWidth
    private let sceneHeight = UIScreen.screenHeight * 0.5
    
    var scene: FourthPageScene {
        let scene = FourthPageScene()
        scene.size = CGSize(width: sceneWidth, height: sceneHeight)
        scene.scaleMode = .fill
        return scene
    }
    
    var body: some View {
        ZStack {
            Color(red: 1, green: 0.937, blue: 0.776, opacity: 1)
                .ignoresSafeArea()
            VStack {
                TextView(text: Texts.fourth)
                SpriteView(scene: scene)
                    .frame(width: sceneWidth, height: sceneHeight)
                    .ignoresSafeArea()
                
                HStack {
                    NavigationLink(destination: ThirdPageView().navigationBarBackButtonHidden(true)) {
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

