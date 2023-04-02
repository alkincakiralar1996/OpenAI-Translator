// Created by Alkın Çakıralar for OpenAI-Translator in 2.04.2023
// Using Swift 5.0
// You can contact me with a.cakiralar@gmail.com
// Follow me on https://medium.com/@acakiralar
// Send friend request on https://www.linkedin.com/in/alkincakiralar/ 

import OpenAIKit
import AsyncHTTPClient
import SwiftUI

class OpenAI {
    @AppStorage("OpenAIApiKey") private var openAIApiKey: String = ""

    enum OpenAIError: Error {
        case EmptyResult
        case ApiKeyNotValid
        case UnExpectedError
        
        var message: String {
            switch self {
                case .EmptyResult:
                    return "AI couldn't translate it"
                case .ApiKeyNotValid:
                    return "Please enter your api key"
                case .UnExpectedError:
                    return "UnExcpectedError Occured, please check your api key"
            }
        }
    }
    
    func translateText(fromLanguage: Language, toLanguage: Language, text: String) async throws -> String {
        if openAIApiKey.isEmpty {
            throw OpenAIError.ApiKeyNotValid
        }
        
        let httpClient = HTTPClient(eventLoopGroupProvider: .createNew)
        
        defer {
            try? httpClient.syncShutdown()
        }
        
        let configuration = Configuration(apiKey: openAIApiKey)
        
        let openAIClient = OpenAIKit.Client(httpClient: httpClient, configuration: configuration)
        
        let prompText = "Translate the following from \(fromLanguage.name) to \(toLanguage.name) \(text)"
        
        do {
            let completion = try await openAIClient.completions.create(
                model: Model.GPT3.textDavinci003,
                prompts: [prompText],
                temperature: 0.3
            ).choices.first?.text
            
            guard let completion else {
                throw OpenAIError.EmptyResult
            }
            
            return completion.replacingOccurrences(of: "\n", with: "")
        } catch {
            throw OpenAIError.UnExpectedError
        }
    }
}
