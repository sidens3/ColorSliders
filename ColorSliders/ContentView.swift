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
            UserColorView()
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
            Text("\(lround(value))").foregroundColor(textColor)
            Slider(value: $value, in: 0...255, step: 1)
            Text("\(lround(value))").foregroundColor(textColor)
        }
    }
}

//struct UserColorView: View {
//    @Binding var color: Color
//
//    var body: some View {
//        RoundedRectangle
//            .frame(self)
//    }
//}

//struct UserColorView: View {
//    @Binding var color: Color
//
//    let size = CGSize(width: 250, height: 250)
//
//    var body: some View {
//        Image(systemName: "table")
//            .resizable()
//            .frame(size: size)
//            .background(color)
//            .clipShape(Circle())
//            .overlay(Circle().stroke(Color.red, lineWidth: 8))
//            .foregroundColor(.red)
//    }
//}

struct UserColorView: View {

    let cgColor: CGColor = CGColor(red: 0.0, green: 1.0, blue: 1.0, alpha: 1)

    var body: some View {
        RoundedRectangle(cornerRadius: 16.0)
            .frame(width: 300, height: 100)
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
