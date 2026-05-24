//
//  DSColors.swift
//  BankingDesignSystem
//
//  Created by TavinFam on 20/05/2026.
//
import SwiftUI

public enum DSColors {
    
    // MARK: - Backgrounds
    public static let background = Color(hex: "#F3F6FA")
    public static let cardBackground = Color(hex: "#FFFFFF")

    // MARK: - Brand (from Figma)
    public static let primary = Color(hex: "#3D70FF")
    public static let primaryLight = Color(hex: "#EBF0FF")

    // MARK: - Text
    public static let textPrimary = Color(hex: "#1C1C1E")
    public static let textSecondary = Color(hex: "#8E8E93")
    public static let textOnPrimary = Color(hex: "#FFFFFF")

    // MARK: - Status
    public static let income = Color(hex: "#34C759")
    public static let expense = Color(hex: "#FF3B30")
    public static let incomeBg = Color(hex: "#E8F8ED")
    public static let expenseBg = Color(hex: "#FFF0EF")

    // MARK: - Divider
    public static let divider = Color(hex: "#E5E5EA")  
}

// MARK: - Hex Initializer
public extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)

        let a, r, g, b: UInt64
        switch hex.count {
        case 3:
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6:
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8:
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (255, 0, 0, 0)
        }

        self.init(
            .sRGB,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue: Double(b) / 255,
            opacity: Double(a) / 255
        )
    }
}
