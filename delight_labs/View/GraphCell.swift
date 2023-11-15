//
//  GraphCell.swift
//  delight_labs
//
//  Created by Minji Kim on 2023/11/15.
//

import Foundation
import UIKit
import DGCharts

class GraphCell : UICollectionViewCell {
    
    
    let animateDuration : Double = 1
    let animateEasing : ChartEasingOption = .easeInBack
    
    let lineChartView = LineChartView().then {
        
        $0.doubleTapToZoomEnabled = false
        $0.pinchZoomEnabled = false
        $0.drawGridBackgroundEnabled = false
        $0.xAxis.enabled = false
        $0.rightAxis.enabled = false
        $0.leftAxis.enabled = false
        $0.chartDescription.enabled = false
        
        $0.legend.enabled = false
        $0.setMarker(defaultColor: .navy)
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
    
    func setChartData (income : [Transaction], expense : [Transaction]) {
        
        var lineChartEntry = [ChartDataEntry]() // graph 에 보여줄 data array
        
        // chart data array 에 데이터 추가
        for i in 0..<income.count {
            let value = ChartDataEntry(x: Double(i), y: Double(income[i].amount ?? 0), data: income[i])
            lineChartEntry.append(value)
        }
        
        let line1 = LineChartDataSet(entries: lineChartEntry, label: "Income")
        setChartLayout(line1, defaultColor: .navy)

        
        lineChartEntry.removeAll()
        
        // chart data array 에 데이터 추가
        for i in 0..<expense.count {
            let value = ChartDataEntry(x: Double(i), y: Double(abs(expense[i].amount ?? 0)), data: expense[i])
            lineChartEntry.append(value)
        }
        
        let line2 = LineChartDataSet(entries: lineChartEntry, label: "Expense")
        setChartLayout(line2, defaultColor: .green)
        
        let data = LineChartData()
        data.dataSets = [line1, line2]
        
        lineChartView.data = data
        
    }
    
    func setChartLayout(_ dataSet: LineChartDataSet, defaultColor : UIColor){
        dataSet.colors = [defaultColor]
        dataSet.setCircleColor(defaultColor)
        dataSet.circleHoleColor = defaultColor
        
        dataSet.drawCirclesEnabled = false
        dataSet.drawValuesEnabled = false
        dataSet.lineWidth = 2
        dataSet.mode = .horizontalBezier
        dataSet.circleRadius = 7
        dataSet.drawHorizontalHighlightIndicatorEnabled = false
        dataSet.drawVerticalHighlightIndicatorEnabled = false
    
        let gradientColors = [UIColor(white: 1, alpha: 0.5).cgColor,
                              defaultColor == .navy ? UIColor(217, 217, 217, 1).cgColor : defaultColor.cgColor ]
        let gradient = CGGradient(colorsSpace: nil, colors: gradientColors as CFArray, locations: nil)!

        dataSet.fillAlpha = 1
        dataSet.fill = LinearGradientFill(gradient: gradient, angle: 90)
        dataSet.drawFilledEnabled = true
        
    }
    
    func setConfigure() {
        
        lineChartView.animate(xAxisDuration: animateDuration, easingOption: animateEasing)
        
        [lineChartView, axisStack].forEach {
            self.addSubview($0)
        }
        [axisTextStart, axisTextEnd].forEach {
            axisStack.addArrangedSubview($0)
        }
    }
    
    func setConstraints() {
        lineChartView.snp.makeConstraints { make in
            make.leading.trailing.top.equalToSuperview()
            make.height.equalTo(186)
        }
        axisStack.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(lineChartView.snp.bottom)
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
        
        lineChartView.animate(xAxisDuration: animateDuration, easingOption: animateEasing)
    }
}

extension LineChartView{
    func setMarker (defaultColor : UIColor) {
        
        let marker = BalloonMarker(color: defaultColor,
                                   font: .popinsSemiBold(size: 12),
                                   textColor: .white,
                                   insets: UIEdgeInsets(top: 8, left: 8, bottom: 20, right: 8))
        marker.chartView = self
        marker.minimumSize = CGSize(width: 80, height: 40)
        self.marker = marker
        
    }
}
