// Created by Alkın Çakıralar for OpenAI-Translator in 3.04.2023
// Using Swift 5.0
// You can contact me with a.cakiralar@gmail.com
// Follow me on https://medium.com/@acakiralar
// Send friend request on https://www.linkedin.com/in/alkincakiralar/ 

import SwiftUI

@MainActor class SettingsViewModel: ObservableObject {
    @AppStorage("OpenAIApiKey") private var openAIApiKey: String = ""
    
    @Published var apiKeyText: String = "" {
        didSet {
            openAIApiKey = apiKeyText
        }
    }
    
    init() {
        apiKeyText = openAIApiKey
    }
}
