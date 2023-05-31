import ComposableArchitecture
import SwiftUI

public struct NavigationLinkModifier<State>: ViewModifier {
    let state: State

    public init(state: State) {
        self.state = state
    }

    public func body(content: Content) -> some View {
        NavigationLink(state: state) {
            content
        }
    }
}
