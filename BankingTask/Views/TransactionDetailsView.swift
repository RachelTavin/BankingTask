//
//  TransactionDetailsView.swift
//  BankingTask
//
//  Created by TavinFam on 21/05/2026.
//

import SwiftUI
import BankingDesignSystem

struct TransactionDetailsView: View {

    @Environment(\.dismiss)
    private var dismiss

    @Binding var transaction: Transaction

    var body: some View {
        ScrollView {
            VStack(spacing: DSSpacing.xxl) {
                amountCard
                editSection
                detailsSection
                
                Button("Back to Transactions") {
                    dismiss()
                }
                .buttonStyle(DSPrimaryButtonStyle())

                Spacer()
            }
            .padding(DSSpacing.lg)
        }
        .background(DSColors.background)
        .navigationTitle("Details")
        .navigationBarBackButtonHidden()
     
    }

    // MARK: - Amount Card
    private var amountCard: some View {
        VStack(spacing: DSSpacing.md) {
            Circle()
                .fill(transaction.isIncome ? DSColors.incomeBg : DSColors.expenseBg)
                .frame(width: DSSpacing.iconCircle, height: DSSpacing.iconCircle)
                .overlay {
                    Image(systemName: transaction.isIncome ? DSIcons.income : DSIcons.expense)
                        .foregroundStyle(transaction.isIncome ? DSColors.income : DSColors.expense)
                        .font(.system(size: DSSpacing.iconMedium))
                }

            Text(transaction.amount, format: .currency(code: "USD").presentation(.narrow))
                .font(DSTypography.medium)
                .foregroundStyle(transaction.isIncome ? DSColors.income : DSColors.expense)

            Text(transaction.subtitle)
                .font(DSTypography.regular16)
                .foregroundStyle(DSColors.textSecondary)

            Text(transaction.date, style: .date)
                .font(DSTypography.regular13)
                .foregroundStyle(DSColors.textSecondary)
        }
        .padding(DSSpacing.xxl)
        .frame(maxWidth: .infinity)
        .background(DSColors.cardBackground)
        .clipShape(RoundedRectangle(cornerRadius: DSRadius.xl))
    }

    // MARK: - Edit Section
    private var editSection: some View {
        VStack(alignment: .leading, spacing: DSSpacing.sm) {
            Label("Transaction name", systemImage: DSIcons.edit)
                .font(DSTypography.semiBold)
                .foregroundStyle(DSColors.textSecondary)

            TextField("Transaction title", text: $transaction.title)
                .font(DSTypography.regular16)
                .padding(DSSpacing.md)
                .background(DSColors.background)
                .clipShape(RoundedRectangle(cornerRadius: DSRadius.sm))
                .overlay {
                    RoundedRectangle(cornerRadius: DSRadius.sm)
                        .stroke(DSColors.divider, lineWidth: 1)
                }
        }
        .padding(DSSpacing.lg)
        .background(DSColors.cardBackground)
        .clipShape(RoundedRectangle(cornerRadius: DSRadius.lg))
    }

    // MARK: - Details Section
    private var detailsSection: some View {
        VStack(alignment: .leading, spacing: DSSpacing.lg) {
            HStack(spacing: DSSpacing.md) {
                Image(systemName: DSIcons.info)
                    .foregroundStyle(DSColors.primary)

                Text("Operation details")
                    .font(DSTypography.regular16)
                    .foregroundStyle(DSColors.textPrimary)

                Spacer()
            }

            Divider()
                .background(DSColors.divider)

            detailRow("Type",     value: transaction.isIncome ? "Income" : "Expense")
            detailRow("Category", value: transaction.subtitle)
            detailRow("Date",     value: transaction.date.formatted(date: .long, time: .omitted))
            detailRow("Status",   value: "Completed")
        }
        .padding(DSSpacing.lg)
        .background(DSColors.cardBackground)
        .clipShape(RoundedRectangle(cornerRadius: DSRadius.lg))
    }

    private func detailRow(_ title: String, value: String) -> some View {
        HStack {
            Text(title)
                .font(DSTypography.regular13)
                .foregroundStyle(DSColors.textSecondary)

            Spacer()

            Text(value)
                .font(DSTypography.semiBold)
                .foregroundStyle(DSColors.textPrimary)
        }
    }
}

#Preview {
    @Previewable @State var transaction = Transaction(
        title: "Amazon",
        subtitle: "Online shopping",
        amount: -54.99,
        date: .now,
        isIncome: false
    )

    NavigationStack {
        TransactionDetailsView(transaction: $transaction)
    }
}
