/// ⚠️ The `_` suffix (or anthing) in the name is necessary to distinguish our file from a module's main entry point

import SwiftUI
import ComposableArchitecture

public enum Main {
    public struct State {
        let name: String

        public init(name: String) {
            self.name = name
        }
    }

    public enum Action {
        case signOutTapped
    }
}

public struct MainView: View {
    private let store: Store<Main.State, Main.Action>

    public init(store: Store<Main.State, Main.Action>) {
        self.store = store
    }

    public var body: some View {
        WithViewStore(store, observe: \.name) { viewStore in
            VStack {
                Text("Hello \(viewStore.state)!")
                Button {
                    viewStore.send(.signOutTapped)
                } label: {
                    Text("Sign out")
                }
            }
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView(
            store: .init(
                initialState: .init(name: "Yo"),
                reducer: EmptyReducer.init
            )
        )
    }
}
