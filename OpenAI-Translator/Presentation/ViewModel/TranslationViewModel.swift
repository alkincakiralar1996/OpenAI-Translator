// Created by Alkın Çakıralar for OpenAI-Translator in 2.04.2023
// Using Swift 5.0
// You can contact me with a.cakiralar@gmail.com
// Follow me on https://medium.com/@acakiralar
// Send friend request on https://www.linkedin.com/in/alkincakiralar/ 

import SwiftUI

@MainActor class TranslationViewModel: ObservableObject {
    @AppStorage("OpenAIApiKey") private var openAIApiKey: String = "" {
        didSet {
            apiKeyAvailability = !openAIApiKey.isEmpty
        }
    }

    @Published var fromText = ""
    @Published var toText = ""
    
    @Published var showToast = false
    @Published var toastText = ""
    
    @Published var isLoading = false
    
    @Published var showLanguageSelectionView = false

    @Published private var isRecording = false
    
    @Published var fromLanguage: Language = getLanguages()[0]
    @Published var toLanguage: Language = getLanguages()[1]
    
    @Published var selectedFromLanguage: Language?
    @Published var selectedToLanguage: Language?
    
    @Published private var speechRecognizer = SpeechRecognizer()
    
    @Published var apiKeyAvailability: Bool = false
    
    private let openAI = OpenAI()
    
    init() {
        setApiKeyAvailability()
    }
    
    func setApiKeyAvailability() {
        apiKeyAvailability = !openAIApiKey.isEmpty
    }
    
    func speakFromText() {
        speechRecognizer.speakWithText(fromText, language: fromLanguage.localization)
    }
    
    func speakToText() {
        speechRecognizer.speakWithText(toText, language: toLanguage.localization)
    }
    
    func copyFromTextToClipBoard() {
        if fromText.isEmpty { return }
        
        UIPasteboard.general.string = fromText
        
        toastText = "Copied to clipboard!"
        showToast.toggle()
    }
    
    func copyToTextToClipBoard() {
        if toText.isEmpty { return }
        
        UIPasteboard.general.string = toText
        
        toastText = "Copied to clipboard!"
        showToast.toggle()
    }
    
    func swapLanguages() {
        swap(&fromLanguage, &toLanguage)
        swap(&fromText, &toText)
    }
    
    func changeFromLanguage() {
        selectedFromLanguage = fromLanguage
        showLanguageSelectionView.toggle()
    }
    
    func changeToLanguage() {
        selectedToLanguage = toLanguage
        showLanguageSelectionView.toggle()
    }
    
    func changeLanguage(from fromLanguage: Language?,to toLanguage: Language?) {
        showLanguageSelectionView.toggle()
        
        if let fromLanguage {
            self.selectedFromLanguage = nil
            self.fromLanguage = fromLanguage
            
            toText = ""
            fromText = ""
        }
        
        if let toLanguage {
            self.selectedToLanguage = nil
            self.toLanguage = toLanguage
            
            toText = ""
            translateText()
        }
    }
    
    func translateText() {
        if fromText.isEmpty { return }
        
        isLoading.toggle()
        
        Task {
            do {
                let result = try await openAI.translateText(fromLanguage: fromLanguage, toLanguage: toLanguage, text: fromText)

                toText = result
                
                isLoading.toggle()
            } catch let err as OpenAI.OpenAIError {
                isLoading.toggle()
                
                toastText = err.message
                showToast.toggle()
                
                toText = ""
            }
        }
    }
}
