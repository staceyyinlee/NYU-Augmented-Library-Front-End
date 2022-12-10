import Foundation
import SwiftUI

struct Features: ViewModifier {
    func body(content: Content) -> some View {
        content
            .frame(width: 100, height: 100, alignment: .center)
            .background(Color.white)
            .cornerRadius(18)
            .shadow(color: Color.black.opacity(0.15), radius: 8, x: 2, y: 6)
    }
}


extension View {
    func FeaturesButton() -> some View {
        modifier(Features())
    }
}
