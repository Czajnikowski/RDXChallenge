import SwiftUI
import ComposableArchitecture

public struct Onboarding: Reducer {
    public struct State {
        public var path = StackState<Path.State>()

        public init(
            path: StackState<Path.State> = StackState<Path.State>()
        ) {
            self.path = path
        }
    }

    public enum Action {
        case welcome(Welcome.Action)
        case path(StackAction<Path.State, Path.Action>)
    }

    public init() {}

    public var body: some Reducer<State, Action> {
        Reduce { state, action in
            switch action {
            case .welcome(.startTapped):
                state.path.append(.terms())

                return .none

            case let .path(.element(id: pathElementID, action: pathElementAction)):
                switch pathElementAction {
                case .terms(.nextTapped):
                    state.path.append(.credentials())

                case .credentials(.nextTapped):
                    state.path.append(.personalInfo())

                case .personalInfo(.nextTapped):
                    state.path.append(.newPIN())

                case .newPIN(.nextTapped):
                    if
                        let newPINElement = state.path[id: pathElementID],
                        case let Path.State.newPIN(newPINState) = newPINElement
                    {
                        state.path.append(.confirmPIN(.init(newPIN: newPINState.newPIN)))
                    }

                default:
                    break
                }

                return .none

            default:
                return .none
            }
        }
        .forEach(
            \.path,
             action: /Action.path,
             destination: Path.init
        )
    }

    public struct Path: Reducer {
        public enum State: Equatable {
            case terms(Terms.State = .init())
            case credentials(Credentials.State = .init())
            case personalInfo(PersonalInfo.State = .init())
            case newPIN(NewPIN.State = .init())
            case confirmPIN(ConfirmPIN.State)
        }

        public enum Action {
            case terms(Terms.Action)
            case credentials(Credentials.Action)
            case personalInfo(PersonalInfo.Action)
            case newPIN(NewPIN.Action)
            case confirmPIN(ConfirmPIN.Action)
        }

        public var body: some Reducer<State, Action> {
            Scope(
                state: /State.terms,
                action: /Action.terms,
                child: Terms.init
            )
            Scope(
                state: /State.credentials,
                action: /Action.credentials,
                child: Credentials.init
            )
            Scope(
                state: /State.personalInfo,
                action: /Action.personalInfo,
                child: PersonalInfo.init
            )
            Scope(
                state: /State.newPIN,
                action: /Action.newPIN,
                child: NewPIN.init
            )
            Scope(
                state: /State.confirmPIN,
                action: /Action.confirmPIN,
                child: ConfirmPIN.init
            )
        }
    }
}

public struct OnboardingView: View {
    private let store: StoreOf<Onboarding>

    public init(store: StoreOf<Onboarding>) {
        self.store = store
    }

    public var body: some View {
        NavigationStackStore(
            store.scope(
                state: \.path,
                action: Onboarding.Action.path
            )
        ) {
            WelcomeView(
                store: store.stateless.scope(
                    state: identity,
                    action: Onboarding.Action.welcome
                )
            )
        } destination: {
            switch $0 {
            case .terms:
                CaseLet(
                    /Onboarding.Path.State.terms,
                     action: Onboarding.Path.Action.terms,
                     then: TermsView.init(store:)
                )

            case .credentials:
                CaseLet(
                    /Onboarding.Path.State.credentials,
                     action: Onboarding.Path.Action.credentials,
                     then: CredentialsView.init(store:)
                )

            case .personalInfo:
                CaseLet(
                    /Onboarding.Path.State.personalInfo,
                     action: Onboarding.Path.Action.personalInfo,
                     then: PersonalInfoView.init(store:)
                )

            case .newPIN:
                CaseLet(
                    /Onboarding.Path.State.newPIN,
                     action: Onboarding.Path.Action.newPIN,
                     then: NewPINView.init(store:)
                )

            case .confirmPIN:
                CaseLet(
                    /Onboarding.Path.State.confirmPIN,
                     action: Onboarding.Path.Action.confirmPIN,
                     then: ConfirmPINView.init(store:)
                )
            }
        }
    }
}

struct Onboarding_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingView(
            store: .init(
                initialState: .init(),
                reducer: Onboarding.init
            )
        )
    }
}
