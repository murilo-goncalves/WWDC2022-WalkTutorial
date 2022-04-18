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
        ZStack {
            Color(red: 1, green: 0.937, blue: 0.776, opacity: 1)
                .ignoresSafeArea()
            VStack {
                Spacer()
                Text("WALK")
                Text("TUTORIAL")
                Spacer()
                SpriteView(scene: scene)
                    .frame(width: sceneWidth, height: sceneHeight)
                    .ignoresSafeArea()
                Spacer()
                
            }
        }
    }
}
