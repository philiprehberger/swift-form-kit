import Foundation

/// A validation rule for form fields
public struct ValidationRule: Sendable {
    /// The error message when validation fails
    public let message: String

    /// The validation function
    public let validate: @Sendable (Any) -> Bool

    /// Create a custom validation rule
    public static func custom(message: String, _ validate: @escaping @Sendable (Any) -> Bool) -> ValidationRule {
        ValidationRule(message: message, validate: validate)
    }

    /// Field must not be empty
    public static func required(message: String = "This field is required") -> ValidationRule {
        ValidationRule(message: message) { value in
            if let string = value as? String {
                return !string.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
            }
            return true
        }
    }

    /// String must be at least `length` characters
    public static func minLength(_ length: Int, message: String? = nil) -> ValidationRule {
        ValidationRule(message: message ?? "Must be at least \(length) characters") { value in
            guard let string = value as? String else { return true }
            return string.count >= length
        }
    }

    /// String must be at most `length` characters
    public static func maxLength(_ length: Int, message: String? = nil) -> ValidationRule {
        ValidationRule(message: message ?? "Must be at most \(length) characters") { value in
            guard let string = value as? String else { return true }
            return string.count <= length
        }
    }

    /// String must match the regex pattern
    public static func pattern(_ regex: String, message: String) -> ValidationRule {
        ValidationRule(message: message) { value in
            guard let string = value as? String else { return true }
            return string.range(of: regex, options: .regularExpression) != nil
        }
    }

    /// Must be a valid email address
    public static func email(message: String = "Invalid email address") -> ValidationRule {
        pattern("[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}", message: message)
    }

    /// Number must be within the given range
    public static func range(_ range: ClosedRange<Double>, message: String? = nil) -> ValidationRule {
        ValidationRule(message: message ?? "Must be between \(range.lowerBound) and \(range.upperBound)") { value in
            if let number = value as? Double {
                return range.contains(number)
            }
            if let number = value as? Int {
                return range.contains(Double(number))
            }
            return true
        }
    }
}
