import Testing
@testable import FormKit

@Suite("FormBuilder Tests")
struct FormBuilderTests {
    @Test("Builds a section with multiple fields")
    func buildSection() {
        let section = FormSection(title: "Test") {
            FormTextField(id: "name", label: "Name")
            FormTextField(id: "email", label: "Email")
            FormNumberField(id: "age", label: "Age")
        }
        #expect(section.title == "Test")
        #expect(section.fields.count == 3)
    }

    @Test("Section without title")
    func noTitle() {
        let section = FormSection {
            FormTextField(id: "name", label: "Name")
        }
        #expect(section.title == nil)
        #expect(section.fields.count == 1)
    }

    @Test("All field types work in builder")
    func allFieldTypes() {
        let section = FormSection {
            FormTextField(id: "text", label: "Text")
            FormNumberField(id: "number", label: "Number")
            FormToggleField(id: "toggle", label: "Toggle")
            FormPickerField(id: "picker", label: "Picker", options: ["A", "B"])
            FormDateField(id: "date", label: "Date")
        }
        #expect(section.fields.count == 5)
    }
}
