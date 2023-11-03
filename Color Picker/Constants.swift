import Cocoa
import KeyboardShortcuts

enum Constants {
    static let swatchImageSize = 20.0
}

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
    static let showAccessibilityColorName = Key<Bool>("showAccessibilityColorName", default: false)
    static let stickyPaletteName = Key<String?>("stickyPaletteName")
}

extension KeyboardShortcuts.Name {
    static let pickColor = Self("pickColor")
    static let toggleWindow = Self("toggleWindow")
}

enum ColorFormat: String, CaseIterable, Defaults.Serializable {
    case hex
    case hsl
    case rgb
    case lch
    case nsSRGB
    case uiSRGB
    case swiftuiSRGB
    
    var title: String {
        switch self {
        case .hex:
            "Hex"
        case .hsl:
            "HSL"
        case .rgb:
            "RGB"
        case .lch:
            "LCH"
        case .nsSRGB:
            "NSColor sRGB"
        case .uiSRGB:
            "UIColor sRGB"
        case .swiftuiSRGB:
            "Color sRGB"
        }
    }
}

extension ColorFormat: Identifiable {
    var id: Self { self }
}

enum MenuBarItemClickAction: String, CaseIterable, Defaults.Serializable {
    case showMenu
    case showColorSampler
    case toggleWindow
    
    var title: String {
        switch self {
        case .showMenu:
            "Show menu"
        case .showColorSampler:
            "Show color sampler"
        case .toggleWindow:
            "Toggle window"
        }
    }
    
    var tip: String {
        switch self {
        case .showMenu:
            "Right-click to show the color sampler"
        case .showColorSampler, .toggleWindow:
            "Right-click to show the menu"
        }
    }
}

extension [NSColorList] {
    func withoutStickyPalette() -> Self {
        filter {
            // Don't show sticky palette.
            if
                let colorListName = Defaults[.stickyPaletteName],
                $0 == NSColorList(named: colorListName)
            {
                return false
            }
            
            return true
        }
    }
}
