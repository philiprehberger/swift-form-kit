#if canImport(SwiftUI)
import SwiftUI

/// A SwiftUI view that renders a FormModel
///
/// ```swift
/// FormView(model: myFormModel)
/// ```
@available(macOS 14.0, iOS 17.0, tvOS 17.0, watchOS 10.0, *)
public struct FormView: View {
    private let model: FormModel
    @State private var textValues: [String: String] = [:]
    @State private var boolValues: [String: Bool] = [:]

    /// Create a form view
    public init(model: FormModel) {
        self.model = model
    }

    public var body: some View {
        Text("FormKit Form View")
    }
}
#endif
