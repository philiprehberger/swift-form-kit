import Foundation

/// Build forms dynamically from JSON data
///
/// Expected JSON format:
/// ```json
/// [{"title": "Section", "fields": [
///     {"id": "name", "type": "text", "label": "Name", "required": true},
///     {"id": "age", "type": "number", "label": "Age"}
/// ]}]
/// ```
public enum DynamicForm {
    /// Parse JSON data into form sections
    public static func from(json: Data) throws -> [FormSection] {
        let decoded = try JSONSerialization.jsonObject(with: json) as? [[String: Any]] ?? []
        return try from(dictionary: decoded)
    }

    /// Parse a dictionary array into form sections
    public static func from(dictionary: [[String: Any]]) throws -> [FormSection] {
        dictionary.compactMap { sectionDict in
            let title = sectionDict["title"] as? String
            guard let fieldsArray = sectionDict["fields"] as? [[String: Any]] else {
                return nil
            }
            let fields: [any FormField] = fieldsArray.compactMap { fieldDict in
                guard let id = fieldDict["id"] as? String,
                      let type = fieldDict["type"] as? String,
                      let label = fieldDict["label"] as? String else {
                    return nil
                }
                let isRequired = fieldDict["required"] as? Bool ?? false
                var validation: [ValidationRule] = []
                if isRequired { validation.append(.required()) }

                switch type {
                case "text":
                    let placeholder = fieldDict["placeholder"] as? String ?? ""
                    return FormTextField(id: id, label: label, placeholder: placeholder, validation: validation)
                case "number":
                    return FormNumberField(id: id, label: label, validation: validation)
                case "toggle":
                    return FormToggleField(id: id, label: label, validation: validation)
                case "picker":
                    let options = fieldDict["options"] as? [String] ?? []
                    return FormPickerField(id: id, label: label, options: options, validation: validation)
                case "date":
                    return FormDateField(id: id, label: label, validation: validation)
                default:
                    return FormTextField(id: id, label: label, validation: validation)
                }
            }
            return FormSection(title: title, fields: fields)
        }
    }
}
