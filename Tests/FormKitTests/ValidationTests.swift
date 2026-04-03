import Testing
@testable import FormKit

@Suite("ValidationRule Tests")
struct ValidationTests {
    @Test("Required fails for empty string")
    func requiredEmpty() {
        let rule = ValidationRule.required()
        #expect(rule.validate("") == false)
        #expect(rule.validate("  ") == false)
    }

    @Test("Required passes for non-empty string")
    func requiredNonEmpty() {
        let rule = ValidationRule.required()
        #expect(rule.validate("hello") == true)
    }

    @Test("MinLength validates correctly")
    func minLength() {
        let rule = ValidationRule.minLength(3)
        #expect(rule.validate("ab") == false)
        #expect(rule.validate("abc") == true)
        #expect(rule.validate("abcd") == true)
    }

    @Test("MaxLength validates correctly")
    func maxLength() {
        let rule = ValidationRule.maxLength(5)
        #expect(rule.validate("hello") == true)
        #expect(rule.validate("hello!") == false)
    }

    @Test("Email validates correctly")
    func email() {
        let rule = ValidationRule.email()
        #expect(rule.validate("user@example.com") == true)
        #expect(rule.validate("invalid") == false)
        #expect(rule.validate("@example.com") == false)
    }

    @Test("Pattern validates correctly")
    func pattern() {
        let rule = ValidationRule.pattern("^[A-Z]", message: "Must start with uppercase")
        #expect(rule.validate("Hello") == true)
        #expect(rule.validate("hello") == false)
    }

    @Test("Range validates correctly")
    func range() {
        let rule = ValidationRule.range(18...65)
        #expect(rule.validate(25 as Int) == true)
        #expect(rule.validate(17 as Int) == false)
        #expect(rule.validate(66 as Int) == false)
    }

    @Test("Custom rule works")
    func customRule() {
        let rule = ValidationRule.custom(message: "Must be 'yes'") { value in
            (value as? String) == "yes"
        }
        #expect(rule.validate("yes") == true)
        #expect(rule.validate("no") == false)
    }
}
