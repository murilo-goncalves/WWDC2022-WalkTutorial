//
//  RobotNode.swift
//  WalkTutorial
//
//  Created by Murilo Gonçalves on 18/04/22.
//

import SwiftUI
import SpriteKit

struct IntroView: View {
    private let sceneWidth = UIScreen.screenWidth
    private let sceneHeight = UIScreen.screenHeight / 3
    
    var scene: IntroAnimationScene {
        let scene = IntroAnimationScene()
        scene.size = CGSize(width: sceneWidth, height: sceneHeight)
        scene.scaleMode = .fill
        return scene
    }
    
    var body: some View {
        NavigationView {
            ZStack {
                Color(red: 1, green: 0.937, blue: 0.776, opacity: 1)
                    .ignoresSafeArea()
                VStack {
                    Image(uiImage: UIImage(named: "title")!)
                        .resizable()
                        .frame(width: UIScreen.screenWidth * 0.8, height: UIScreen.screenHeight * 0.3, alignment: .top)
                        .shadow(color: Color(.lightGray), radius: 15, x: 0, y: 0)
                    Spacer()
                    SpriteView(scene: scene)
                        .frame(width: sceneWidth, height: sceneHeight)
                        .ignoresSafeArea()
                    Spacer()
                    NavigationLink(destination: FirstPageView().navigationBarBackButtonHidden(true)) {
                        Image("startBtn")
                            .resizable()
                            .renderingMode(.original)
                            .frame(width: UIScreen.screenWidth * 0.5, height: UIScreen.screenHeight * 0.2, alignment: .top)
                    }
                    Spacer()
                }
            }
        }
        .navigationTitle("")
        .navigationBarHidden(true)
        .navigationViewStyle(StackNavigationViewStyle())
    }
}
