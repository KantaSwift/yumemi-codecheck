//
//  UIColor-extension.swift
//  iOSEngineerCodeCheck
//
//  Created by 上條栞汰 on 2022/09/12.
//  Copyright © 2022 YUMEMI Inc. All rights reserved.
//

import UIKit

extension UIColor {
    static func dynamicColor(light: UIColor, dark: UIColor) -> UIColor {
        return UIColor { (traitCollection:UITraitCollection) -> UIColor in
            if traitCollection.userInterfaceStyle == .dark {
                return dark
            } else {
                return light
            }
        }
    }
    
    static let textColor: UIColor = .dynamicColor(light: .black, dark: .white)
}
