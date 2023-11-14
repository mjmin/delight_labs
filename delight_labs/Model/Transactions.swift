//
//  Transactions.swift
//  delight_labs
//
//  Created by Minji Kim on 2023/11/14.
//

import Foundation
struct TransactionList : Decodable {
    let list : [Transaction]
}

struct Transaction : Decodable {
    let name : String?
    let type : String?
    let amount : Float?
    let timestamp : Date?
}
