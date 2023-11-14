//
//  CollectionHeaderView.swift
//  delight_labs
//
//  Created by Minji Kim on 2023/11/14.
//

import Foundation
import UIKit

class CollectionHeaderView: UICollectionReusableView {
    
    let titleStack = UIStackView().then {
        $0.alignment = .center
    }
    let titleLabel = UILabel().then() {
        $0.font = UIFont.popinsBold(size: 24)
        $0.text = "Activity"
    }
    let notificationButton = UIButton().then {
        $0.tintColor = .black
        $0.setImage(UIImage(named: "bell")?.withTintColor(.black), for: .normal)
        $0.imageView?.snp.makeConstraints({
            $0.width.height.equalTo(24)
            $0.trailing.equalToSuperview()
        })
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure() {
        self.backgroundColor = .white
        self.addSubview(titleStack)
        [titleLabel, notificationButton].forEach {
            titleStack.addArrangedSubview($0)
        }
    }
    
    func setConstraints () {
        titleStack.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.height.equalToSuperview()
        }
    }
    
}
