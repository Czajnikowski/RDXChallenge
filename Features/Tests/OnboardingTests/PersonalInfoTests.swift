//
//  PersonalInfoTests.swift
//  
//
//  Created by Maciek on 24/05/2023.
//

import XCTest
import ComposableArchitecture
@testable import Onboarding

@MainActor
final class OnboardingTests: XCTestCase {
    func testAllFieldsShouldBeFilledInPersonalInfoToEnableNextButton() async throws {
        let store = TestStore(
            initialState: PersonalInfo.State(),
            reducer: PersonalInfo(),
            observe: \.isNextButtonDisabled
        )

        XCTAssertTrue(store.state.isNextButtonDisabled)

        await store.send(.binding(.set(\.$firstName, "yo")))
        await store.send(.binding(.set(\.$lastName, "yo")))
        await store.send(.binding(.set(\.$phoneNumber, "yo"))) {
            $0 = false
        }

        await store.send(.binding(.set(\.$lastName, ""))) {
            $0 = true
        }
    }

    func testAllFieldsShouldBeFilledInCredentialsToEnableNextButton() async throws {
        let store = TestStore(
            initialState: Credentials.State(),
            reducer: Credentials(),
            observe: \.isNextButtonDisabled
        )

        XCTAssertTrue(store.state.isNextButtonDisabled)

        await store.send(.binding(.set(\.$email, "yo")))
        await store.send(.binding(.set(\.password, "yo"))) {
            $0 = false
        }

        await store.send(.binding(.set(\.$password, ""))) {
            $0 = true
        }
    }
}
