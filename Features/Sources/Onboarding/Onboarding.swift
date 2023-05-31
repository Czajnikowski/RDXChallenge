import SwiftUI
import ComposableArchitecture
import Utilities
import Welcome

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
        case welcome
        case path(StackAction<Path.State, Path.Action>)
    }

    public init() {}

    public var body: some Reducer<State, Action> {
        EmptyReducer().forEach(
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
                store: store.stateless.actionless,
                navigationLinkModifier: NavigationLinkModifier(
                    state: Onboarding.Path.State.terms()
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
                     action: Onboarding.Path.Action.newPIN
                ) { store in
                    NewPINView(store: store) {
                        .confirmPIN(
                            .init(
                                newPIN: ViewStore(store, observe: \.newPIN).state
                            )
                        )
                    }
                }

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
