//
//  UIApplication+Extensions.swift
//  kalimbaNotes
//
//  Created by Erdi Tunçalp on 2.07.2022.
//

import UIKit

extension UIApplication {

    var currentKeyWindow: UIWindow? {
        /*guard #available(iOS 13.0, *) else { return keyWindow }
        return connectedScenes
            .filter { $0.activationState == .foregroundActive }
            .compactMap { $0 as? UIWindowScene }
            .first?.windows
            .first(where: { $0.isKeyWindow })*/
        return (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.window
    }
}
