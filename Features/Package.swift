// swift-tools-version: 5.7

import PackageDescription

let package = Package(
    name: "Features",
    platforms: [.iOS(.v16)],
    products: Module.allCases.map(library(named:)),
    dependencies: Dependency.allCases.map(\.packageDependency),
    targets: Module.allCases.map(\.target)
)

enum Module: String, CaseIterable {
    case Start

    case Onboarding
    case Main

    var target: Target {
        .target(
            name: name,
            dependencies: targetDependencies,
            swiftSettings: [.unsafeFlags(["-Xfrontend", "-warn-concurrency"])]
        )
    }

    private var targetDependencies: [Target.Dependency] {
        switch self {
        case .Start:
            let excludedModules = [
                Module.Start
            ]

            return Self.allCases
                .filter(Set(Self.allCases).symmetricDifference(excludedModules).contains)
                .map(\.targetDependency)
            + [
                Dependency.dependenciesAdditions.targetDependency,
            ]

        case .Onboarding:
            return [
                Dependency.tca.targetDependency,
            ]

        case .Main:
            return [
                Dependency.tca.targetDependency,
            ]
        }
    }

    var name: String {
        rawValue
    }

    var targetDependency: Target.Dependency {
        .init(stringLiteral: name)
    }
}

enum Dependency: String, CaseIterable {
    case tca
    case dependenciesAdditions

    var targetDependency: Target.Dependency {
        .product(
            name: {
                switch self {
                case .tca:
                    return "ComposableArchitecture"

                case .dependenciesAdditions:
                    return "DependenciesAdditions"
                }
            }(),
            package: repoName
        )
    }

    var packageDependency: Package.Dependency {
        switch self {
        case .tca:
            return .package(
                url: "https://github.com/pointfreeco/\(repoName).git",
                branch: "prerelease/1.0"
            )

        case .dependenciesAdditions:
            return .package(
                url: "https://github.com/tgrapperon/\(repoName).git",
                from: "0.5.1"
            )
        }
    }

    var repoName: String {
        switch self {
        case .tca:
            return "swift-composable-architecture"

        case .dependenciesAdditions:
            return "swift-dependencies-additions"
        }
    }
}

private func library(named name: Module) -> Product {
    .library(
        name: name.name,
        targets: [name.name]
    )
}
