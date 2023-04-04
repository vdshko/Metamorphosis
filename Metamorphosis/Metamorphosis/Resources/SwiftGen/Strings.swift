// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command file_length implicit_return

// MARK: - Strings

// swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:disable nesting type_body_length type_name vertical_whitespace_opening_braces
public enum L10n {

  public enum Common {
    /// Coming soon!
    public static let comingSoon = L10n.tr("Localizable", "common.comingSoon")
  }

  public enum Root {
    public enum Navigation {
      /// Units
      public static let title = L10n.tr("Localizable", "root.navigation.title")
    }
  }

  public enum Units {
    /// Angles
    public static let angles = L10n.tr("Localizable", "units.angles")
    /// Area
    public static let area = L10n.tr("Localizable", "units.area")
    /// Currency
    public static let currency = L10n.tr("Localizable", "units.currency")
    /// Data
    public static let data = L10n.tr("Localizable", "units.data")
    /// Length
    public static let length = L10n.tr("Localizable", "units.length")
    /// Power
    public static let power = L10n.tr("Localizable", "units.power")
    /// Pressure
    public static let pressure = L10n.tr("Localizable", "units.pressure")
    /// Speed
    public static let speed = L10n.tr("Localizable", "units.speed")
    /// Temperature
    public static let temperature = L10n.tr("Localizable", "units.temperature")
    /// Time
    public static let time = L10n.tr("Localizable", "units.time")
    /// Volume
    public static let volume = L10n.tr("Localizable", "units.volume")
    /// Weight
    public static let weight = L10n.tr("Localizable", "units.weight")
  }
}
// swiftlint:enable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:enable nesting type_body_length type_name vertical_whitespace_opening_braces

// MARK: - Implementation Details

extension L10n {
  private static func tr(_ table: String, _ key: String, _ args: CVarArg...) -> String {
    let format = BundleToken.bundle.localizedString(forKey: key, value: nil, table: table)
    return String(format: format, locale: Locale.current, arguments: args)
  }
}

// swiftlint:disable convenience_type
private final class BundleToken {
  static let bundle: Bundle = {
    #if SWIFT_PACKAGE
    return Bundle.module
    #else
    return Bundle(for: BundleToken.self)
    #endif
  }()
}
// swiftlint:enable convenience_type
