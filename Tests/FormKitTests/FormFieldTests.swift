import Testing
@testable import FormKit

@Suite("FormField Tests")
struct FormFieldTests {
    @Test("TextField stores properties")
    func textFieldProperties() {
        let field = FormTextField(id: "name", label: "Full Name", placeholder: "Enter name")
        #expect(field.id == "name")
        #expect(field.label == "Full Name")
        #expect(field.placeholder == "Enter name")
        #expect(field.accessibilityLabel == "Full Name")
    }

    @Test("Custom accessibility label")
    func customAccessibility() {
        let field = FormTextField(id: "name", label: "Name", accessibilityLabel: "Your full name")
        #expect(field.accessibilityLabel == "Your full name")
    }

    @Test("PickerField stores options")
    func pickerOptions() {
        let field = FormPickerField(id: "color", label: "Color", options: ["Red", "Blue", "Green"])
        #expect(field.options.count == 3)
        #expect(field.options[0] == "Red")
    }

    @Test("Fields with no validation have empty array")
    func noValidation() {
        let field = FormTextField(id: "name", label: "Name")
        #expect(field.validation.isEmpty)
    }
}
