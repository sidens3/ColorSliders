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
    
    @State private var userName = ""
    @State private var displayedName = ""
    @State private var alertPresented = false
    
    var body: some View {
        VStack(spacing: 40) {
            Text("\(lround(redSliderValue))")
                .font(.largeTitle)
            UserNameView(name: displayedName)
            ColorSliderView(value: $redSliderValue, textColor: .red)
            ColorSliderView(value: $greenSliderValue, textColor: .green)
            ColorSliderView(value: $blueSliderValue, textColor: .blue)
            TextField("Enter your name", text: $userName)
                .bordered()

            Spacer()
        }
        .padding()
    }
    
    private func checkUserName() {
        if let _ = Double(userName) {
            userName = ""
            alertPresented.toggle()
            return
        }
        displayedName = userName
        userName = ""
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
        HStack {
            Text("0").foregroundColor(textColor)
            Slider(value: $value, in: 0...255, step: 1)
//            TextField($value, text: $value)
            Text("255").foregroundColor(.red)
        }
    }
}

struct UserNameView: View {
    let name: String
    
    var body: some View {
        HStack {
            HStack(alignment: .firstTextBaseline) {
                Text("USER NAME: ").frame(height: 60)
                Text("\(name)")
                    .font(.largeTitle)
            }
            Spacer()
        }
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
