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
        case onboarding(Onboarding.Action)
        case main(Main.Action)
    }

    @Dependency(\.userDefaults) var userDefaults

    var body: some ReducerProtocol<State, Action> {
        Scope(
            state: /State.onboarding,
            action: /Action.onboarding,
            child: Onboarding.init
        )
        Scope(
            state: /State.main,
            action: /Action.main,
            child: Main.init
        )
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

                    return .fireAndForget {
                        userDefaults.set(
                            name,
                            forKey: "hardcoded key for now, sorry, no time"
                        )
                    }
                }

                return .none

            case .main(.signOutTapped):
                state = .onboarding()

                return .fireAndForget {
                    userDefaults.set(
                        String?.none,
                        forKey: "hardcoded key for now, sorry, no time"
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
    }
}

struct StartView_Previews: PreviewProvider {
    static var previews: some View {
        StartView()
    }
}
