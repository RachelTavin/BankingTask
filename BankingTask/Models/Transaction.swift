//
//  Transaction.swift
//  BankingTask
//
//  Created by TavinFam on 20/05/2026.
//

import Foundation

struct Transaction: Identifiable {
    let id: UUID
    var title: String
    var subtitle: String
    var amount: Double
    var date: Date
    var isIncome: Bool
    
    init(
        id: UUID = UUID(),
        title: String,
        subtitle: String,
        amount: Double,
        date: Date = .now,
        isIncome: Bool
    ) {
        self.id = id
        self.title = title
        self.subtitle = subtitle
        self.amount = amount
        self.date = date
        self.isIncome = isIncome
    }
}

extension Transaction: Equatable {
    static func == (lhs: Transaction, rhs: Transaction) -> Bool {
        lhs.id == rhs.id
    }
}

extension Transaction: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
