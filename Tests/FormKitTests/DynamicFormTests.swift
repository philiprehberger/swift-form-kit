import Testing
import Foundation
@testable import FormKit

@Suite("DynamicForm Tests")
struct DynamicFormTests {
    @Test("Parses JSON into sections")
    func parseJSON() throws {
        let json = """
        [{"title": "Contact", "fields": [
            {"id": "name", "type": "text", "label": "Full Name", "required": true},
            {"id": "age", "type": "number", "label": "Age"}
        ]}]
        """.data(using: .utf8)!

        let sections = try DynamicForm.from(json: json)
        #expect(sections.count == 1)
        #expect(sections[0].title == "Contact")
        #expect(sections[0].fields.count == 2)
        #expect(sections[0].fields[0].id == "name")
        #expect(sections[0].fields[1].id == "age")
    }

    @Test("Parses all field types")
    func allFieldTypes() throws {
        let json = """
        [{"fields": [
            {"id": "a", "type": "text", "label": "Text"},
            {"id": "b", "type": "number", "label": "Number"},
            {"id": "c", "type": "toggle", "label": "Toggle"},
            {"id": "d", "type": "picker", "label": "Picker", "options": ["X", "Y"]},
            {"id": "e", "type": "date", "label": "Date"}
        ]}]
        """.data(using: .utf8)!

        let sections = try DynamicForm.from(json: json)
        #expect(sections[0].fields.count == 5)
    }

    @Test("Required flag adds validation rule")
    func requiredFlag() throws {
        let json = """
        [{"fields": [{"id": "name", "type": "text", "label": "Name", "required": true}]}]
        """.data(using: .utf8)!

        let sections = try DynamicForm.from(json: json)
        let field = sections[0].fields[0]
        #expect(field.validation.count == 1)
    }

    @Test("Empty JSON returns empty sections")
    func emptyJSON() throws {
        let json = "[]".data(using: .utf8)!
        let sections = try DynamicForm.from(json: json)
        #expect(sections.isEmpty)
    }
}
