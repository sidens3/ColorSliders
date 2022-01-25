//
//  UIApplication+Extensions.swift
//  ColorSliders
//
//  Created by Михаил Зиновьев on 25.01.2022.
//

import SwiftUI

extension UIApplication {
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
