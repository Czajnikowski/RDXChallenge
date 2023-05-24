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

struct Start: Reducer {
    enum State {
        case onboarding(Onboarding.State)
        case main
    }

    enum Action {
        case onboarding(Onboarding.Action)
        case main
    }

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
    }
}

struct StartView: View {
    let store: StoreOf<Start> = Store(
        initialState: Start.State.onboarding(.init()),
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
                 action: { Start.Action.main },
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
