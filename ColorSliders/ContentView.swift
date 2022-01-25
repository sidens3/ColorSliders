//
//  ContentView.swift
//  ColorSliders
//
//  Created by Михаил Зиновьев on 25.01.2022.
//

import SwiftUI

struct ContentView: View {
    enum FieldType {
        case redSlider
        case greenSlider
        case blueSlider
    }
    
    @State private var redSliderValue = Double.random(in: 0...255)
    @State private var greenSliderValue = Double.random(in: 0...255)
    @State private var blueSliderValue = Double.random(in: 0...255)
    
    @State private var redSliderTextFieldValue = ""
    @State private var greenSliderTextFieldValue = ""
    @State private var blueSliderTextFieldValue = ""
    
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
                    ColorSliderView(placeholder: $redSliderValue,
                                    textColor: .red, action: {textFieldValue in
                        redSliderTextFieldValue = textFieldValue
                    })
                    
                    ColorSliderView(placeholder: $greenSliderValue,
                                    textColor: .green, action: {textFieldValue in
                        greenSliderTextFieldValue = textFieldValue
                    })
                    
                    ColorSliderView(placeholder: $blueSliderValue,
                                    textColor: .blue, action: {textFieldValue in
                        blueSliderTextFieldValue = textFieldValue
                    })
                    
                }.toolbar {
                    ToolbarItemGroup(placement: .keyboard) {
                        Spacer()
                        Button("Done") {
                            if redSliderTextFieldValue != "" {
                                guard let doubleValue = Double(redSliderTextFieldValue) else { return }
                                redSliderValue = doubleValue
                                redSliderTextFieldValue = ""
                            }
                            
                            if greenSliderTextFieldValue != "" {
                                guard let doubleValue = Double(greenSliderTextFieldValue) else { return }
                                greenSliderValue = doubleValue
                                greenSliderTextFieldValue = ""
                            }
                            
                            if blueSliderTextFieldValue != "" {
                                guard let doubleValue = Double(blueSliderTextFieldValue) else { return }
                                blueSliderValue = doubleValue
                                blueSliderTextFieldValue = ""
                            }
                            
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
    @Binding var placeholder: Double
    @State var userValue: String = ""
    @State private var alertPresented = false
    
    let textColor: Color
    var action: (String) -> Void
    
    var body: some View {
        HStack(spacing: 10) {
            Text("\(lround(placeholder))").foregroundColor(textColor)
                .frame(width: 40, height: 20, alignment: .leading)
            Slider(value: $placeholder, in: 0...255, step: 1)
                .accentColor(textColor)
            TextField("\(lround(placeholder))", text: $userValue)
                .bordered()
                .background()
                .frame(width: 70, height: 20, alignment: .trailing)
                .keyboardType(.numberPad)
                .onChange(of: userValue) { newValue in
                    guard let doubleValue = Double(newValue), doubleValue <= 255 else {
                        userValue = ""
                        alertPresented = true
                        return
                    }
                    
                    action(newValue)
                }
                .alert("Wrong Format", isPresented: $alertPresented, actions: {}) {
                    Text("Enter number from 0..255")
                }
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
