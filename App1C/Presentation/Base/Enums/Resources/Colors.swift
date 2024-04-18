//
//  Colors.swift
//  App1C
//
//  Created by Станислава on 02.04.2024.
//

import UIKit

enum Colors: String, CaseIterable, Codable, Equatable {
    case darkYellow = "#FBDB04"
    case yellow = "#FBE344"
    case lightYellow = "#fdf7b4"
    case paleYellow = "#ffef8a"//"#fbf39b"
    case lightBlue = "#65A6D1"
    case red = "#d62d20"
    case green = "#a0cb55"
    case darkgreen = "#588b3c"
    case lightGreen = "#d6ee64"
    case orange = "#F7B64B"
    case lightRed = "#fa7c4c"
    case salat = "#d7f961"
    
    var uiColor: UIColor {
        return UIColor(rgb: self.rawValue) ?? .white
    }
}

extension UIColor {
    static func subString(str: String, startIndex: Int, endIndex: Int) -> String {
        let start = str.index(str.startIndex, offsetBy: startIndex)
        let end = str.index(str.startIndex, offsetBy: endIndex)
        let range = start ..< end
        return String(str[range])
    }
    
    convenience init?(rgb: String) {
        let str = rgb.filter { $0 != "#" }
        if str.count != 6 {
            return nil
        }
        
        let redHex = Self.subString(str: str, startIndex: 0, endIndex: 2)
        let greenHex = Self.subString(str: str, startIndex: 2, endIndex: 4)
        let blueHex = Self.subString(str: str, startIndex: 4, endIndex: 6)
        
        if let red = Int(redHex, radix: 16),
           let green = Int(greenHex, radix: 16),
           let blue = Int(blueHex, radix: 16) {
            self.init(
                red: CGFloat(red) / 255.0,
                green: CGFloat(green) / 255.0,
                blue: CGFloat(blue) / 255.0,
                alpha: 1
            )
        } else {
            return nil
        }
    }
}
