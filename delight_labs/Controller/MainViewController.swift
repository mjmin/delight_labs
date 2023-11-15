//
//  MainViewController.swift
//  delight_labs
//
//  Created by Minji Kim on 2023/11/13.
//

import UIKit

class MainViewController: UIViewController {
    
    let mainView = MainView()
    private var transactionListVM: TransactionListViewModel!
    
    let customCollectionCount = 3
    let graphTitleIndexPath = IndexPath(row: 0, section: 0)
    let graphIndexPath = IndexPath(row: 1, section: 0)
    let transactionTitleIndexPath = IndexPath(row: 2, section: 0)
    
    var transactionCount: Int = 20
    var selectedTransactionType : transactionType = .All {
        didSet {
            // set transactionCount
            var defaultCount : Int
            switch selectedTransactionType {
            case .All :
                defaultCount = 20
            default:
                defaultCount = 10
            }
            let VMListCount = transactionListVM.numberOfRowsAtType(selectedTransactionType)
            transactionCount = min(VMListCount, defaultCount)
            
            // set Type Button Selected
            guard let cell = mainView.collectionView.cellForItem(at: transactionTitleIndexPath) as? TransactionTitleCell else { return }
            cell.typeBtnSelected(type: selectedTransactionType)
            mainView.collectionView.reloadData()
        }
    }
    
    var seletedGraphType : graphType = .Day {
        didSet {
            
            // set Type Button Selected
            // graph Title - [switchButton, Date] Change
            guard let cell = mainView.collectionView.cellForItem(at: graphTitleIndexPath) as? GraphTitleCell else { return }
            cell.typeBtnSelected(type: seletedGraphType)
            // graph - [axis] Change
            guard let cell = mainView.collectionView.cellForItem(at: graphIndexPath) as? GraphCell else { return }
            cell.typeBtnSelected(type: seletedGraphType)
            mainView.collectionView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view = mainView
        setCollectionView()
    }
    
    override func loadView() {
        super.loadView()
        getTransactionData()
    }
    
    func getTransactionData () {
        if let path = Bundle.main.path(forResource: "mockdata", ofType: "json") {
            do {
                  let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                  let jsonResult = try JSONSerialization.jsonObject(with: data, options: .mutableLeaves)
                
                  if let jsonResult = jsonResult as? [Dictionary<String, AnyObject>] {
                      
                      let transactions = jsonResult.compactMap {
                          if let name = $0["name"] as? String, let type = $0["type"] as? String, let amount = Float($0["amount"] as? Substring ?? "0"), let date = $0["timestamp"] as? String, let timestamp = date.toDate() {
                              return Transaction(name: name, type: type, amount: amount, timestamp: timestamp)
                          }
                          return nil
                      }
                      
                      self.transactionListVM = TransactionListViewModel(list: transactions)
                  }
              } catch {
                   // handle error
              }
        }
    }
    
    func setCollectionView (){
        mainView.collectionView.delegate = self
        mainView.collectionView.dataSource = self
        
        mainView.collectionView.register(GraphTitleCell.self, forCellWithReuseIdentifier: GraphTitleCell.reuseIdentifier)
        mainView.collectionView.register(GraphCell.self, forCellWithReuseIdentifier: GraphCell.reuseIdentifier)
        mainView.collectionView.register(TransactionTitleCell.self, forCellWithReuseIdentifier: TransactionTitleCell.reuseIdentifier)
        mainView.collectionView.register(TransactionTableCell.self, forCellWithReuseIdentifier: TransactionTableCell.reuseIdentifier)
        mainView.collectionView.register(CollectionHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: CollectionHeaderView.reuseIdentifier)
        
        mainView.collectionView.reloadData()
        selectedTransactionType = .All
    }
}

extension MainViewController :UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return customCollectionCount + transactionCount
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch (indexPath.row) {
        case 0 :
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GraphTitleCell.reuseIdentifier, for: indexPath) as? GraphTitleCell else {
                return UICollectionViewCell()
            }
            cell.contentView.isUserInteractionEnabled = false
            cell.dayBtn.addTarget(self, action: #selector(onGraphSwitchChanged), for: .touchUpInside)
            cell.monthBtn.addTarget(self, action: #selector(onGraphSwitchChanged), for: .touchUpInside)
            return cell
        case 1 :
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GraphCell.reuseIdentifier, for: indexPath) as? GraphCell else {
                return UICollectionViewCell()
            }
            return cell
        case 2 :
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TransactionTitleCell.reuseIdentifier, for: indexPath) as? TransactionTitleCell else {
                return UICollectionViewCell()
            }
            cell.contentView.isUserInteractionEnabled = false
            cell.allBtn.addTarget(self, action: #selector(onTransactionTypeChanged), for: .touchUpInside)
            cell.expenseBtn.addTarget(self, action: #selector(onTransactionTypeChanged), for: .touchUpInside)
            cell.incomeBtn.addTarget(self, action: #selector(onTransactionTypeChanged), for: .touchUpInside)
            return cell
        default:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TransactionTableCell.reuseIdentifier, for: indexPath) as? TransactionTableCell else {
                return UICollectionViewCell()
            }
            let item = transactionListVM.transactionAtIndex(indexPath.row - customCollectionCount , type: selectedTransactionType)
            cell.nameLabel.text = item.name
            cell.typeLabel.text = item.type
            
            cell.timeLabel.text = item.timestamp?.formatted("h.mm a")
            if let amount = item.amount {
                if amount > 0 {
                    cell.amountLabel.text = "+\(String(format: "%.1f", amount))"
                }else {
                    cell.amountLabel.text = "\(String(format: "%.1f", amount))"
                }
            }
            return cell
        }
    }
    
    @objc private func onGraphSwitchChanged(_ sender : UIButton) {
        guard let cell = mainView.collectionView.cellForItem(at: graphTitleIndexPath) as? GraphTitleCell else { return }
        if sender == cell.dayBtn {
            seletedGraphType = .Day
        }else {
            seletedGraphType = .Month
        }
    }
    
    @objc private func onTransactionTypeChanged(_ sender : UIButton) {
        guard let cell = mainView.collectionView.cellForItem(at: transactionTitleIndexPath) as? TransactionTitleCell else { return }
        if sender == cell.allBtn {
            selectedTransactionType = .All
        }else if sender == cell.expenseBtn {
            selectedTransactionType = .Expense
        }else {
            selectedTransactionType = .Income
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
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
            return CGSize(width: collectionView.frame.width, height: 230)
        case 2:
            return CGSize(width: collectionView.frame.width, height: 90)
        default:
            return CGSize(width: collectionView.frame.width, height: 65)
        }
        
    }
    
}
