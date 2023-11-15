//
//  TransactionTableCell.swift
//  delight_labs
//
//  Created by Minji Kim on 2023/11/14.
//

import Foundation
import UIKit
import Then
import SnapKit

class TransactionTableCell : UICollectionViewCell {
    
    var item : TransactionViewModel? = nil {
        didSet {
            guard let item = item else { return }
            nameLabel.text = item.name
            typeLabel.text = item.type
            
            timeLabel.text = item.timestamp?.formatted("h.mm a")
            if let amount = item.amount {
                if amount > 0 {
                    amountLabel.text = "+\(String(format: "%.1f", amount))"
                }else {
                    amountLabel.text = "\(String(format: "%.1f", amount))"
                }
            }
        }
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setConfigure()
        setConstraints()
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    let stackView = UIStackView().then() {
        $0.alignment = .center
        $0.spacing = 12
    }
    
    let image = UIImageView().then {
        $0.backgroundColor = .transactionImageColor
        $0.layer.cornerRadius = 8
        $0.layer.masksToBounds = true
        $0.clipsToBounds = true
    }
    
    let titleStack = UIStackView().then {
        $0.alignment = .leading
        $0.axis = .vertical
        $0.spacing = 3
    }
    
    let nameLabel = BaseLabel().then {
        $0.font = UIFont.popinsSemiBold(size: 16)
        $0.text = "Title"
    }
    
    let typeLabel = BaseLabel().then {
        $0.font = UIFont.popinsRegular(size: 14)
        $0.textColor = .transactionDescriptionColor
        $0.text = "Description"
    }
    
    let numberStack = UIStackView().then {
        $0.alignment = .trailing
        $0.axis = .vertical
        $0.spacing = 3
    }
    
    let amountLabel = BaseLabel().then {
        $0.font = UIFont.popinsBold(size: 16)
        $0.textColor = .navy
        $0.textAlignment = .right
        $0.text = "+120.01"
    }
    
    let timeLabel = BaseLabel().then {
        $0.font = UIFont.popinsRegular(size: 14)
        $0.textColor = .transactionDescriptionColor
        $0.textAlignment = .right
        $0.text = "12:00 AM"
    }
    
    func setConfigure() {
        self.backgroundColor = .white
        self.addSubview(stackView)
        [image, titleStack, numberStack].forEach {
            stackView.addArrangedSubview($0)
        }
        [nameLabel, typeLabel].forEach {
            titleStack.addArrangedSubview($0)
        }
        [amountLabel, timeLabel].forEach {
            numberStack.addArrangedSubview($0)
        }
    }
    
    func setConstraints(){
        stackView.snp.makeConstraints { make in
            make.leading.trailing.top.equalToSuperview()
            make.height.equalTo(55)
        }
        image.snp.makeConstraints { make in
            make.leading.top.equalToSuperview()
//            make.height.equalToSuperview()
            make.width.height.equalTo(55)
        }
    }
}
