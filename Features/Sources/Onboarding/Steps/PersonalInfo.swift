//
//  File.swift
//  
//
//  Created by Maciek on 24/05/2023.
//

import SwiftUI
import ComposableArchitecture

struct PersonalInfo: Reducer {
    typealias State = Void
    typealias Action = Void

    func reduce(into state: inout State, action: Action) -> Effect<Action> {
        .none
    }
}

struct PersonalInfoView: View {
let store: StoreOf<PersonalInfo>

    var body: some View {
        Text("PersonalInfo")
    }
}

struct PersonalInfo_Previews: PreviewProvider {
    static var previews: some View {
        PersonalInfoView(store: .init(initialState: (), reducer: PersonalInfo()))
    }
}
