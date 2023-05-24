//
//  ContentView.swift
//  RDXChallenge
//
//  Created by Maciek on 24/05/2023.
//

import SwiftUI

public enum Maker {
    public static func makeScene() -> some Scene {
        WindowGroup {
            StartView()
        }
    }
}

struct StartView: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundColor(.accentColor)
            Text("Hello, world!")
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        StartView()
    }
}
