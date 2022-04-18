import SwiftUI
import SpriteKit

struct ContentView: View {
    var scene: ArrowFieldScene {
        let scene = ArrowFieldScene()
        scene.size = UIScreen.screenSize
        scene.scaleMode = .fill
        return scene
    }
    
    var body: some View {
//        VStack {
//            SpriteView(scene: scene)
//                .frame(width: 800, height: 1000)
//                        .ignoresSafeArea()
//            HStack {
//                Button("Attractive", action: setAttractive)
//                    .buttonStyle(.automatic)
//                Button("Spiral", action: setSpiral)
//                    .buttonStyle(.automatic)
//            }
//        }
        IntroView()
    }

    func setAttractive() {
        scene.arrowField.setGoalField(type: .ATTRACTIVE)
    }
    
    func setSpiral() {
        scene.arrowField.setGoalField(type: .CW_SPIRAL)
    }
}
