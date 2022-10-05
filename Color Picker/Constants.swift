import Cocoa
import Defaults
import KeyboardShortcuts

extension Defaults.Keys {
	static let recentlyPickedColors = Key<[NSColor]>("recentlyPickedColors", default: [])

	// Settings
	static let showInMenuBar = Key<Bool>("showInMenuBar", default: false)
	static let hideMenuBarIcon = Key<Bool>("hideMenuBarIcon", default: false)
	static let showColorSamplerOnOpen = Key<Bool>("showColorSamplerOnOpen", default: false)
	static let menuBarItemClickAction = Key<MenuBarItemClickAction>("menuBarItemClickAction", default: .showMenu)
	static let preferredColorFormat = Key<ColorFormat>("preferredColorFormat", default: .hex)
	static let stayOnTop = Key<Bool>("stayOnTop", default: true)
	static let uppercaseHexColor = Key<Bool>("uppercaseHexColor", default: false)
	static let hashPrefixInHexColor = Key<Bool>("hashPrefixInHexColor", default: false)
	static let legacyColorSyntax = Key<Bool>("legacyColorSyntax", default: false)
    static let shownColorFormats = Key<Set<ColorFormat>>("shownColorFormats", default: [.hex, .hsl, .rgb, .lch, .nsSRGB, .uiSRGB])
	static let largerText = Key<Bool>("largerText", default: false)
	static let copyColorAfterPicking = Key<Bool>("copyColorAfterPicking", default: false)

	// Deprecated
	static let colorFormatToCopyAfterPicking = Key<CopyColorFormat>("colorFormatToCopyAfterPicking", default: .none)
}

extension KeyboardShortcuts.Name {
	static let pickColor = Self("pickColor")
	static let toggleWindow = Self("toggleWindow")
}

// TODO: Remove in 2023.
enum CopyColorFormat: String, CaseIterable, Defaults.Serializable {
	case none // swiftlint:disable:this discouraged_none_name
	case hex
	case hsl
	case rgb
	case lch

	var title: String {
		switch self {
		case .none:
			return "None"
		case .hex:
			return "Hex"
		case .hsl:
			return "HSL"
		case .rgb:
			return "RGB"
		case .lch:
			return "LCH"
		}
	}
}

// TODO: Remove in 2023.
enum CodableCopyColorFormat: String {
	case none // swiftlint:disable:this discouraged_none_name
	case hex
	case hsl
	case rgb
	case lch
}

extension CodableCopyColorFormat: Defaults.CodableType {
	typealias NativeForm = CopyColorFormat
}

extension CopyColorFormat: Defaults.NativeType {
	typealias CodableForm = CodableCopyColorFormat
}

enum ColorFormat: String, CaseIterable, Defaults.Serializable {
	case hex
	case hsl
	case rgb
	case lch
    case nsSRGB
    case uiSRGB

	var title: String {
		switch self {
		case .hex:
			return "Hex"
		case .hsl:
			return "HSL"
		case .rgb:
			return "RGB"
		case .lch:
			return "LCH"
        case .nsSRGB:
            return "NSColor sRGB"
        case .uiSRGB:
            return "UIColor sRGB"
		}
	}
}

extension ColorFormat: Identifiable {
	var id: Self { self }
}

// TODO: Remove in 2023.
enum CodableColorFormat: String {
	case hex
	case hsl
	case rgb
	case lch
    case nsc
}

extension CodableColorFormat: Defaults.CodableType {
	typealias NativeForm = ColorFormat
}

extension ColorFormat: Defaults.NativeType {
	typealias CodableForm = CodableColorFormat
}

enum MenuBarItemClickAction: String, CaseIterable, Defaults.Serializable {
	case showMenu
	case showColorSampler
	case toggleWindow

	var title: String {
		switch self {
		case .showMenu:
			return "Show menu"
		case .showColorSampler:
			return "Show color sampler"
		case .toggleWindow:
			return "Toggle window"
		}
	}

	var tip: String {
		switch self {
		case .showMenu:
			return "Right-click to show the color sampler"
		case .showColorSampler, .toggleWindow:
			return "Right-click to show the menu"
		}
	}
}


// Workaround for Swift bug.

extension Defaults.Serializable where Self: Codable {
	public static var bridge: Defaults.TopLevelCodableBridge<Self> { Defaults.TopLevelCodableBridge() }
}

extension Defaults.Serializable where Self: Codable & NSSecureCoding {
	public static var bridge: Defaults.CodableNSSecureCodingBridge<Self> { Defaults.CodableNSSecureCodingBridge() }
}

extension Defaults.Serializable where Self: Codable & NSSecureCoding & Defaults.PreferNSSecureCoding {
	public static var bridge: Defaults.NSSecureCodingBridge<Self> { Defaults.NSSecureCodingBridge() }
}

extension Defaults.Serializable where Self: Codable & RawRepresentable {
	public static var bridge: Defaults.RawRepresentableCodableBridge<Self> { Defaults.RawRepresentableCodableBridge() }
}

extension Defaults.Serializable where Self: Codable & RawRepresentable & Defaults.PreferRawRepresentable {
	public static var bridge: Defaults.RawRepresentableBridge<Self> { Defaults.RawRepresentableBridge() }
}

extension Defaults.Serializable where Self: RawRepresentable {
	public static var bridge: Defaults.RawRepresentableBridge<Self> { Defaults.RawRepresentableBridge() }
}
extension Defaults.Serializable where Self: NSSecureCoding {
	public static var bridge: Defaults.NSSecureCodingBridge<Self> { Defaults.NSSecureCodingBridge() }
}

extension Defaults.CollectionSerializable where Element: Defaults.Serializable {
	public static var bridge: Defaults.CollectionBridge<Self> { Defaults.CollectionBridge() }
}

extension Defaults.SetAlgebraSerializable where Element: Defaults.Serializable & Hashable {
	public static var bridge: Defaults.SetAlgebraBridge<Self> { Defaults.SetAlgebraBridge() }
}
