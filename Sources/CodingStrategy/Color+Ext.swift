//
//  Color+Ext.swift
//  
//
//  Created by andrey.antropov on 18.10.2021.
//

#if !os(macOS)
import UIKit

extension UIColor {
    convenience init(hex: Int, alpha: CGFloat = 1) {
        let red = CGFloat((hex >> 16) & 0xFF) / 255.0
        let green = CGFloat((hex >> 8) & 0xFF) / 255.0
        let blue = CGFloat((hex >> 0) & 0xFF) / 255.0
        self.init(red: red, green: green, blue: blue, alpha: alpha)
    }
    
    var components: (CGFloat, CGFloat, CGFloat, CGFloat) {
        guard let components = cgColor.components else { return (0, 0, 0, 1) }
        if cgColor.numberOfComponents == 2 {
            return (components[0], components[0], components[0], components[1])
        } else {
            return (components[0], components[1], components[2], components[3])
        }
    }
}
#endif
