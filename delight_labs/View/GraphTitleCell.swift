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
        $0.text = Date().formatted("MMM d, yyyy")
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
    
    let dayBtn = SwitchButton().then {
        $0.setTitle("Day", for: .normal)
        $0.titleLabel?.font = .popinsBold(size: 16)
        $0.setTitleColor(.switchTextLight, for: .normal)
        $0.setTitleColor(.white, for: .selected)
        
        $0.layer.cornerRadius = 17
        $0.layer.masksToBounds = true
        $0.clipsToBounds = true
        $0.isSelected = true
    }
    
    let monthBtn = SwitchButton().then {
        $0.setTitle("Month", for: .normal)
        $0.titleLabel?.font = .popinsBold(size: 16)
        $0.setTitleColor(.switchTextDark, for: .normal)
        $0.setTitleColor(.white, for: .selected)
        
        $0.layer.cornerRadius = 17
        $0.layer.masksToBounds = true
        $0.clipsToBounds = true

    }
    
    
    func setConfigure() {
        backgroundColor = .white
        [titleView].forEach {
            self.addSubview($0)
        }
        [switchView, dateLabel].forEach {
            titleView.addArrangedSubview($0)
        }
        [dayBtn, monthBtn].forEach {
            switchView.addArrangedSubview($0)
        }
    }
    
    func setConstraints() {
        titleView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalToSuperview().inset(20)
            make.height.equalTo(34)
        }
        
        switchView.snp.makeConstraints { make in
            make.width.equalTo(172)
        }
    }
    
    
    func typeBtnSelected (type : graphType) {
        let current = Date()
        
        switch type {
        case .Day :
            dayBtn.isSelected = true
            monthBtn.isSelected = false
            dateLabel.text = Date().formatted("MMM d, yyyy")
        case .Month:
            dayBtn.isSelected = false
            monthBtn.isSelected = true
            let month = current.formatted("MMM")
            dateLabel.text = "\(month) 1 - \(month) \(current.lastDayofMonth()), \(current.formatted("yyyy"))"
        }
        
    }
}

enum graphType {
    case Day
    case Month
}
