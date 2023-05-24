//
//  File.swift
//  
//
//  Created by Maciek on 24/05/2023.
//

import SwiftUI
import ComposableArchitecture

public struct ConfirmPIN: Reducer {
    public struct State: Equatable {
        let newPIN: String
        @BindingState var confirmationPIN: String = ""

        public init(newPIN: String) {
            self.newPIN = newPIN
        }
    }

    public enum Action: BindableAction {
        case binding(BindingAction<State>)
        case nextTapped
    }

    public var body: some Reducer<State, Action> {
        BindingReducer()
    }
}

struct ConfirmPINView: View {
    let store: StoreOf<ConfirmPIN>

    var body: some View {
        WithViewStore(store, observe: identity) { viewStore in
            VStack {
                TextField("Confirm PIN", text: viewStore.binding(\.$confirmationPIN))
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

extension ConfirmPIN.State {
    var isNextButtonDisabled: Bool {
        newPIN != confirmationPIN
    }
}

struct ConfirmPIN_Previews: PreviewProvider {
    static var previews: some View {
        ConfirmPINView(store: .init(initialState: .init(newPIN: "123"), reducer: ConfirmPIN()))
    }
}
