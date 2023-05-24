//
//  File.swift
//  
//
//  Created by Maciek on 24/05/2023.
//

import SwiftUI
import ComposableArchitecture

public struct Onboarding: Reducer {
    public typealias State = Void
    public typealias Action = Void

    public func reduce(into state: inout State, action: Action) -> Effect<Action> {
        .none
    }
}

public struct OnboardingView: View {
    private let store: StoreOf<Onboarding>

    public init(store: StoreOf<Onboarding>) {
        self.store = store
    }

    public var body: some View {
        Text("Welcome!")
    }
}
