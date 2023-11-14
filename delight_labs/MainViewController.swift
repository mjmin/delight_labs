//
//  MainViewController.swift
//  delight_labs
//
//  Created by Minji Kim on 2023/11/13.
//

import UIKit

class MainViewController: UIViewController {
    let mainView = MainView()
    var trasactionCount = 10
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view = mainView
        setCollectionView()
    }
    
    func setCollectionView (){
        mainView.collectionView.delegate = self
        mainView.collectionView.dataSource = self
        
        mainView.collectionView.register(GraphTitleCell.self, forCellWithReuseIdentifier: GraphTitleCell.reuseIdentifier)
        mainView.collectionView.register(TransactionTitleCell.self, forCellWithReuseIdentifier: TransactionTitleCell.reuseIdentifier)
        mainView.collectionView.register(TransactionTableCell.self, forCellWithReuseIdentifier: TransactionTableCell.reuseIdentifier)
        mainView.collectionView.register(CollectionHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: CollectionHeaderView.reuseIdentifier)
    }
}

extension MainViewController :UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2 + trasactionCount
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch (indexPath.row) {
        case 0 :
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GraphTitleCell.reuseIdentifier, for: indexPath) as? GraphTitleCell else {
                return UICollectionViewCell()
            }
            cell.contentView.isUserInteractionEnabled = false
            return cell
        case 1 :
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TransactionTitleCell.reuseIdentifier, for: indexPath) as? TransactionTitleCell else {
                return UICollectionViewCell()
            }
            cell.contentView.isUserInteractionEnabled = false
            return cell
        default:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TransactionTableCell.reuseIdentifier, for: indexPath) as? TransactionTableCell else {
                return UICollectionViewCell()
            }
            cell.contentView.isUserInteractionEnabled = false
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        print(#function, kind)
        if kind == UICollectionView.elementKindSectionHeader {
            guard let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: CollectionHeaderView.reuseIdentifier, for: indexPath) as? CollectionHeaderView else {
                return UICollectionReusableView()
            }
            header.configure()
            return header
        }
        
        return UICollectionReusableView()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: view.frame.size.width, height: 70)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch (indexPath.row) {
        case 0 :
            return CGSize(width: collectionView.frame.width, height: 110)
        case 1:
            return CGSize(width: collectionView.frame.width, height: 90)
        default:
            return CGSize(width: collectionView.frame.width, height: 65)
        }
        
    }
    
}
