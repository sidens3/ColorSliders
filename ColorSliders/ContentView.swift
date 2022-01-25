//
//  ContentView.swift
//  ColorSliders
//
//  Created by Михаил Зиновьев on 25.01.2022.
//

import SwiftUI

struct ContentView: View {
    @State private var redSliderValue = Double.random(in: 0...255)
    @State private var greenSliderValue = Double.random(in: 0...255)
    @State private var blueSliderValue = Double.random(in: 0...255)
    
    var body: some View {
        ZStack {
            Color(uiColor: .systemGray3)
                .ignoresSafeArea()
            VStack(spacing: 20) {
                UserColorView(cgColor: CGColor(red: redSliderValue / 255,
                                               green: greenSliderValue / 255,
                                               blue: blueSliderValue / 255,
                                               alpha: 1))
                ColorSliderView(value: $redSliderValue, textColor: .red)
                ColorSliderView(value: $greenSliderValue, textColor: .green)
                ColorSliderView(value: $blueSliderValue, textColor: .blue)

                Spacer()
            }
            .padding()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct ColorSliderView: View {
    @Binding var value: Double
    
    @State private var displayedValue = "0"
    let textColor: Color
    
    var body: some View {
        HStack(spacing: 10) {
            Text("\(lround(value))").foregroundColor(textColor)
            Slider(value: $value, in: 0...255, step: 1)
            Text("\(lround(value))").foregroundColor(textColor)
        }
    }
}

struct UserColorView: View {

    let cgColor: CGColor
    let size = CGSize(width: 0.8 * UIScreen.main.bounds.width,
                      height: 0.15 * UIScreen.main.bounds.height)

    var body: some View {
        RoundedRectangle(cornerRadius: 16.0)
            .frame(size: size)
            .foregroundColor(Color(cgColor: cgColor))
            .overlay(RoundedRectangle(cornerRadius: 16.0).stroke(Color.white, lineWidth: 4))
    }
}

struct BorderedViewModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding(EdgeInsets(top: 8, leading: 16, bottom: 8, trailing: 16))
            .overlay(
                RoundedRectangle(cornerRadius: 4)
                    .stroke(lineWidth: 2)
                    .foregroundColor(.blue)
            )
            .shadow(color: Color.gray.opacity(0.4), radius: 3, x: 1, y: 2)
    }
}

extension TextField {
    func bordered() -> some View {
        ModifiedContent(content: self, modifier: BorderedViewModifier())
    }
}
