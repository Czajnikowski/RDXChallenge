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
        await store.send(.binding(.set(\.$password, "yo"))) {
            $0 = false
        }

        await store.send(.binding(.set(\.$password, ""))) {
            $0 = true
        }
    }

    func testNewPINHasToBeNonEmptyToEnableNextButton() async throws {
        let store = TestStore(
            initialState: NewPIN.State(),
            reducer: NewPIN(),
            observe: \.isNextButtonDisabled
        )

        XCTAssertTrue(store.state.isNextButtonDisabled)

        await store.send(.binding(.set(\.$newPIN, "yo"))) {
            $0 = false
        }

        await store.send(.binding(.set(\.$newPIN, "  "))) {
            $0 = true
        }
    }

    func testNewPINBinding() async throws {
        let store = TestStore(
            initialState: Onboarding.State(path: .init([.newPIN()])),
            reducer: Onboarding(),
            observe: \.path.first
        )

        let newPINId = store.state.path.ids.elements.first
        XCTAssertNotNil(newPINId)

        await store.send(.path(.element(id: newPINId!, action: .newPIN(.binding(.set(\.$newPIN, "123")))))) {
            try (/Onboarding.Path.State.newPIN).modify(&$0) { $0.newPIN = "123" }
        }

        /// Okay, I tried to test something more meaningful here, but testability of that new API is something I have to figure out first 🤓
        /// I'll proceed with a couple of small refactorings without tests. I have a bit more than 20 mins left 😅
    }
}
