import SwiftUI

public enum Maker {
    public static func makeScene() -> some Scene {
        WindowGroup {
            StartView()
        }
    }
}
