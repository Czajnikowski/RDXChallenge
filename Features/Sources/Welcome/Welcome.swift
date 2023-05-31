import SwiftUI
import ComposableArchitecture
import Utilities

public enum Welcome {
    public typealias State = Void
    public typealias Action = Never
}

public struct WelcomeView<DestinationState>: View {
    let store: Store<Welcome.State, Welcome.Action>
    let navigationLinkModifier: NavigationLinkModifier<DestinationState>

    public init(
        store: Store<Welcome.State, Welcome.Action>,
        navigationLinkModifier: NavigationLinkModifier<DestinationState>
    ) {
        self.store = store
        self.navigationLinkModifier = navigationLinkModifier
    }

    public var body: some View {
        Text("Welcome!")
        Text("Start")
            .modifier(navigationLinkModifier)
            .buttonStyle(.bordered)
    }
}
