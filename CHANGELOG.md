# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

## [0.1.0] - 2026-04-02

### Added
- `FormBuilder` result builder DSL for declarative form construction
- `FormField` protocol with built-in field types (text, number, toggle, picker, date)
- `FormSection` for grouping fields with optional titles
- `FormModel` observable state container with values, errors, and validation
- `ValidationRule` with built-in rules (required, minLength, maxLength, pattern, email, range)
- Custom validation via closure-based rules
- `DynamicForm` for constructing forms from JSON data
- `FormView` SwiftUI view for rendering forms
- Built-in field views with accessibility labels
- Zero external dependencies
