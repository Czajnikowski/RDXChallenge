//
//  File.swift
//  
//
//  Created by Maciek on 24/05/2023.
//

import SwiftUI
import ComposableArchitecture

public struct Onboarding: Reducer {
    public struct State {
        var path = StackState<Path.State>()

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

    public var body: some ReducerProtocol<State, Action> {
        Reduce { state, action in
            switch action {
            case .welcome(.startTapped):
                state.path.append(.terms())

                return .none

            default:
                return .none
            }
        }
    }

    public struct Path: Reducer {
        public enum State {
            case terms(Terms.State = .init())
        }

        public enum Action {
            case terms(Terms.Action)
        }

        public var body: some ReducerProtocol<State, Action> {
            Scope(
                state: /State.terms,
                action: /Action.terms,
                child: Terms.init
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
                    state: { $0 },
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
