// Created by Alkın Çakıralar for OpenAI-Translator in 2.04.2023
// Using Swift 5.0
// You can contact me with a.cakiralar@gmail.com
// Follow me on https://medium.com/@acakiralar
// Send friend request on https://www.linkedin.com/in/alkincakiralar/

import AlertToast
import SwiftUI

struct HomeView: View {
    @StateObject var viewModel = TranslationViewModel()

    @FocusState var isInputActive: Bool
    
    @Binding var tabSelection: Int

    var body: some View {
        VStack {
            VStack(spacing: 26) {
                if !viewModel.apiKeyAvailability {
                    Text("Please set your Open AI api key to be able to use translate")
                        .font(.system(size: 24))
                        .fontWeight(.bold)
                        .lineSpacing(5)
                        .foregroundColor(.white)
                    Button {
                        tabSelection = 2
                    } label: {
                        Text("Set API Key")
                            .font(.system(size: 16))
                            .foregroundColor(.white)
                            .fontWeight(.bold)
                            .padding()
                            .background(
                                RoundedRectangle(cornerRadius: 20, style: .continuous).fill(Color(hex: 0x0A0D19).opacity(0.4))
                            )
                            .overlay(
                                RoundedRectangle(cornerRadius: 20)
                                    .stroke(Color(hex: 0x6E4FAF), lineWidth: 2)
                            )
                    }
                } else {
                    ZStack {
                        HStack(spacing: 18) {
                            LanguageItemView(language: viewModel.fromLanguage) {
                                viewModel.changeFromLanguage()
                            }
                            LanguageItemView(language: viewModel.toLanguage) {
                                viewModel.changeToLanguage()
                            }
                        }
                        Button {
                            viewModel.swapLanguages()
                        } label: {
                            Image("swap")
                                .resizable()
                                .frame(width: 50, height: 50)
                                .rotationEffect(.degrees(-90))
                        }.padding(.leading, 10)
                    }
                    TranslatorCardView(
                        language: viewModel.fromLanguage,
                        onSoundClicked: {
                            viewModel.speakFromText()
                        },
                        onClipBoardClicked: {
                            viewModel.copyFromTextToClipBoard()
                        },
                        onTranslate: {
                            viewModel.translateText()
                        },
                        text: $viewModel.fromText
                    )
                    if !viewModel.toText.isEmpty {
                        TranslatorCardView(
                            language: viewModel.toLanguage,
                            onSoundClicked: {
                                viewModel.speakToText()
                            },
                            onClipBoardClicked: {
                                viewModel.copyToTextToClipBoard()
                            },
                            onTranslate: {},
                            disableMicrophone: true,
                            disableEditor: true,
                            text: $viewModel.toText
                        )
                    }
                }
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
        .sheet(isPresented: $viewModel.showLanguageSelectionView, onDismiss: {
            viewModel.selectedFromLanguage = nil
            viewModel.selectedToLanguage = nil
        }) {
            if let fromLanguage = viewModel.selectedFromLanguage {
                LanguageSelectionView(selectedLanguage: fromLanguage, otherSelectedLanguage: viewModel.toLanguage) { language in
                    viewModel.changeLanguage(from: language, to: nil)
                }
            }
            if let toLanguage = viewModel.selectedToLanguage {
                LanguageSelectionView(selectedLanguage: toLanguage, otherSelectedLanguage: viewModel.fromLanguage) { language in
                    viewModel.changeLanguage(from: nil, to: language)
                }
            }
        }
        .toast(isPresenting: $viewModel.showToast) {
            AlertToast(type: .regular, title: viewModel.toastText)
        }
        .toast(isPresenting: $viewModel.isLoading, alert: {
            AlertToast(type: .loading)
        })
        .onChange(of: viewModel.fromText) { newValue in
            if newValue.isEmpty {
                withAnimation {
                    viewModel.toText = ""
                }
            }
        }
        .onAppear(perform: {
            viewModel.setApiKeyAvailability()
        })
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(tabSelection: .constant(0))
    }
}
