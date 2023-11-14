//
//  MainView.swift
//  delight_labs
//
//  Created by Minji Kim on 2023/11/13.
//

import Foundation
import UIKit
import Then
import SnapKit

class MainView : UIView {
    let defaultMargin = 30
    
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.sectionHeadersPinToVisibleBounds = true

        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.delaysContentTouches = false
        view.isScrollEnabled = true
        view.showsVerticalScrollIndicator = false
        return view
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setConfigure()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setConfigure()
        setConstraints()
    }
    
    func setConfigure() {
        backgroundColor = .white
        [collectionView].forEach {
            self.addSubview($0)
        }
    }
    
    func setConstraints() {
        collectionView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(defaultMargin)
            make.top.bottom.equalTo(self.safeAreaLayoutGuide)
        }
    }
}
