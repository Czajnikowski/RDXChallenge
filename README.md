# RDXChallenge
Coding challenge, a part of the interview process for RDX.

## First things first
It was a fun challenge 🎉

Initially, I’ve been a bit sceptical about the tight timeframe, and the fact that I have never used the Composable Navigation before, but the fact that it introduced the solution to work with the `NavigationStack` (which is a super nice API) comforted me a bit, so I decided to take the challenge.

## How did I do?
As you suggested, I spent 5 hrs working on the solution. Well, obviously, I familiarized myself briefly with the spec, the domain and the `prerelease/1.0` branch the day before 🤓

Obviously, the app has a bunch of issues at the moment, but I decided to stop coding here and only mention some of them:
- I forgot about the last name in the Main module
- All the logic related to the sign in and out could have been extracted to a dedicated reducer
- Each onboarding step could have been placed in it's own module
- ~~There are some typos here and there~~
- ~~At the end of the day I refactored `.fireAndForget` into `.run` effects, but forgot about cancellation…~~
- `ProviderToStateReducer` is likely a mild overengineering
- ~~Some `struct`s can be simplified to `enum`s~~
- There is a duplication in onboarding steps - most of them can be generalized into some bindable state + validation (in a shape of the current `isNextButtonDisabled`)
- No tests (well, four that I added are a drop in the ocean)
- Tests were the only bonus that I aimed for in given time frame
- It can actually be done more ergonomically with the `NavigationLink(state:)`

Looking forward to your feedback and the next interview stage 🤷🏼‍♂️

Yours, Maciek.
