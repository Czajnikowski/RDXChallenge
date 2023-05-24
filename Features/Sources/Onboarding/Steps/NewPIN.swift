//
//  File.swift
//  
//
//  Created by Maciek on 24/05/2023.
//

import SwiftUI
import ComposableArchitecture

public struct NewPIN: Reducer {
    public struct State: Equatable {
        @BindingState var newPIN: String = ""

        public init() {}
    }

    public enum Action: BindableAction {
        case binding(BindingAction<State>)
        case nextTapped
    }

    public var body: some ReducerProtocol<State, Action> {
        BindingReducer()
    }
}

struct NewPINView: View {
    let store: StoreOf<NewPIN>

    var body: some View {
        WithViewStore(store, observe: identity) { viewStore in
            VStack {
                TextField("New PIN", text: viewStore.binding(\.$newPIN))
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

extension NewPIN.State {
    var isNextButtonDisabled: Bool {
        newPIN.trimmingCharacters(in: .whitespacesAndNewlines) == ""
    }
}

struct NewPIN_Previews: PreviewProvider {
    static var previews: some View {
        NewPINView(store: .init(initialState: .init(), reducer: NewPIN()))
    }
}
