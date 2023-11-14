//
//  BaseStyle.swift
//  delight_labs
//
//  Created by Minji Kim on 2023/11/13.
//

import Foundation
import UIKit

extension UIColor {
    convenience init(_ red: CGFloat,_ green: CGFloat,_ blue: CGFloat,_ alpha: CGFloat = 1) {
        self.init(
            red: red / 255.0,
            green: green / 255.0,
            blue: blue / 255.0,
            alpha: alpha
        )
    }
    
    static let navy = UIColor(54, 48, 98, 1)
    static let green = UIColor(91, 218, 164, 1)
    static let lightGray = UIColor(245, 245, 245, 1)
    static let switchTextDark = UIColor(107, 107, 107, 1)
    static let switchTextLight = UIColor(255, 255, 255, 1)
    static let transactionLight = UIColor(189, 189, 189, 1)
    static let transactionImageColor = UIColor(226, 226, 226, 1)
    static let transactionDescriptionColor = UIColor(107, 107, 107, 1)
}

extension UIImage {
    func createSelectionIndicator(color: UIColor, size: CGSize, lineWidth: CGFloat) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(size, false, scale)
        color.setFill()
        let cornerRadius :CGFloat = 10
        let rect = CGRect(origin: .zero, size: size)
        UIBezierPath(roundedRect: rect, cornerRadius: cornerRadius).addClip()
        draw(in: rect)
        let fill = CGRectMake(0, size.height - lineWidth, size.width, lineWidth)
        UIBezierPath(roundedRect: fill, byRoundingCorners: [.topLeft, .topRight], cornerRadii: CGSize(width: 4.0, height: 4.0)).addClip()
        UIRectFill(fill)
        
        guard let image = UIGraphicsGetImageFromCurrentImageContext() else {
            return UIImage()
        }
        
        UIGraphicsEndImageContext()
        
        return image
    }
    func rotate() -> UIImage {
        UIGraphicsBeginImageContextWithOptions(size, false, scale)
        let context = UIGraphicsGetCurrentContext()!
        context.translateBy(x: size.width, y: size.height)
        context.scaleBy(x: 1, y: -1)
        context.draw(cgImage!, in: CGRect(origin:CGPoint.zero, size: size))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage ?? UIImage()
    }
    
    func imageDownMirror() -> UIImage {
        guard let cgImage = cgImage else { return self }
        return UIImage(cgImage: cgImage, scale: scale, orientation: .downMirrored)
    }
}

extension UIFont {
    static func popinsRegular(size : CGFloat? = nil) -> UIFont {
        let font = UIFont(name: "Poppins-Regular", size: size ?? UIFont.labelFontSize) ?? UIFont()
        return font
    }
    
    static func popinsBold(size : CGFloat? = nil) -> UIFont {
        let font = UIFont(name: "Poppins-Bold", size: size ?? UIFont.labelFontSize)!
        return font
    }
    
    static func popinsSemiBold(size : CGFloat? = nil) -> UIFont {
        let font = UIFont(name: "Poppins-SemiBold", size: size ?? UIFont.labelFontSize)!
        return font
    }
}

extension String {
    func toDate(_ format : String? = nil) -> Date? { //"yyyy-MM-dd HH:mm:ss"
        let dateFormatter = DateFormatter()
        if let format {
            dateFormatter.dateFormat = format
        }else {
            dateFormatter.dateFormat =  "yyyy-MM-dd'T'HH:mm:ssZ"
        }
        dateFormatter.timeZone = TimeZone(identifier: "UTC")
        if let date = dateFormatter.date(from: self) {
            return date
        } else {
            return nil
        }
    }
}

extension Date {
    
    public func formatted(_ format: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.timeZone = TimeZone(identifier: "UTC")
        
        return formatter.string(from: self)
    }
    
    func lastDayofMonth() -> Int {
        let cal = Calendar.current
        let components = cal.dateComponents([.year, .month], from: Date())
        guard let y = components.year, let m = components.month else { return 0 }

        var comps = DateComponents(calendar: cal, year: y, month: m)
        comps.setValue(m + 1, for: .month)
        comps.setValue(0, for: .day)
        let date = cal.date(from: comps)!
        return cal.component(.day, from: date)
    }
}

