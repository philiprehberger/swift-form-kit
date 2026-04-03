import Foundation

/// Observable form state containing values, errors, and validation status
///
/// ```swift
/// let model = FormModel(sections: [section])
/// model.setValue("John", for: "name")
/// let valid = model.validate()
/// ```
public final class FormModel: @unchecked Sendable {
    private let sections: [FormSection]
    private var _values: [String: Any] = [:]
    private var _errors: [String: [String]] = [:]
    private let lock = NSLock()

    /// Current form values keyed by field ID
    public var values: [String: Any] {
        lock.lock()
        defer { lock.unlock() }
        return _values
    }

    /// Current validation errors keyed by field ID
    public var errors: [String: [String]] {
        lock.lock()
        defer { lock.unlock() }
        return _errors
    }

    /// Whether all fields pass validation
    public var isValid: Bool {
        lock.lock()
        defer { lock.unlock() }
        return _errors.values.allSatisfy { $0.isEmpty }
    }

    /// Create a form model with sections
    public init(sections: [FormSection]) {
        self.sections = sections
    }

    /// Set a value for a field
    public func setValue(_ value: Any, for fieldId: String) {
        lock.lock()
        _values[fieldId] = value
        lock.unlock()
    }

    /// Validate all fields
    @discardableResult
    public func validate() -> Bool {
        lock.lock()
        _errors.removeAll()
        let allFields = sections.flatMap { $0.fields }
        for field in allFields {
            let value = _values[field.id] ?? ""
            var fieldErrors: [String] = []
            for rule in field.validation {
                if !rule.validate(value) {
                    fieldErrors.append(rule.message)
                }
            }
            if !fieldErrors.isEmpty {
                _errors[field.id] = fieldErrors
            }
        }
        let valid = _errors.isEmpty
        lock.unlock()
        return valid
    }

    /// Validate a single field
    @discardableResult
    public func validate(fieldId: String) -> Bool {
        lock.lock()
        let allFields = sections.flatMap { $0.fields }
        guard let field = allFields.first(where: { $0.id == fieldId }) else {
            lock.unlock()
            return true
        }
        let value = _values[fieldId] ?? ""
        var fieldErrors: [String] = []
        for rule in field.validation {
            if !rule.validate(value) {
                fieldErrors.append(rule.message)
            }
        }
        if fieldErrors.isEmpty {
            _errors.removeValue(forKey: fieldId)
        } else {
            _errors[fieldId] = fieldErrors
        }
        let valid = fieldErrors.isEmpty
        lock.unlock()
        return valid
    }

    /// Reset form to initial state
    public func reset() {
        lock.lock()
        _values.removeAll()
        _errors.removeAll()
        lock.unlock()
    }
}
