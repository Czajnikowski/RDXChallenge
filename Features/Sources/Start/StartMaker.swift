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
