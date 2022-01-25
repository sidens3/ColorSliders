//
//  View+Extensions.swift
//  ColorSliders
//
//  Created by Михаил Зиновьев on 25.01.2022.
//

import SwiftUI

extension View {
    func frame(size: CGSize) -> some View {
        modifier(FrameFromSize(size: size))
    }
    
//    func cgColor(color: CGColor) -> some View {
//        modifier(ColorFromCGColor(cgColor: color))
//    }
}

struct FrameFromSize: ViewModifier {
    let size: CGSize
    func body(content: Content) -> some View {
        content
            .frame(width: size.width, height: size.height)
    }
}
//
//struct ColorFromCGColor: ViewModifier {
//    let cgColor: CGColor
//    func body(content: Content) -> some View {
//        content
//            .foregroundColor(Color(cgColor))
//    }
//}
