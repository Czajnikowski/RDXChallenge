//
//  File.swift
//  
//
//  Created by Maciek on 24/05/2023.
//

import SwiftUI
import ComposableArchitecture

struct Credentials: Reducer {
    typealias State = Void
    typealias Action = Void

    func reduce(into state: inout State, action: Action) -> Effect<Action> {
        .none
    }
}

struct CredentialsView: View {
    let store: StoreOf<Credentials>
    
    var body: some View {
        Text("Credentials")
    }
}

struct Credentials_Previews: PreviewProvider {
    static var previews: some View {
        Text("Hello, world!")
    }
}
