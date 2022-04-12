import SwiftUI
import SpriteKit

extension UIScreen {
   static let screenWidth = UIScreen.main.bounds.size.width
   static let screenHeight = UIScreen.main.bounds.size.height
   static let screenSize = UIScreen.main.bounds.size
}

struct ContentView: View {
    var scene: ArrowFieldScene {
        let scene = ArrowFieldScene()
        scene.size = UIScreen.screenSize
        scene.scaleMode = .fill
        return scene
    }
    
    var body: some View {
        SpriteView(scene: scene)
            .frame(width: UIScreen.screenWidth, height: UIScreen.screenHeight)
                    .ignoresSafeArea()
    }
}
