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

    public var body: some Reducer<State, Action> {
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
    var isNextButtonDisabled: Bool {
        [firstName, lastName, phoneNumber].allNotEmpty
    }
}

struct PersonalInfo_Previews: PreviewProvider {
    static var previews: some View {
        PersonalInfoView(store: .init(initialState: .init(), reducer: PersonalInfo()))
    }
}

extension Collection where Element == String {
    var allNotEmpty: Bool {
        first(where: { $0.isEmpty }) != nil
    }
}
