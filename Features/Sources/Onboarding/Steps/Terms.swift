//
//  File.swift
//  
//
//  Created by Maciek on 24/05/2023.
//

import SwiftUI
import ComposableArchitecture

public struct Terms: Reducer {
    public struct State {
        var isAccepted: Bool = false

        public init() {}
    }

    public enum Action {
        case acceptToggleTapped(Bool)
        case nextTapped
    }

    public func reduce(into state: inout State, action: Action) -> Effect<Action> {
        switch action {
        case let .acceptToggleTapped(isAccepted):
            state.isAccepted = isAccepted

            return .none

        default:
            return .none
        }
    }
}

struct TermsView: View {
    let store: StoreOf<Terms>

    var body: some View {
        WithViewStore(
            store,
            observe: \.isAccepted
        ) { viewStore in
            VStack {
                Toggle(
                    "Terms... do you accept?",
                    isOn: viewStore.binding(
                        get: identity,
                        send: Terms.Action.acceptToggleTapped
                    )
                )
                Button {
                    viewStore.send(.nextTapped)
                } label: {
                    Text("Next")
                }
                .disabled(!viewStore.state)
            }
        }
    }
}

struct Terms_Previews: PreviewProvider {
    static var previews: some View {
        TermsView(store: .init(initialState: .init(), reducer: Terms.init))
    }
}
