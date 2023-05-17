//
//  UIColor+PageVC.swift
//  PageVCTutorial
//
//  Created by 조기열 on 2023/05/03.
//

import Foundation
import UIKit

extension UIColor {
    static var random: UIColor {
        return UIColor(
            red:   .random(in: 0...1),
            green: .random(in: 0...1),
            blue:  .random(in: 0...1),
            alpha: 1.0
        )
    }
}
