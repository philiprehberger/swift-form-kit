import Foundation

/// A section of form fields with an optional title
public struct FormSection: Sendable {
    /// Optional section title
    public let title: String?

    /// The fields in this section
    public let fields: [any FormField]

    /// Create a section with a title and fields using the result builder
    public init(title: String? = nil, @FormBuilder fields: () -> [any FormField]) {
        self.title = title
        self.fields = fields()
    }

    /// Create a section with a title and an array of fields
    public init(title: String? = nil, fields: [any FormField]) {
        self.title = title
        self.fields = fields
    }
}
