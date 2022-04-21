//
//  FinalPageView.swift
//  WalkTutorial
//
//  Created by Murilo Gonçalves on 20/04/22.
//

import SwiftUI
import SpriteKit

struct FinalPageView: View {
    private static let sceneWidth = UIScreen.screenWidth
    private static let sceneHeight = UIScreen.screenHeight * 0.6
    
    @State private var right = true
    
    var scene: FinalPageScene = {
        let scene = FinalPageScene()
        scene.size = CGSize(width: sceneWidth, height: sceneHeight)
        scene.scaleMode = .fill
        return scene
    }()
    
    var body: some View {
        ZStack {
            Color(red: 1, green: 0.937, blue: 0.776, opacity: 1)
                .ignoresSafeArea()
            VStack {
                TextView(text: Texts.final)
                
                SpriteView(scene: scene)
                    .frame(width: FinalPageView.sceneWidth, height: FinalPageView.sceneHeight)
                    .ignoresSafeArea()
                
                HStack {
                    NavigationLink(destination: FifthPageView().navigationBarBackButtonHidden(true)) {
                        BtnView(image: "backBtn")
                    }
                    Spacer()
                    Button(action: {
                        scene.arrowField.setGoalField(type: right ? .MOVE_TO_GOAL_LEFT : .MOVE_TO_GOAL_RIGHT)
                        right = !right
                    }, label: {
                        Image(right ? "left" : "right")
                            .resizable()
                            .renderingMode(.original)
                            .frame(width: UIScreen.screenWidth * 0.3, height: UIScreen.screenHeight * 0.15, alignment: .top)
                    })
                        .buttonStyle(PlainButtonStyle())
                    
                    Spacer()
                    Button(action: {
                        scene.arrowField.addObstacle()
                    }, label: {
                        Image("addObstacle")
                            .resizable()
                            .renderingMode(.original)
                            .frame(width: UIScreen.screenWidth * 0.3, height: UIScreen.screenHeight * 0.15, alignment: .top)
                    })
                        .buttonStyle(PlainButtonStyle())
                    }
            
                Spacer()
            }
        }
        .navigationTitle("")
        .navigationBarHidden(true)
        .navigationViewStyle(StackNavigationViewStyle())
    }
}


