//
//  BankingTaskApp.swift
//  BankingTask
//
//  Created by TavinFam on 20/05/2026.
//

import SwiftUI

@main
struct BankingTaskApp: App {
    
    @State private var store = TransactionsStore()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(store)
        }
    }
}
