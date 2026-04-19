import SwiftUI

struct MagnitudeBadge: View {
    let magnitude: Double

    private var color: Color {
        switch magnitude {
        case ..<3: return .green
        case 3..<5: return .yellow
        case 5..<6: return .orange
        default: return .red
        }
    }

    private var size: CGFloat {
        24 + CGFloat(max(0, magnitude - 2)) * 4
    }

    var body: some View {
        Text(String(format: "%.1f", magnitude))
            .font(.caption2.bold())
            .foregroundStyle(.white)
            .frame(width: size, height: size)
            .background(color, in: Circle())
            .shadow(radius: 2)
    }
}
