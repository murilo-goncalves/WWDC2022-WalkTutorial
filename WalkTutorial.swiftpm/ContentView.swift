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
        VStack {
            SpriteView(scene: scene)
                .frame(width: 300, height: 600)
                        .ignoresSafeArea()
            HStack {
                Button("Attractive", action: setAttractive)
                    .buttonStyle(.automatic)
                Button("Spiral", action: setSpiral)
                    .buttonStyle(.automatic)
            }
        }
    }

    func setAttractive() {
        scene.goalField.setField(type: .ATTRACTIVE)
    }
    
    func setSpiral() {
        scene.goalField.fillColor = .black
    }
}
