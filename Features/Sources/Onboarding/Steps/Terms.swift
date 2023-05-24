//
//  File.swift
//  
//
//  Created by Maciek on 24/05/2023.
//

import SwiftUI
import ComposableArchitecture

struct Terms: Reducer {
    typealias State = Void
    typealias Action = Void

    func reduce(into state: inout State, action: Action) -> Effect<Action> {
        .none
    }
}

struct TermsView: View {
    let store: StoreOf<Terms>

    var body: some View {
        Text("Terms...")
    }
}
