//
//  ContentView.swift
//  Calculator+
//
//  Created by Jevon Mao on 7/7/21.
//

import SwiftUI

struct CalculatorButton: Hashable {
    var symbol: String
    var isNumber: Bool {
        Int(symbol) != nil
    }
    var isDoubleWidth: Bool = false
}

enum MathOperation {
    case add
}
struct ContentView: View {
    @State private var buttons: [[CalculatorButton]] = [[.init(symbol: "1"),
                                                 .init(symbol: "2"),
                                                 .init(symbol: "3"),
                                                 .init(symbol: "+")],
                                                [.init(symbol: "4"),
                                                 .init(symbol: "5"),
                                                 .init(symbol: "6"),
                                                 .init(symbol: "−")],
                                                [.init(symbol: "0", isDoubleWidth: true),
                                                 .init(symbol: "."),
                                                 .init(symbol: "=")]]
    @State private var inputText = ""
    @State private var memoryText = ""
    @State private var previousText = ""
    @State private var operation: MathOperation?
    
    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            VStack {
                Text("Previous: \(previousText)")
                Text("Input: \(inputText)")
                Text("Memory: \(memoryText)")
                Text(inputText)
                    .font(.system(size: 85))
                    .fontWeight(.semibold)
                    .frame(maxWidth: .infinity, alignment: .trailing)
                
                Spacer()
                ForEach(buttons, id: \.self){buttonGroup in
                    HStack {
                        ForEach(buttonGroup, id: \.self) {button in
                            Button(action: {
                                if button.isNumber {
                                    if operation != nil && inputText == memoryText {
                                        inputText = ""
                                        inputText.append(button.symbol)
                                        previousText = inputText
                                    }
                                    else {
                                        inputText.append(button.symbol)
                                    }
                                }
                                
                                else {
                                    switch button.symbol {
                                    case "+":
                                        if memoryText.isEmpty && !inputText.isEmpty {
                                            memoryText = inputText
                                            operation = .add
                                        }
                                        else if operation != nil && inputText != memoryText {
                                            previousText = inputText
                                            inputText = String(Int(memoryText)! + Int(inputText)!)
                                            memoryText = inputText

                                        }
                                        
                                    case "=":
                                        if operation == .add {
                                            if !inputText.isEmpty {
                                                if inputText == memoryText {
                                                    inputText = String(Int(previousText)! + Int(inputText)!)
                                                    memoryText = inputText
                                                }
                                                else {
                                                    previousText = memoryText
                                                    inputText = String(Int(memoryText)! + Int(inputText)!)
                                                    memoryText = inputText
                                                }
                                         
                                            }
                                
                                        }
                        
                                    default:
                                       ()
                                    }
                                }
                                
                            }) {
                                Text(button.symbol)
                                    .font(.largeTitle)
                                    .fontWeight(.bold)
                                    .foregroundColor(.white)
                                    .frame(width: button.isDoubleWidth ? 218 : 100, height: 100)
                                    .background(button.isNumber ? Color.gray.opacity(0.5) : Color.orange)
                                    .clipShape(Capsule())
                                    .padding(5)
                            }
                            
                        }
                    }
                    
                }
            }.foregroundColor(.white)

        }

   
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
