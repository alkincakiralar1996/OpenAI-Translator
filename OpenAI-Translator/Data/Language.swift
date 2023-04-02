// Created by Alkın Çakıralar for OpenAI-Translator in 2.04.2023
// Using Swift 5.0
// You can contact me with a.cakiralar@gmail.com
// Follow me on https://medium.com/@acakiralar
// Send friend request on https://www.linkedin.com/in/alkincakiralar/

import Foundation

struct Language: Identifiable {
    let id: Int
    let name: String
    let flag: String
    let localization: String
}

func getLanguages() -> [Language] {
    return [
        .init(id: 0, name: "English", flag: "https://upload.wikimedia.org/wikipedia/commons/thumb/0/0b/English_language.svg/90px-English_language.svg.png", localization: "en-US"),
        .init(id: 1, name: "Turkish", flag: "https://upload.wikimedia.org/wikipedia/commons/thumb/b/b4/Flag_of_Turkey.svg/90px-Flag_of_Turkey.svg.png", localization: "tr"),
        .init(id: 2, name: "German", flag: "https://upload.wikimedia.org/wikipedia/commons/thumb/b/ba/Flag_of_Germany.svg/90px-Flag_of_Germany.svg.png", localization: "de"),
        .init(id: 3, name: "Romanian", flag: "https://upload.wikimedia.org/wikipedia/commons/thumb/7/73/Flag_of_Romania.svg/90px-Flag_of_Romania.svg.png", localization: "ro"),
        .init(id: 4, name: "Polish", flag: "https://upload.wikimedia.org/wikipedia/commons/thumb/1/12/Flag_of_Poland.svg/90px-Flag_of_Poland.svg.png", localization: "pl"),
        .init(id: 5, name: "Portuguese", flag: "https://upload.wikimedia.org/wikipedia/commons/thumb/3/31/Flag_of_Portuguese_language_%28PT-BR%29.svg/90px-Flag_of_Portuguese_language_%28PT-BR%29.svg.png", localization: "pt"),
        .init(id: 6, name: "French", flag: "https://upload.wikimedia.org/wikipedia/commons/thumb/c/c3/Flag_of_France.svg/90px-Flag_of_France.svg.png", localization: "fr"),
        .init(id: 7, name: "Spanish", flag: "https://upload.wikimedia.org/wikipedia/commons/thumb/4/49/Flag_of_Spanish_language_%28ES-MX%29.svg/90px-Flag_of_Spanish_language_%28ES-MX%29.svg.png", localization: "es"),
    ]
}
