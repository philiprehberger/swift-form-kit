import Foundation

/// A field that can appear in a form
public protocol FormField: Sendable, Identifiable {
    /// Unique identifier for this field
    var id: String { get }

    /// Display label
    var label: String { get }

    /// Accessibility label (defaults to label)
    var accessibilityLabel: String { get }

    /// Validation rules for this field
    var validation: [ValidationRule] { get }
}

extension FormField {
    public var accessibilityLabel: String { label }
}

/// A text input field
public struct FormTextField: FormField {
    public let id: String
    public let label: String
    public let placeholder: String
    public let validation: [ValidationRule]
    public let accessibilityLabel: String

    /// Create a text field
    public init(
        id: String,
        label: String,
        placeholder: String = "",
        validation: [ValidationRule] = [],
        accessibilityLabel: String? = nil
    ) {
        self.id = id
        self.label = label
        self.placeholder = placeholder
        self.validation = validation
        self.accessibilityLabel = accessibilityLabel ?? label
    }
}

/// A numeric input field
public struct FormNumberField: FormField {
    public let id: String
    public let label: String
    public let validation: [ValidationRule]
    public let accessibilityLabel: String

    /// Create a number field
    public init(
        id: String,
        label: String,
        validation: [ValidationRule] = [],
        accessibilityLabel: String? = nil
    ) {
        self.id = id
        self.label = label
        self.validation = validation
        self.accessibilityLabel = accessibilityLabel ?? label
    }
}

/// A boolean toggle field
public struct FormToggleField: FormField {
    public let id: String
    public let label: String
    public let validation: [ValidationRule]
    public let accessibilityLabel: String

    /// Create a toggle field
    public init(
        id: String,
        label: String,
        validation: [ValidationRule] = [],
        accessibilityLabel: String? = nil
    ) {
        self.id = id
        self.label = label
        self.validation = validation
        self.accessibilityLabel = accessibilityLabel ?? label
    }
}

/// A picker/selection field
public struct FormPickerField: FormField {
    public let id: String
    public let label: String
    public let options: [String]
    public let validation: [ValidationRule]
    public let accessibilityLabel: String

    /// Create a picker field
    public init(
        id: String,
        label: String,
        options: [String],
        validation: [ValidationRule] = [],
        accessibilityLabel: String? = nil
    ) {
        self.id = id
        self.label = label
        self.options = options
        self.validation = validation
        self.accessibilityLabel = accessibilityLabel ?? label
    }
}

/// A date picker field
public struct FormDateField: FormField {
    public let id: String
    public let label: String
    public let validation: [ValidationRule]
    public let accessibilityLabel: String

    /// Create a date field
    public init(
        id: String,
        label: String,
        validation: [ValidationRule] = [],
        accessibilityLabel: String? = nil
    ) {
        self.id = id
        self.label = label
        self.validation = validation
        self.accessibilityLabel = accessibilityLabel ?? label
    }
}
