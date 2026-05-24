//
//  DSPrimaryButtonStyle.swift
//  BankingDesignSystem
//
//  Created by TavinFam on 24/05/2026.
//

import SwiftUI

public struct DSPrimaryButtonStyle: ButtonStyle {
    public init() {}

    public func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(DSTypography.semiBold)         
            .foregroundStyle(DSColors.textOnPrimary)
            .frame(maxWidth: .infinity)
            .padding(.vertical, DSSpacing.lg)
            .background(
                configuration.isPressed
                    ? DSColors.primaryLight
                    : DSColors.primary
            )
            .clipShape(RoundedRectangle(cornerRadius: DSRadius.sm))
            .animation(.easeInOut(duration: 0.15), value: configuration.isPressed)
    }
}
