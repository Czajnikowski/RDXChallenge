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

    public var body: some Reducer<State, Action> {
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
    var isNextButtonDisabled: Bool {
        [email, password].allNotEmpty
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
