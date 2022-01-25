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
    
    @FocusState var isInputActive: Bool
    
    var body: some View {
        ZStack {
            Color(uiColor: .systemGray3)
                .ignoresSafeArea()
            VStack(spacing: 60) {
                UserColorView(cgColor: CGColor(red: redSliderValue / 255,
                                               green: greenSliderValue / 255,
                                               blue: blueSliderValue / 255,
                                               alpha: 1))
                VStack(spacing: 20) {
                    ColorSliderView(value: $redSliderValue,
                                    textColor: .red, action: {textFieldValue in
                        print("$redSliderValue changed \(textFieldValue)")
                        checkRedTextField(value: textFieldValue)
                    })
                    
                    ColorSliderView(value: $greenSliderValue,
                                    textColor: .green, action: {textFieldValue in
                        print("$greenSliderValue changed \(textFieldValue)")
                    })
                    
                    ColorSliderView(value: $blueSliderValue,
                                    textColor: .blue, action: {textFieldValue in
                        print("$blueSliderValue changed \(textFieldValue)")
                    })
                    
                }.toolbar {
                    ToolbarItemGroup(placement: .keyboard) {
                        Spacer()
                        Button("Done") {
                            print("Clicked")
                            UIApplication.shared.endEditing()
                        }
                    }
                }
                
                Spacer()
            }
            .padding()
        }
    }
    
    private func checkRedTextField(value: String) {
        guard let newValue = Double(value) else { return }
        redSliderValue = newValue
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct ColorSliderView: View {
    @Binding var value: Double
    @State var userValue: String = ""
    
    @State private var alertPresented = false
    
    let textColor: Color
    var action: (String) -> Void
    //    let action: (String) -> Void
    
    
    
    var body: some View {
        HStack(spacing: 10) {
            Text("\(lround(value))").foregroundColor(textColor)
                .frame(width: 40, height: 20, alignment: .leading)
            Slider(value: $value, in: 0...255, step: 1)
            TextField("\(lround(value))", text: $userValue)
                .bordered()
                .background()
                .frame(width: 70, height: 20, alignment: .trailing)
                .keyboardType(.numberPad)
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
