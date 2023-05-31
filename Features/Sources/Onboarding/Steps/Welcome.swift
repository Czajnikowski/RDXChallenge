import SwiftUI
import ComposableArchitecture

public enum Welcome {
    public typealias State = Void
    public typealias Action = Never
}

struct WelcomeView: View {
    let store: Store<Welcome.State, Welcome.Action>

    var body: some View {
        Text("Welcome!")
        NavigationLink(state: Onboarding.Path.State.terms()) {
            Text("Start")
        }
        .buttonStyle(.bordered)
    }
}
