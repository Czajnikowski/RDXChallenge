//
//  File.swift
//  
//
//  Created by Maciek on 24/05/2023.
//

import ComposableArchitecture
import SwiftUI
import Onboarding
import Main
import DependenciesAdditions

struct Start: Reducer {
    enum State {
        case onboarding(Onboarding.State = .init())
        case main(Main.State)
    }

    enum Action {
        case signedIn(LoadableStateAction<State>)

        case onboarding(Onboarding.Action)
        case main(Main.Action)
    }

    enum Constant {
        fileprivate static let signedInUserDefaultsKey = "hardcoded key for now, sorry, no time"
    }

    @Dependency(\.userDefaults) var userDefaults

    var body: some Reducer<State, Action> {
        Scope(
            state: \.self,
            action: /Action.signedIn
        ) {
            ProviderToStateReducer {
                userDefaults.string(forKey: Constant.signedInUserDefaultsKey)
                    .map(Main.State.init)
                    .map(State.main) ?? State.onboarding()
            }
        }

        Scope(
            state: /State.onboarding,
            action: /Action.onboarding,
            child: Onboarding.init
        )
        Scope(
            state: /State.main,
            action: /Action.main,
            child: EmptyReducer.init
        )

        signInAndOut
    }

    private var signInAndOut: some Reducer<State, Action> {
        Reduce { state, action in
            switch action {
            case .onboarding(.path(.element(id: _, action: .confirmPIN(.nextTapped)))):
                let personalInfo = (/State.onboarding)
                    .extract(from: state)?
                    .path
                    .compactMap((/Onboarding.Path.State.personalInfo).extract)
                    .first

                if let name = personalInfo?.firstName {
                    /// For some reason it doesn't work in the Preview 🤷🏼‍♂️
                    state = .main(.init(name: name))

                    return .run { _ in
                        userDefaults.set(
                            name,
                            forKey: Constant.signedInUserDefaultsKey
                        )
                    }
                }

                return .none

            case .main(.signOutTapped):
                state = .onboarding()

                return .run { _ in
                    userDefaults.set(
                        String?.none,
                        forKey: Constant.signedInUserDefaultsKey
                    )
                }

            default:
                return .none
            }
        }
    }
}

struct StartView: View {
    let store: StoreOf<Start> = Store(
        initialState: Start.State.onboarding(),
        reducer: Start.init
    )

    var body: some View {
        SwitchStore(store) {
            CaseLet(
                /Start.State.onboarding,
                 action: Start.Action.onboarding,
                 then: OnboardingView.init(store:)
            )
            CaseLet(
                /Start.State.main,
                 action: Start.Action.main,
                 then: MainView.init(store:)
            )
        }
        .task {
            ViewStore(store.stateless).send(.signedIn(.loadState))
        }
    }
}

struct StartView_Previews: PreviewProvider {
    static var previews: some View {
        StartView()
    }
}
