// Created by Alkın Çakıralar for OpenAI-Translator in 2.04.2023
// Using Swift 5.0
// You can contact me with a.cakiralar@gmail.com
// Follow me on https://medium.com/@acakiralar
// Send friend request on https://www.linkedin.com/in/alkincakiralar/ 

import SwiftUI
import CachedAsyncImage

struct LanguageItemView: View {
    let language: Language
    var selectedLanguage: Language? = nil
    var alignCenter: Bool = true
    let onClick: () -> Void

    var body: some View {
        Button {
            onClick()
        } label: {
            HStack(alignment: .center, spacing: 18) {
                CachedAsyncImage(url: URL(string: language.flag)) { image in
                    image
                        .resizable()
                        .cornerRadius(10)
                } placeholder: {
                    Color.gray
                }
                .frame(width: 45, height: 30)
                Text(language.name).foregroundColor(.white).font(.system(size: 16)).fontWeight(.medium)
                    .lineLimit(1)
                if !alignCenter {
                    Spacer()
                }
                if selectedLanguage?.id == language.id {
                    Label("", systemImage: "checkmark.seal.fill")
                }
            }
            .padding(12)
            .padding(.leading, !alignCenter ? 12 : 0)
            .frame(maxWidth: .infinity)
            .background(
                RoundedRectangle(cornerRadius: 20, style: .continuous).fill(Color(hex: 0x0A0D19).opacity(0.4))
            )
            .overlay(
                RoundedRectangle(cornerRadius: 20)
                    .stroke(Color(hex: 0x6E4FAF), lineWidth: 2)
            )
        }
    }
}
