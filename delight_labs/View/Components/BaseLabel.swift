//
//  BaseLabel.swift
//  delight_labs
//
//  Created by Minji Kim on 2023/11/14.
//

import UIKit

class BaseLabel: UILabel {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    private func setup() {
        self.font = .popinsRegular(size: UIFont.labelFontSize)
    }
    
    func setColor(_ color: UIColor){
        self.textColor = color
    }
    
    func setSize(_ size: CGFloat){
        self.font = .systemFont(ofSize: size, weight: .bold)
    }
}

