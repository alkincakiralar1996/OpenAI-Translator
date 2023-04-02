// Created by Alkın Çakıralar for OpenAI-Translator in 2.04.2023
// Using Swift 5.0
// You can contact me with a.cakiralar@gmail.com
// Follow me on https://medium.com/@acakiralar
// Send friend request on https://www.linkedin.com/in/alkincakiralar/ 

import SwiftUI

struct SettingsView: View {
    @StateObject var viewModel = SettingsViewModel()

    @FocusState var isInputActive: Bool
    
    @Binding var tabSelection: Int
    
    var body: some View {
        VStack {
            VStack(alignment: .leading, spacing: 26) {
                HStack {
                    Text("Settings")
                        .font(.system(size: 24))
                        .fontWeight(.bold)
                        .lineSpacing(5)
                        .foregroundColor(.white)
                    Spacer()
                }
                VStack {
                    HStack(spacing: 12) {
                        Text("API Key")
                            .foregroundColor(.white)
                            .font(.system(size: 20))
                            .fontWeight(.regular)
                        Spacer()
                    }
                    Spacer().frame(height: 18)
                    TextField(
                        "free_form",
                        text: $viewModel.apiKeyText,
                        prompt: Text("Enter Key"),
                        axis: .vertical
                    )
                    .lineSpacing(10.0)
                    .lineLimit(5 ... 10)
                    .foregroundColor(Color.white)
                    .font(.system(size: 22))
                    .fontWeight(.regular)
                    .focused($isInputActive)
                    .toolbar {
                        ToolbarItemGroup(placement: .keyboard) {
                            Button("Close & Save") {
                                isInputActive = false
                            }
                        }
                    }
                }
                .padding(16)
                .frame(maxWidth: .infinity)
                .background(
                    RoundedRectangle(cornerRadius: 24, style: .continuous).fill(Color(hex: 0x0A0D19).opacity(0.7))
                )
                Spacer()
            }
            .padding(.init(top: 24, leading: 16, bottom: 16, trailing: 16))
            .frame(
                maxWidth: .infinity,
                maxHeight: .infinity
            )
            .background(LinearGradient(gradient: Gradient(colors: [.init(hex: 0x1F2642), .init(hex: 0x060912)]), startPoint: .top, endPoint: .bottom))
            .cornerRadius(40)
        }
        .background(.black)
        .ignoresSafeArea(.keyboard)
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView(tabSelection: .constant(0))
    }
}
