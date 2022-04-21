//
//  ThirdPageView.swift
//  WalkTutorial
//
//  Created by Murilo Gonçalves on 20/04/22.
//

import SwiftUI
import SpriteKit

struct ThirdPageView: View {
    private let sceneWidth = UIScreen.screenWidth
    private let sceneHeight = UIScreen.screenHeight * 0.45
    
    var scene: ThirdPageScene {
        let scene = ThirdPageScene()
        scene.size = CGSize(width: sceneWidth, height: sceneHeight)
        scene.scaleMode = .fill
        return scene
    }
    
    var body: some View {
        ZStack {
            Color(red: 1, green: 0.937, blue: 0.776, opacity: 1)
                .ignoresSafeArea()
            VStack {
                TextView(text: Texts.third)
                SpriteView(scene: scene)
                    .frame(width: sceneWidth, height: sceneHeight)
                    .ignoresSafeArea()
                
                
                HStack {
                    NavigationLink(destination: SecondPageView().navigationBarBackButtonHidden(true)) {
                        BtnView(image: "backBtn")
                    }
                    Spacer()
                    NavigationLink(destination: FourthPageView()) {
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

