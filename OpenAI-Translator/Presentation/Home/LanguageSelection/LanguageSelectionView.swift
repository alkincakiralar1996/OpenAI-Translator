// Created by Alkın Çakıralar for OpenAI-Translator in 2.04.2023
// Using Swift 5.0
// You can contact me with a.cakiralar@gmail.com
// Follow me on https://medium.com/@acakiralar
// Send friend request on https://www.linkedin.com/in/alkincakiralar/ 

import SwiftUI

struct LanguageSelectionView: View {
    let selectedLanguage: Language?
    let otherSelectedLanguage: Language?
    let languages: [Language] = getLanguages()
    let onSelectLanguage: (Language) -> Void

    var body: some View {
        VStack {
            ScrollView(showsIndicators: false) {
                LazyVStack {
                    ForEach(languages) { language in
                        if language.id == otherSelectedLanguage?.id {
                            EmptyView()
                        } else {
                            LanguageItemView(language: language, selectedLanguage: selectedLanguage, alignCenter: false) {
                                if language.id == selectedLanguage?.id {
                                    return
                                }
                                
                                onSelectLanguage(language)
                            }
                            .padding(.init(top: 12, leading: 22, bottom: 0, trailing: 22))
                        }
                    }
                }
            }
        }
        .padding(.top, 22)
        .frame(maxWidth: .infinity)
        .frame(maxHeight: .infinity)
        .background(LinearGradient(gradient: Gradient(colors: [.init(hex: 0x1F2642), .init(hex: 0x060912)]), startPoint: .top, endPoint: .bottom))
    }
}

struct LanguageSelectionView_Previews: PreviewProvider {
    static var previews: some View {
        LanguageSelectionView(selectedLanguage: .init(id: -1, name: "", flag: "", localization: ""), otherSelectedLanguage: nil) { _ in
        }
    }
}
