//
//  GraphTitleCell.swift
//  delight_labs
//
//  Created by Minji Kim on 2023/11/13.
//

import Foundation
import UIKit

class GraphTitleCell : UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setConfigure()
        setConstraints()
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    let titleView = UIStackView().then {
        $0.alignment = .center
    }
    
    let dateLabel = UILabel().then {
        $0.font = UIFont.popinsRegular(size: 12)
        $0.textAlignment = .right
        $0.text = "MM-DD-YYYY"
        $0.textColor = .navy
    }
    
    let switchView = UIStackView().then {
        $0.alignment = .center
        $0.distribution = .fillEqually
        $0.backgroundColor = .lightGray
        $0.layer.cornerRadius = 17
        $0.layer.masksToBounds = true
        $0.clipsToBounds = true
    }
    
    let dayBtn = UIButton().then {
        $0.setTitle("Day", for: .normal)
        $0.backgroundColor = .navy
        $0.setTitleColor(.switchTextLight, for: .normal)
        $0.titleLabel?.font = .popinsBold(size: 16)
        
        $0.layer.cornerRadius = 17
        $0.layer.masksToBounds = true
        $0.clipsToBounds = true
    }
    
    let monthBtn = UIButton().then {
        $0.setTitle("Month", for: .normal)
        $0.titleLabel?.font = .popinsBold(size: 16)
        $0.setTitleColor(.switchTextDark, for: .normal)
        
        $0.layer.cornerRadius = 17
        $0.layer.masksToBounds = true
        $0.clipsToBounds = true
    }
    
    
    let graphLabelStack = UIStackView().then {
        $0.alignment = .center
        $0.spacing = 10
    }
    
    let incomeColor = UIView().then {
        $0.backgroundColor = .navy
    }
    let incomeText = BaseLabel().then {
        $0.text = "Income"
        $0.setSize(12)
    }
    let expenseColor = UIView().then {
        $0.backgroundColor = .green
    }
    let expenseText = BaseLabel().then {
        $0.text = "Expense"
        $0.setSize(12)
    }
    let emptyView = UIView()
    
    
    func setConfigure() {
        backgroundColor = .white
        [titleView, graphLabelStack].forEach {
            self.addSubview($0)
        }
        [switchView, dateLabel].forEach {
            titleView.addArrangedSubview($0)
        }
        [dayBtn, monthBtn].forEach {
            switchView.addArrangedSubview($0)
        }
        [incomeColor, incomeText, expenseColor, expenseText, emptyView].forEach {
            graphLabelStack.addArrangedSubview($0)
        }
    }
    
    func setConstraints() {
        titleView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalToSuperview().inset(20)
            make.height.equalTo(34)
        }
        
        graphLabelStack.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(self.titleView.snp.bottom).offset(20)
        }
        switchView.snp.makeConstraints { make in
            make.width.equalTo(172)
        }
        incomeColor.snp.makeConstraints { make in
            make.width.equalTo(32)
            make.height.equalTo(5)
        }
        expenseColor.snp.makeConstraints { make in
            make.width.equalTo(32)
            make.height.equalTo(5)
        }
    }
}
