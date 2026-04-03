import Foundation

/// A result builder for declaratively constructing form fields
///
/// ```swift
/// FormSection(title: "Profile") {
///     FormTextField(id: "name", label: "Name")
///     FormTextField(id: "email", label: "Email")
/// }
/// ```
@resultBuilder
public struct FormBuilder {
    public static func buildBlock(_ components: any FormField...) -> [any FormField] {
        components
    }

    public static func buildOptional(_ component: [any FormField]?) -> [any FormField] {
        component ?? []
    }

    public static func buildEither(first component: [any FormField]) -> [any FormField] {
        component
    }

    public static func buildEither(second component: [any FormField]) -> [any FormField] {
        component
    }

    public static func buildArray(_ components: [[any FormField]]) -> [any FormField] {
        components.flatMap { $0 }
    }
}
