# FormKit

[![Tests](https://github.com/philiprehberger/swift-form-kit/actions/workflows/ci.yml/badge.svg)](https://github.com/philiprehberger/swift-form-kit/actions/workflows/ci.yml)
[![](https://img.shields.io/endpoint?url=https%3A%2F%2Fswiftpackageindex.com%2Fapi%2Fpackages%2Fphiliprehberger%2Fswift-form-kit%2Fbadge%3Ftype%3Dswift-versions)](https://swiftpackageindex.com/philiprehberger/swift-form-kit)
[![](https://img.shields.io/endpoint?url=https%3A%2F%2Fswiftpackageindex.com%2Fapi%2Fpackages%2Fphiliprehberger%2Fswift-form-kit%2Fbadge%3Ftype%3Dplatforms)](https://swiftpackageindex.com/philiprehberger/swift-form-kit)

Declarative form builder with validation rules, result builder DSL, and dynamic JSON forms

## Requirements

- Swift >= 6.0
- macOS 13+ / iOS 16+ / tvOS 16+ / watchOS 9+

## Installation

Add to your `Package.swift`:

```swift
dependencies: [
    .package(url: "https://github.com/philiprehberger/swift-form-kit.git", from: "0.1.0")
]
```

Then add `"FormKit"` to your target dependencies:

```swift
.target(name: "YourTarget", dependencies: [
    .product(name: "FormKit", package: "swift-form-kit")
])
```

## Usage

```swift
import FormKit

// Build a form with the DSL
let section = FormSection(title: "Profile") {
    FormTextField(id: "name", label: "Full Name", validation: [.required()])
    FormTextField(id: "email", label: "Email", validation: [.required(), .email()])
    FormNumberField(id: "age", label: "Age", validation: [.range(18...120)])
    FormToggleField(id: "newsletter", label: "Subscribe to newsletter")
}

let model = FormModel(sections: [section])
```

### Validation

```swift
// Built-in rules
FormTextField(id: "password", label: "Password", validation: [
    .required(),
    .minLength(8),
    .maxLength(100),
    .pattern(".*[A-Z].*", message: "Must contain an uppercase letter")
])

// Custom rule
FormTextField(id: "username", label: "Username", validation: [
    .custom(message: "Must start with a letter") { value in
        guard let str = value as? String else { return false }
        return str.first?.isLetter ?? false
    }
])

// Validate all fields
let isValid = model.validate()
let errors = model.errors  // ["password": ["Must be at least 8 characters"]]
```

### Dynamic Forms from JSON

```swift
let json = """
[{"title": "Contact", "fields": [
    {"id": "name", "type": "text", "label": "Name", "required": true},
    {"id": "age", "type": "number", "label": "Age"}
]}]
""".data(using: .utf8)!

let sections = try DynamicForm.from(json: json)
let model = FormModel(sections: sections)
```

### SwiftUI Rendering

```swift
struct ProfileForm: View {
    @State private var model = FormModel(sections: profileSections)

    var body: some View {
        FormView(model: model)
        Button("Submit") { if model.validate() { submit() } }
            .disabled(!model.isValid)
    }
}
```

## API

### FormModel

| Property/Method | Description |
|-----------------|-------------|
| `values` | Current form values keyed by field ID |
| `errors` | Validation errors keyed by field ID |
| `isValid` | Whether all fields pass validation |
| `setValue(_:for:)` | Set a value for a field |
| `validate()` | Validate all fields |
| `validate(fieldId:)` | Validate a single field |
| `reset()` | Reset form to initial values |

### ValidationRule

| Static Method | Description |
|---------------|-------------|
| `.required()` | Field must not be empty |
| `.minLength(_:)` | Minimum string length |
| `.maxLength(_:)` | Maximum string length |
| `.pattern(_:message:)` | Regex pattern match |
| `.email()` | Valid email format |
| `.range(_:)` | Number within range |
| `.custom(message:_:)` | Custom validation closure |

### Field Types

| Type | Description |
|------|-------------|
| `FormTextField` | Text input field |
| `FormNumberField` | Numeric input field |
| `FormToggleField` | Boolean toggle |
| `FormPickerField` | Selection from options |
| `FormDateField` | Date picker |

## Development

```bash
swift build
swift test
```

## Support

[💬 Bluesky](https://bsky.app/profile/philiprehberger.bsky.social) · [🐦 X](https://x.com/philiprehberger) · [💼 LinkedIn](https://linkedin.com/in/philiprehberger) · [🌐 Website](https://philiprehberger.com) · [📦 GitHub](https://github.com/philiprehberger) · [☕ Buy Me a Coffee](https://buymeacoffee.com/philiprehberger) · [❤️ GitHub Sponsors](https://github.com/sponsors/philiprehberger)

## License

[MIT](LICENSE)
