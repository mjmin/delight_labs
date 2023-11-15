//
//  TransactionViewModel.swift
//  delight_labs
//
//  Created by Minji Kim on 2023/11/14.
//

import Foundation

struct TransactionListViewModel {
    let list: [Transaction]
}

extension TransactionListViewModel {
    var numberOfSections: Int {
        return 1
    }
    func listAtType(_ type : transactionType) -> [Transaction] {
        var selectedList : [Transaction]
        switch type {
        case .All:
            selectedList = list
        case .Expense :
            selectedList = list.filter{
                guard let amount = $0.amount else { return false }
                return amount < 0
            }
        case .Income :
            selectedList = list.filter{
                guard let amount = $0.amount else { return false }
                return amount > 0
            }
        }
        return selectedList
    }
    func numberOfRowsAtType(_ type : transactionType) -> Int {
        var selectedList : [Transaction]
        switch type {
        case .All:
            selectedList = list
        case .Expense :
            selectedList = list.filter{
                guard let amount = $0.amount else { return false }
                return amount < 0
            }
        case .Income :
            selectedList = list.filter{
                guard let amount = $0.amount else { return false }
                return amount > 0
            }
        }
        return selectedList.count
    }
    
    func transactionAtIndex(_ index: Int) -> TransactionViewModel {
        let transaction = self.list[index]
        return TransactionViewModel(transaction)
    }
    
    func transactionAtIndex(_ index: Int, type : transactionType) -> TransactionViewModel {
        var selectedList : [Transaction]
        switch type {
        case .All:
            selectedList = list
        case .Expense :
            selectedList = list.filter{
                guard let amount = $0.amount else { return false }
                return amount < 0
            }
        case .Income :
            selectedList = list.filter{
                guard let amount = $0.amount else { return false }
                return amount > 0
            }
        }
        let item = selectedList[index]
        return TransactionViewModel(item)
    }
}

struct TransactionViewModel {
    private let transaction: Transaction
}

extension TransactionViewModel {
    init(_ transaction: Transaction) {
        self.transaction = transaction
    }
}

extension TransactionViewModel {
    var name: String? {
        return self.transaction.name
    }
    var type: String? {
        return self.transaction.type
    }
    var amount: Float? {
        return self.transaction.amount
    }
    var timestamp: Date? {
        return self.transaction.timestamp
    }
}
