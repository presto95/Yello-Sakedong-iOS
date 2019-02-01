// swiftlint:disable all
// Generated using SwiftGen, by O.Halligon — https://github.com/SwiftGen/SwiftGen

#if os(OSX)
  import AppKit.NSImage
  internal typealias AssetColorTypeAlias = NSColor
  internal typealias AssetImageTypeAlias = NSImage
#elseif os(iOS) || os(tvOS) || os(watchOS)
  import UIKit.UIImage
  internal typealias AssetColorTypeAlias = UIColor
  internal typealias AssetImageTypeAlias = UIImage
#endif

// swiftlint:disable superfluous_disable_command
// swiftlint:disable file_length

// MARK: - Asset Catalogs

// swiftlint:disable identifier_name line_length nesting type_body_length type_name
internal enum Asset {
  internal static let addTaste = ImageAsset(name: "add_taste")
  internal static let black = ColorAsset(name: "black")
  internal static let blue = ColorAsset(name: "blue")
  internal static let green = ColorAsset(name: "green")
  internal static let orange = ColorAsset(name: "orange")
  internal static let pink = ColorAsset(name: "pink")
  internal static let purple = ColorAsset(name: "purple")
  internal static let red = ColorAsset(name: "red")
  internal static let yellow = ColorAsset(name: "yellow")
  internal static let emoL1 = ImageAsset(name: "emoL1")
  internal static let emoL10 = ImageAsset(name: "emoL10")
  internal static let emoL2 = ImageAsset(name: "emoL2")
  internal static let emoL3 = ImageAsset(name: "emoL3")
  internal static let emoL4 = ImageAsset(name: "emoL4")
  internal static let emoL5 = ImageAsset(name: "emoL5")
  internal static let emoL6 = ImageAsset(name: "emoL6")
  internal static let emoL7 = ImageAsset(name: "emoL7")
  internal static let emoL8 = ImageAsset(name: "emoL8")
  internal static let emoL9 = ImageAsset(name: "emoL9")
  internal static let emoM1 = ImageAsset(name: "emoM1")
  internal static let emoM10 = ImageAsset(name: "emoM10")
  internal static let emoM2 = ImageAsset(name: "emoM2")
  internal static let emoM3 = ImageAsset(name: "emoM3")
  internal static let emoM4 = ImageAsset(name: "emoM4")
  internal static let emoM5 = ImageAsset(name: "emoM5")
  internal static let emoM6 = ImageAsset(name: "emoM6")
  internal static let emoM7 = ImageAsset(name: "emoM7")
  internal static let emoM8 = ImageAsset(name: "emoM8")
  internal static let emoM9 = ImageAsset(name: "emoM9")
  internal static let emoS1 = ImageAsset(name: "emoS1")
  internal static let emoS10 = ImageAsset(name: "emoS10")
  internal static let emoS2 = ImageAsset(name: "emoS2")
  internal static let emoS3 = ImageAsset(name: "emoS3")
  internal static let emoS4 = ImageAsset(name: "emoS4")
  internal static let emoS5 = ImageAsset(name: "emoS5")
  internal static let emoS6 = ImageAsset(name: "emoS6")
  internal static let emoS7 = ImageAsset(name: "emoS7")
  internal static let emoS8 = ImageAsset(name: "emoS8")
  internal static let emoS9 = ImageAsset(name: "emoS9")
  internal static let emoSGrey1 = ImageAsset(name: "emoSGrey1")
  internal static let emoSGrey10 = ImageAsset(name: "emoSGrey10")
  internal static let emoSGrey2 = ImageAsset(name: "emoSGrey2")
  internal static let emoSGrey3 = ImageAsset(name: "emoSGrey3")
  internal static let emoSGrey4 = ImageAsset(name: "emoSGrey4")
  internal static let emoSGrey5 = ImageAsset(name: "emoSGrey5")
  internal static let emoSGrey6 = ImageAsset(name: "emoSGrey6")
  internal static let emoSGrey7 = ImageAsset(name: "emoSGrey7")
  internal static let emoSGrey8 = ImageAsset(name: "emoSGrey8")
  internal static let emoSGrey9 = ImageAsset(name: "emoSGrey9")
  internal static let icBack = ImageAsset(name: "ic_back")
  internal static let icLike = ImageAsset(name: "ic_like")
  internal static let icX = ImageAsset(name: "ic_x")
  internal static let page404 = ImageAsset(name: "page404")
}
// swiftlint:enable identifier_name line_length nesting type_body_length type_name

// MARK: - Implementation Details

internal struct ColorAsset {
  internal fileprivate(set) var name: String

  @available(iOS 11.0, tvOS 11.0, watchOS 4.0, OSX 10.13, *)
  internal var color: AssetColorTypeAlias {
    return AssetColorTypeAlias(asset: self)
  }
}

internal extension AssetColorTypeAlias {
  @available(iOS 11.0, tvOS 11.0, watchOS 4.0, OSX 10.13, *)
  convenience init!(asset: ColorAsset) {
    let bundle = Bundle(for: BundleToken.self)
    #if os(iOS) || os(tvOS)
    self.init(named: asset.name, in: bundle, compatibleWith: nil)
    #elseif os(OSX)
    self.init(named: NSColor.Name(asset.name), bundle: bundle)
    #elseif os(watchOS)
    self.init(named: asset.name)
    #endif
  }
}

internal struct DataAsset {
  internal fileprivate(set) var name: String

  #if os(iOS) || os(tvOS) || os(OSX)
  @available(iOS 9.0, tvOS 9.0, OSX 10.11, *)
  internal var data: NSDataAsset {
    return NSDataAsset(asset: self)
  }
  #endif
}

#if os(iOS) || os(tvOS) || os(OSX)
@available(iOS 9.0, tvOS 9.0, OSX 10.11, *)
internal extension NSDataAsset {
  convenience init!(asset: DataAsset) {
    let bundle = Bundle(for: BundleToken.self)
    #if os(iOS) || os(tvOS)
    self.init(name: asset.name, bundle: bundle)
    #elseif os(OSX)
    self.init(name: NSDataAsset.Name(asset.name), bundle: bundle)
    #endif
  }
}
#endif

internal struct ImageAsset {
  internal fileprivate(set) var name: String

  internal var image: AssetImageTypeAlias {
    let bundle = Bundle(for: BundleToken.self)
    #if os(iOS) || os(tvOS)
    let image = AssetImageTypeAlias(named: name, in: bundle, compatibleWith: nil)
    #elseif os(OSX)
    let image = bundle.image(forResource: NSImage.Name(name))
    #elseif os(watchOS)
    let image = AssetImageTypeAlias(named: name)
    #endif
    guard let result = image else { fatalError("Unable to load image named \(name).") }
    return result
  }
}

internal extension AssetImageTypeAlias {
  @available(iOS 1.0, tvOS 1.0, watchOS 1.0, *)
  @available(OSX, deprecated,
    message: "This initializer is unsafe on macOS, please use the ImageAsset.image property")
  convenience init!(asset: ImageAsset) {
    #if os(iOS) || os(tvOS)
    let bundle = Bundle(for: BundleToken.self)
    self.init(named: asset.name, in: bundle, compatibleWith: nil)
    #elseif os(OSX)
    self.init(named: NSImage.Name(asset.name))
    #elseif os(watchOS)
    self.init(named: asset.name)
    #endif
  }
}

private final class BundleToken {}
