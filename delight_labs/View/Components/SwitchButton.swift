//
//  SwitchButton.swift
//  delight_labs
//
//  Created by Minji Kim on 2023/11/15.
//

import Foundation
import UIKit

class SwitchButton : UIButton {
    override open var isSelected: Bool {
        didSet {
//            backgroundColor = isSelected ? .navy : nil
            if isSelected {
                setTitleColor(.white, for: .normal)
                backgroundColor = .navy
            }else {
                setTitleColor(.switchTextDark, for: .normal)
                backgroundColor = nil
            }
        }
    }
}
