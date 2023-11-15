//
//  TransactionTitleCell.swift
//  delight_labs
//
//  Created by Minji Kim on 2023/11/13.
//

import Foundation
import UIKit

class TransactionTitleCell : UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setConfigure()
        setConstraints()
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    let titleLabel = UILabel().then {
        $0.font = UIFont.popinsBold(size: 18)
        $0.text = "Recent Transactions"
    }
    
    let typeStack = UIStackView().then {
        $0.alignment = .center
        $0.spacing = 20
    }
    
    let allBtn = UIButton().then {
        $0.setTitle("All", for: .normal)
        $0.titleLabel?.font = .popinsBold(size: 16)
        $0.setTitleColor(.transactionLight, for: .normal)
        $0.setTitleColor(.navy, for: .selected)
        $0.isSelected = true
    }
    
    let expenseBtn = UIButton().then {
        $0.setTitle("Expense", for: .normal)
        $0.titleLabel?.font = .popinsBold(size: 16)
        $0.setTitleColor(.transactionLight, for: .normal)
        $0.setTitleColor(.navy, for: .selected)
    }
    
    let incomeBtn = UIButton().then {
        $0.setTitle("Income", for: .normal)
        $0.titleLabel?.font = .popinsBold(size: 16)
        $0.setTitleColor(.transactionLight, for: .normal)
        $0.setTitleColor(.navy, for: .selected)
        
    }
    
    let emptyView = UIView()
    
    func setConfigure() {
        backgroundColor = .white
        [titleLabel, typeStack].forEach {
            self.addSubview($0)
        }
        [allBtn, expenseBtn, incomeBtn, emptyView].forEach {
            typeStack.addArrangedSubview($0)
        }
    }
    
    func setConstraints() {
        titleLabel.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
        }
        
        typeStack.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(self.titleLabel.snp.bottom).offset(20)
        }
    
    }
    
    
    func typeBtnSelected (type : transactionType) {
        switch type {
        case .All :
            allBtn.isSelected = true
            expenseBtn.isSelected = false
            incomeBtn.isSelected = false
        case .Expense:
            allBtn.isSelected = false
            expenseBtn.isSelected = true
            incomeBtn.isSelected = false
        case .Income:
            allBtn.isSelected = false
            expenseBtn.isSelected = false
            incomeBtn.isSelected = true
        }
        
    }
    
}

enum transactionType {
    case All
    case Expense
    case Income
}
