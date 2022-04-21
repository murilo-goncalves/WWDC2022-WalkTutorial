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
    private static let sceneHeight = UIScreen.screenHeight * 0.5
    
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
                
                Group {
                    Text(Texts.sixth) +
                    Text(" right ").foregroundColor(Color(UIColor(red: 0.762, green: 0.309, blue: 0.975, alpha: 1))) + Text("and") +
                    Text(" left ").foregroundColor(Color(UIColor(red: 0.309, green: 0.455, blue: 0.975, alpha: 1))) +
                    Text("'pusher' fields.")
                }
                .font(.custom("ChalkboardSE-Light", size: 48))
                .padding()
                .padding()
                .foregroundColor(Color(UIColor(red: 0.2, green: 0.2, blue: 0.2, alpha: 1)))
                .minimumScaleFactor(0.2)
                
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
                    }
            
                Spacer()
            }
        }
        .navigationTitle("")
        .navigationBarHidden(true)
        .navigationViewStyle(StackNavigationViewStyle())
    }
}


