// Created by Alkın Çakıralar for OpenAI-Translator in 2.04.2023
// Using Swift 5.0
// You can contact me with a.cakiralar@gmail.com
// Follow me on https://medium.com/@acakiralar
// Send friend request on https://www.linkedin.com/in/alkincakiralar/ 

import SwiftUI

struct MainView: View {
    init() {
        UITabBar.appearance().backgroundColor = UIColor.black
        UITabBar.appearance().unselectedItemTintColor = .init(hex: "202842")
        UITabBar.appearance().barTintColor = .red
    }
    
    @State private var tabSelection = 1

    var body: some View {
        TabView(selection: $tabSelection) {
            HomeView(tabSelection: $tabSelection)
                .tabItem {
                    Label("Home", systemImage: "house")
                }
                .tag(1)
            SettingsView(tabSelection: $tabSelection)
                .tabItem {
                    Label("Settings", systemImage: "gear")
                }
                .tag(2)
        }.tint(.init(hex: 0x4E4CBB))
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
