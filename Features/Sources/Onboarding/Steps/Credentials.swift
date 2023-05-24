//
//  File.swift
//  
//
//  Created by Maciek on 24/05/2023.
//

import SwiftUI
import ComposableArchitecture

public struct Credentials: Reducer {
    public struct State: Equatable {
        @BindingState var email: String = ""
        @BindingState var password: String = ""

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

struct CredentialsView: View {
    let store: StoreOf<Credentials>
    
    var body: some View {
        WithViewStore(store, observe: identity) { viewStore in
            VStack {
                TextField("Email", text: viewStore.binding(\.$email))
                TextField("Password", text: viewStore.binding(\.$password))
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

extension Credentials.State {
    fileprivate var isNextButtonDisabled: Bool {
        email.trimmingCharacters(in: .whitespacesAndNewlines) == ""
        || password.trimmingCharacters(in: .whitespacesAndNewlines) == ""
    }
}

struct Credentials_Previews: PreviewProvider {
    static var previews: some View {
        CredentialsView(
            store: .init(
                initialState: .init(),
                reducer: Credentials.init
            )
        )
    }
}