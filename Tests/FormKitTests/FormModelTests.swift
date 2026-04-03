import Testing
@testable import FormKit

@Suite("FormModel Tests")
struct FormModelTests {
    @Test("Set and get values")
    func setAndGetValues() {
        let section = FormSection {
            FormTextField(id: "name", label: "Name")
        }
        let model = FormModel(sections: [section])
        model.setValue("John", for: "name")
        #expect(model.values["name"] as? String == "John")
    }

    @Test("Validate returns false for invalid fields")
    func validateInvalid() {
        let section = FormSection {
            FormTextField(id: "name", label: "Name", validation: [.required()])
        }
        let model = FormModel(sections: [section])
        let result = model.validate()
        #expect(result == false)
        #expect(model.errors["name"]?.isEmpty == false)
    }

    @Test("Validate returns true for valid fields")
    func validateValid() {
        let section = FormSection {
            FormTextField(id: "name", label: "Name", validation: [.required()])
        }
        let model = FormModel(sections: [section])
        model.setValue("John", for: "name")
        let result = model.validate()
        #expect(result == true)
        #expect(model.errors.isEmpty)
    }

    @Test("Validate single field")
    func validateSingleField() {
        let section = FormSection {
            FormTextField(id: "name", label: "Name", validation: [.required()])
            FormTextField(id: "email", label: "Email", validation: [.required()])
        }
        let model = FormModel(sections: [section])
        model.setValue("John", for: "name")
        let nameValid = model.validate(fieldId: "name")
        let emailValid = model.validate(fieldId: "email")
        #expect(nameValid == true)
        #expect(emailValid == false)
    }

    @Test("Reset clears values and errors")
    func reset() {
        let section = FormSection {
            FormTextField(id: "name", label: "Name", validation: [.required()])
        }
        let model = FormModel(sections: [section])
        model.setValue("John", for: "name")
        model.validate()
        model.reset()
        #expect(model.values.isEmpty)
        #expect(model.errors.isEmpty)
    }

    @Test("isValid reflects validation state")
    func isValid() {
        let section = FormSection {
            FormTextField(id: "name", label: "Name", validation: [.required()])
        }
        let model = FormModel(sections: [section])
        #expect(model.isValid == true)  // no validation run yet
        model.validate()
        #expect(model.isValid == false)
        model.setValue("John", for: "name")
        model.validate()
        #expect(model.isValid == true)
    }
}
