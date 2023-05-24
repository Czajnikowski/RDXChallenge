//
//  File.swift
//  
//
//  Created by Maciek on 24/05/2023.
//

import SwiftUI
import ComposableArchitecture

public struct NewPin: Reducer {
    public typealias State = Void
    public typealias Action = Void

    public func reduce(into state: inout State, action: Action) -> Effect<Action> {
        .none
    }
}

struct NewPinView: View {
    let store: StoreOf<NewPin>

    var body: some View {
        Text("NewPin")
    }
}

struct NewPin_Previews: PreviewProvider {
    static var previews: some View {
        NewPinView(store: .init(initialState: (), reducer: NewPin()))
    }
}
