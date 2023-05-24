//
//  File.swift
//  
//
//  Created by Maciek on 24/05/2023.
//

import SwiftUI
import ComposableArchitecture

public struct Terms: Reducer {
    public struct State: Equatable {
        @BindingState var isAccepted: Bool = false

        public init() {}
    }

    public enum Action: BindableAction {
        case binding(BindingAction<State>)
        case acceptToggleTapped(Bool)
        case nextTapped
    }

    public var body: some Reducer<State, Action> {
        BindingReducer()
        Reduce { state, action in
            switch action {
            case let .acceptToggleTapped(isAccepted):
                state.isAccepted = isAccepted

                return .none

            default:
                return .none
            }
        }
    }
}

struct TermsView: View {
    let store: StoreOf<Terms>

    var body: some View {
        WithViewStore(
            store,
            observe: identity
        ) { viewStore in
            VStack {
                Toggle(
                    "Terms... do you accept?",
                    isOn: viewStore.binding(\.$isAccepted)
                )
                Button {
                    viewStore.send(.nextTapped)
                } label: {
                    Text("Next")
                }
                .disabled(viewStore.isNextButtonDisabled)
            }
        }
    }
}

extension Terms.State {
    var isNextButtonDisabled: Bool {
        !isAccepted
    }
}

struct Terms_Previews: PreviewProvider {
    static var previews: some View {
        TermsView(store: .init(initialState: .init(), reducer: Terms.init))
    }
}
