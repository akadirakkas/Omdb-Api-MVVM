//
//  UIFont+Extensions.swift
//  Omdb-Api
//
//  Created by kadir on 29.10.2022.
//

import UIKit

extension UIFont {

    static let poppins = Poppins.self

    static func themeFont(ofSize fontSize: CGFloat, weight: UIFont.Weight) -> UIFont {
        switch weight {
        case .regular:
            return poppins.regular.font(size: fontSize)
        case .medium:
            return poppins.medium.font(size: fontSize)
        case .semibold:
            return poppins.semiBold.font(size: fontSize)
        case .bold:
            return poppins.bold.font(size: fontSize)
        default:
            return .systemFont(ofSize: fontSize, weight: weight)
        }
    }

}

enum Poppins: String {

    case regular = "Poppins-Regular"
    case medium = "Poppins-Medium"
    case semiBold = "Poppins-SemiBold"
    case bold = "Poppins-Bold"

    func font(size: CGFloat) -> UIFont {
        return UIFont(name: self.rawValue, size: size) ?? UIFont()
    }

}
