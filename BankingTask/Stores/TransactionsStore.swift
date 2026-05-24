//
//  TransactionsStore.swift
//  BankingTask
//
//  Created by TavinFam on 20/05/2026.
//

import Foundation
import Observation

@Observable
final class TransactionsStore {

    private let service: TransactionsServiceProtocol

    var transactions: [Transaction] = []
    var isLoading = false
    var hasMorePages = true
    var errorMessage: String?

    var totalBalance: Double {
        transactions.reduce(0) { $0 + $1.amount }
    }

    private var currentPage = 1
    private let pageSize = 20

    init(service: TransactionsServiceProtocol = MockTransactionsService()) {
        self.service = service
    }

    func loadTransactions() async {
        guard !isLoading, hasMorePages else {
            return
        } 

        isLoading = true
        errorMessage = nil

        do {
            let newTransactions = try await service.fetchTransactions(
                page: currentPage,
                pageSize: pageSize
            )

            if newTransactions.isEmpty {
                hasMorePages = false
            } else {
                transactions.append(contentsOf: newTransactions)
                currentPage += 1
            }

        } catch {
            errorMessage = "Failed to load transactions. Please try again."
        }

        isLoading = false
    }
}
