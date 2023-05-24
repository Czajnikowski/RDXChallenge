//
//  File.swift
//  
//
//  Created by Maciek on 24/05/2023.
//

import ComposableArchitecture

public struct ProviderToStateReducer<State>: ReducerProtocol {
    public typealias Action = LoadableStateAction<State>

    private let provideState: @Sendable () async throws -> State

    public init(_ provideState: @escaping @Sendable () async throws -> State) {
        self.provideState = provideState
    }

    public var body: some ReducerProtocol<State, Action> {
        Reduce { state, action in
            switch action {
            case .loadState:
                return .task { [provideState] in
                    return .loaded(try await provideState())
                }
            case let .loaded(newState):
                state = newState

                return .none
            }
        }
    }
}

public enum LoadableStateAction<State> {
    case loadState
    case loaded(State)
}
