//
//  File.swift
//  
//
//  Created by Maciek on 24/05/2023.
//

import SwiftUI
import ComposableArchitecture

public struct PersonalInfo: Reducer {
    public struct State: Equatable {
        @BindingState public var firstName: String = ""
        @BindingState var lastName: String = ""
        @BindingState var phoneNumber: String = ""

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

struct PersonalInfoView: View {
    let store: StoreOf<PersonalInfo>

    var body: some View {
        WithViewStore(store, observe: identity) { viewStore in
            VStack {
                TextField("First name", text: viewStore.binding(\.$firstName))
                TextField("Last name", text: viewStore.binding(\.$lastName))
                TextField("Phone number", text: viewStore.binding(\.$phoneNumber))
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

extension PersonalInfo.State {
    fileprivate var isNextButtonDisabled: Bool {
        [firstName, lastName, phoneNumber]
            .contains { $0.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty }
    }
}

struct PersonalInfo_Previews: PreviewProvider {
    static var previews: some View {
        PersonalInfoView(store: .init(initialState: .init(), reducer: PersonalInfo()))
    }
}
