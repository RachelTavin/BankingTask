//
//  TransactionsListView.swift
//  BankingTask
//
//  Created by TavinFam on 20/05/2026.
//

import SwiftUI
import BankingDesignSystem

struct TransactionsListView: View {
    
    @Environment(TransactionsStore.self)
    private var store
    
    var body: some View {
        NavigationStack {
            List {
                balanceHeader
                
                transactionsRows
                
                loadingRow
            }
            .listStyle(.plain)
            .navigationTitle("Transactions")
            .task {
                await loadInitialDataIfNeeded()
            }
        }
    }
    
    private var transactionsRows: some View {
        ForEach(store.transactions.indices, id: \.self) { index in
            
            let transaction = store.transactions[index]
            
            NavigationLink {
                TransactionDetailsView(
                    transaction: Binding(
                        get: {
                            store.transactions[index]
                        },
                        set: { newValue in
                            store.transactions[index] = newValue
                        }
                    )
                )
            } label: {
                transactionRow(transaction)
            }
            .listRowSeparator(.hidden)
            .listRowBackground(Color.clear)
            .onAppear {
                loadMoreIfNeeded(currentTransaction: transaction)
            }
        }
    }
    
    private var balanceHeader: some View {
        VStack(alignment: .leading, spacing: DSSpacing.md) {
            Text("Current Balance")
                .font(DSTypography.medium)
                .foregroundStyle(.white.opacity(0.8))
            
            Text(store.totalBalance, format: .currency(code: "USD"))
                .font(DSTypography.medium)
                .foregroundStyle(.white)
            
            Text("Available balance")
                .font(DSTypography.medium)
                .foregroundStyle(.white.opacity(0.8))
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(DSColors.primary)
        .clipShape(RoundedRectangle(cornerRadius: DSRadius.xl))
        .listRowSeparator(.hidden)
        .listRowBackground(Color.clear)
    }
    
    private func transactionRow(_ transaction: Transaction) -> some View {
        HStack(spacing: DSSpacing.lg) {
            Circle()
                .fill(
                    transaction.isIncome
                    ? DSColors.income.opacity(0.15)
                    : DSColors.expense.opacity(0.15)
                )
                .frame(width: DSSpacing.iconCircle, height: DSSpacing.iconCircle)
                .overlay {
                    Image(systemName: transaction.isIncome ? DSIcons.income : DSIcons.expense)                        .foregroundStyle(
                            transaction.isIncome ? DSColors.income : DSColors.expense
                        )
                        .font(.headline)
                }
            
            VStack(alignment: .leading, spacing: DSSpacing.xs) {
                Text(transaction.title)
                    .font(DSTypography.medium)
                    .foregroundStyle(DSColors.textPrimary)
                
                Text(transaction.subtitle)
                    .font(DSTypography.regular13)
                    .foregroundStyle(DSColors.textSecondary)
            }
            
            Spacer()
            
            Text("$\(transaction.amount.formatted())")
                .font(DSTypography.medium)
                .foregroundStyle(
                    transaction.isIncome ? DSColors.income : DSColors.expense
                )
        }
        .padding()
        .background(DSColors.cardBackground)
        .clipShape(RoundedRectangle(cornerRadius: DSRadius.lg))
    }
    
    @ViewBuilder
    private var loadingRow: some View {
        if store.isLoading {
            HStack {
                Spacer()
                ProgressView()
                Spacer()
            }
            .listRowSeparator(.hidden)
            .listRowBackground(Color.clear)
        }
    }
    
    private func loadInitialDataIfNeeded() async {
        if store.transactions.isEmpty {
            await store.loadTransactions()
        }
    }
    
    private func loadMoreIfNeeded(currentTransaction: Transaction) {
        guard currentTransaction == store.transactions.last else {
            return
        }
        
        Task {
            await store.loadTransactions()
        }
    }
}

#Preview {
    TransactionsListView()
        .environment(TransactionsStore())
}
