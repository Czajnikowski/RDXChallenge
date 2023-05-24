//
//  File.swift
//  
//
//  Created by Maciek on 24/05/2023.
//

/// ⚠️ The `_` suffix (or anthing) in the name is necessary to distinguish our file from a module's main entry point

import SwiftUI
import ComposableArchitecture

public struct Main: Reducer {
    public struct State {
        let name: String

        public init(name: String) {
            self.name = name
        }
    }

    public enum Action {
        case signOutTapped
    }

    public init() {}

    public func reduce(into state: inout State, action: Action) -> Effect<Action> {
        .none
    }
}

public struct MainView: View {
    private let store: StoreOf<Main>

    public init(store: StoreOf<Main>) {
        self.store = store
    }

    public var body: some View {
        WithViewStore(store, observe: { $0.name }) { viewStore in
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
