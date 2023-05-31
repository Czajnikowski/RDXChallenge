import SwiftUI
import ComposableArchitecture
import Utilities

public enum Welcome {
    public typealias State = Void
    public typealias Action = Never
}

struct WelcomeView<DestinationState>: View {
    let store: Store<Welcome.State, Welcome.Action>

    let navigationLinkModifier: NavigationLinkModifier<DestinationState>

    var body: some View {
        Text("Welcome!")
        Text("Start")
            .modifier(navigationLinkModifier)
            .buttonStyle(.bordered)
    }
}
