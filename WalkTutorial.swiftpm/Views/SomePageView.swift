//
//  FirstPage.swift
//
//
//  Created by Murilo Gonçalves on 19/04/22.
//

import SwiftUI
import SpriteKit

struct SomePageView: View {
    var scene: ArrowFieldScene {
        let scene = ArrowFieldScene()
        scene.size = UIScreen.screenSize
        scene.scaleMode = .fill
        return scene
    }
    
    var body: some View {
        ZStack {
            Color(red: 1, green: 0.937, blue: 0.776, opacity: 1)
                .ignoresSafeArea()
            SpriteView(scene: scene)
                .frame(width: 800, height: 1000)
                        .ignoresSafeArea()
//            HStack {
//                Button("Attractive", action: setAttractive)
//                    .buttonStyle(.automatic)
//                Button("Spiral", action: setSpiral)
//                    .buttonStyle(.automatic)
//            }
        }
    }

    func setAttractive() {
        scene.arrowField.setGoalField(type: .ATTRACTIVE)
    }
    
    func setSpiral() {
        scene.arrowField.setGoalField(type: .CW_SPIRAL)
    }
}
