//
//  File.swift
//  
//
//  Created by Maciek on 24/05/2023.
//

import SwiftUI
import ComposableArchitecture

public struct Welcome {
    public typealias State = Void
    public enum Action {
        case startTapped
    }
}

struct WelcomeView: View {
    let store: Store<Welcome.State, Welcome.Action>

    var body: some View {
        Text("Welcome!")
        Button {
            ViewStore(store).send(.startTapped)
        } label: {
            Text("Start")
        }
    }
}
