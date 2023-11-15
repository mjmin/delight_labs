//
//  GraphCell.swift
//  delight_labs
//
//  Created by Minji Kim on 2023/11/15.
//

import Foundation
import UIKit

class GraphCell : UICollectionViewCell {
    
    let graphView = UIView().then {
        $0.backgroundColor = nil
    }
    let expenseView = UIImageView().then {
        $0.image = UIImage(named: "expense1")
        $0.contentMode = .scaleAspectFit
    }
    
    let incomeView = UIImageView().then {
        $0.image = UIImage(named: "income1")
        $0.contentMode = .scaleAspectFit
    }
    
    let axisStack = UIStackView().then {
        $0.alignment = .center
    }
    
    let axisTextStart = BaseLabel().then {
        $0.text = "00"
        $0.textColor = .transactionLight
        $0.font = .popinsSemiBold(size: 16)
    }
    let axisTextEnd = BaseLabel().then {
        $0.text = "24"
        $0.textColor = .transactionLight
        $0.font = .popinsSemiBold(size: 16)
        $0.textAlignment = .right
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setConfigure()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func setConfigure() {
        [graphView, axisStack].forEach {
            self.addSubview($0)
        }
        [expenseView, incomeView].forEach {
            graphView.addSubview($0)
        }
        [axisTextStart, axisTextEnd].forEach {
            axisStack.addArrangedSubview($0)
        }
    }
    
    func setConstraints() {
        graphView.snp.makeConstraints { make in
            make.leading.trailing.top.equalToSuperview()
            make.height.equalTo(186)
        }
        expenseView.snp.makeConstraints { make in
            make.leading.trailing.bottom.height.equalToSuperview()
        }
        incomeView.snp.makeConstraints { make in
            make.leading.trailing.bottom.height.equalToSuperview()
        }
        axisStack.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(graphView.snp.bottom)
        }

    }
    
    func typeBtnSelected (type : graphType) {
        let current = Date()
        
        switch type {
        case .Day :
            axisTextStart.text = "00"
            axisTextEnd.text = "24"
        case .Month:
            let month = current.formatted("MMM")
            axisTextStart.text = "\(month) 1"
            axisTextEnd.text = "\(month) \(current.lastDayofMonth())"
        }
        
    }
}
