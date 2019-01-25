// swiftlint:disable all
// Generated using SwiftGen, by O.Halligon — https://github.com/SwiftGen/SwiftGen

// swiftlint:disable sorted_imports
import Foundation
import UIKit

// swiftlint:disable superfluous_disable_command
// swiftlint:disable file_length

// MARK: - Storyboard Scenes

// swiftlint:disable explicit_type_interface identifier_name line_length type_body_length type_name
internal enum StoryboardScene {
  internal enum LaunchScreen: StoryboardType {
    internal static let storyboardName = "LaunchScreen"

    internal static let initialScene = InitialSceneType<UIKit.UIViewController>(storyboard: LaunchScreen.self)
  }
  internal enum Main: StoryboardType {
    internal static let storyboardName = "Main"

    internal static let initialScene = InitialSceneType<UIKit.UINavigationController>(storyboard: Main.self)

    internal static let mainSearchViewController = SceneType<MainViewController>(storyboard: Main.self, identifier: "MainSearchViewController")
  }
  internal enum Popup: StoryboardType {
    internal static let storyboardName = "Popup"

    internal static let initialScene = InitialSceneType<PopupViewController>(storyboard: Popup.self)

    internal static let popupViewController = SceneType<PopupViewController>(storyboard: Popup.self, identifier: "PopupViewController")
  }
  internal enum Result: StoryboardType {
    internal static let storyboardName = "Result"

    internal static let initialScene = InitialSceneType<ResultViewController>(storyboard: Result.self)

    internal static let resultViewController = SceneType<ResultViewController>(storyboard: Result.self, identifier: "ResultViewController")
  }
  internal enum Search: StoryboardType {
    internal static let storyboardName = "Search"

    internal static let initialScene = InitialSceneType<SearchViewController>(storyboard: Search.self)

    internal static let searchViewController = SceneType<SearchViewController>(storyboard: Search.self, identifier: "SearchViewController")
  }
  internal enum Splash: StoryboardType {
    internal static let storyboardName = "Splash"

    internal static let initialScene = InitialSceneType<SplashViewController>(storyboard: Splash.self)

    internal static let splashViewController = SceneType<SplashViewController>(storyboard: Splash.self, identifier: "SplashViewController")
  }
}
// swiftlint:enable explicit_type_interface identifier_name line_length type_body_length type_name

// MARK: - Implementation Details

internal protocol StoryboardType {
  static var storyboardName: String { get }
}

internal extension StoryboardType {
  static var storyboard: UIStoryboard {
    let name = self.storyboardName
    return UIStoryboard(name: name, bundle: Bundle(for: BundleToken.self))
  }
}

internal struct SceneType<T: UIViewController> {
  internal let storyboard: StoryboardType.Type
  internal let identifier: String

  internal func instantiate() -> T {
    let identifier = self.identifier
    guard let controller = storyboard.storyboard.instantiateViewController(withIdentifier: identifier) as? T else {
      fatalError("ViewController '\(identifier)' is not of the expected class \(T.self).")
    }
    return controller
  }
}

internal struct InitialSceneType<T: UIViewController> {
  internal let storyboard: StoryboardType.Type

  internal func instantiate() -> T {
    guard let controller = storyboard.storyboard.instantiateInitialViewController() as? T else {
      fatalError("ViewController is not of the expected class \(T.self).")
    }
    return controller
  }
}

private final class BundleToken {}
