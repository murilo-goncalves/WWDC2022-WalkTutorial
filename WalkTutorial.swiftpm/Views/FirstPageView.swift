//
//  FirstPage.swift
//  
//
//  Created by Murilo Gonçalves on 19/04/22.
//

import SwiftUI
import SpriteKit

struct FirstPageView: View {
    private let sceneWidth = UIScreen.screenWidth
    private let sceneHeight = UIScreen.screenHeight * 0.4
    
    var scene: FirstPageScene {
        let scene = FirstPageScene()
        scene.size = CGSize(width: sceneWidth, height: sceneHeight)
        scene.scaleMode = .fill
        return scene
    }
    
    var body: some View {
        ZStack {
            Color(red: 1, green: 0.937, blue: 0.776, opacity: 1)
                .ignoresSafeArea()
            VStack {
                TextView(text: Texts.first)
                SpriteView(scene: scene)
                    .frame(width: sceneWidth, height: sceneHeight)
                    .ignoresSafeArea()
                
                HStack {
                    NavigationLink(destination: IntroView().navigationBarBackButtonHidden(true)) {
                        BtnView(image: "backBtn")
                    }
                    Spacer()
                    NavigationLink(destination: SecondPageView()) {
                        BtnView(image: "nextBtn")
                    }
                }
            }
        }
        .navigationTitle("")
        .navigationBarHidden(true)
        .navigationViewStyle(StackNavigationViewStyle())
    }
}
