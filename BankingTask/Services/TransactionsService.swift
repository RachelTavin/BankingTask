//
//  TransactionsService.swift
//  BankingTask
//
//  Created by TavinFam on 20/05/2026.
//

import Foundation

protocol TransactionsServiceProtocol {
    func fetchTransactions(page: Int, pageSize: Int) async throws -> [Transaction]
}

final class MockTransactionsService: TransactionsServiceProtocol {

    func fetchTransactions(page: Int, pageSize: Int) async throws -> [Transaction] {
        try await Task.sleep(for: .milliseconds(400))

        let all = Self.makeMockTransactions()
        let startIndex = (page - 1) * pageSize
        let endIndex = min(startIndex + pageSize, all.count)

        guard startIndex < all.count else { return [] }
        return Array(all[startIndex..<endIndex])
    }

    private static func makeMockTransactions() -> [Transaction] {
        let items: [(name: String, subtitle: String, isIncome: Bool, amount: Double)] = [
            ("Salary",        "Monthly income",    true,   8500.00),
            ("Amazon",        "Online shopping",   false,  -134.99),
            ("Spotify",       "Subscription",      false,  -9.99),
            ("Apple",         "App Store",         false,  -4.99),
            ("Netflix",       "Subscription",      false,  -15.99),
            ("Starbucks",     "Coffee & Food",     false,  -12.50),
            ("Uber",          "Transportation",    false,  -23.40),
            ("Wolt",          "Food delivery",     false,  -38.70),
            ("Super Market",  "Groceries",         false,  -210.00),
            ("Electric Bill", "Utilities",         false,  -180.00),
            ("Freelance",     "Project payment",   true,   1200.00),
            ("PayPal",        "Transfer received", true,   350.00),
        ]

        let calendar = Calendar.current
        let today = Date.now

        return (0..<100).map { index in
            let item = items[index % items.count]
            let daysAgo = index / items.count
            let date = calendar.date(byAdding: .day, value: -daysAgo, to: today) ?? today

            return Transaction(
                title: item.name,
                subtitle: item.subtitle,
                amount: item.amount,
                date: date,
                isIncome: item.isIncome
            )
        }
    }
}
