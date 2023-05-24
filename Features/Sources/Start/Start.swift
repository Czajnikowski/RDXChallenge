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
        case onboarding
        case main
    }

    enum Action {
        case onboarding
        case main
    }

    func reduce(into state: inout State, action: Action) -> ComposableArchitecture.Effect<Action> {
        .none
    }
}

struct StartView: View {
    let store: StoreOf<Start> = Store(
        initialState: Start.State.onboarding,
        reducer: Start.init
    )

    var body: some View {
        SwitchStore(store) {
            CaseLet(
                /Start.State.onboarding,
                 action: { Start.Action.onboarding },
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

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        StartView()
    }
}

