//
//  File.swift
//  
//
//  Created by Maciek on 24/05/2023.
//

/// ⚠️ The `_` suffix (or anthing) in the name is necessary to distinguish our file from a module's main entry point

import SwiftUI
import ComposableArchitecture

public struct Main: Reducer {
    public typealias State = Void
    public typealias Action = Void

    public func reduce(into state: inout State, action: Action) -> Effect<Action> {
        .none
    }
}

public struct MainView: View {
    private let store: StoreOf<Main>

    public init(store: StoreOf<Main>) {
        self.store = store
    }

    public var body: some View {
        Text("Main!")
    }
}
