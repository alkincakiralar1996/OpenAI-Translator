// Created by Alkın Çakıralar for OpenAI-Translator in 2.04.2023
// Using Swift 5.0
// You can contact me with a.cakiralar@gmail.com
// Follow me on https://medium.com/@acakiralar
// Send friend request on https://www.linkedin.com/in/alkincakiralar/ 

import SwiftUI

struct TranslatorCardView: View {
    let language: Language
    let onSoundClicked: () -> Void
    let onClipBoardClicked: () -> Void
    let onTranslate: () -> Void

    var disableMicrophone: Bool = false
    var disableEditor: Bool = false

    @Binding var text: String
    @FocusState var isInputActive: Bool

    var body: some View {
        VStack {
            HStack(spacing: 12) {
                Button {
                    onSoundClicked()
                } label: {
                    Image("sound")
                }
                Text(language.name)
                    .foregroundColor(.white)
                    .font(.system(size: 20))
                    .fontWeight(.regular)
                Spacer()
                Button {
                    onClipBoardClicked()
                } label: {
                    Image("clipboard")
                }
            }
            Spacer().frame(height: 18)
            if disableEditor {
                HStack {
                    Text($text.wrappedValue)
                        .foregroundColor(Color.white)
                        .font(.system(size: 22))
                        .fontWeight(.regular)
                    Spacer()
                }
            } else {
                TextField(
                    "free_form",
                    text: $text,
                    prompt: Text("Enter text"),
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
                        Button("Close & Translate") {
                            isInputActive = false
                            onTranslate()
                        }
                    }
                }
            }
        }
        .padding(16)
        .frame(maxWidth: .infinity)
        .background(
            RoundedRectangle(cornerRadius: 24, style: .continuous).fill(Color(hex: 0x0A0D19).opacity(0.7))
        )
    }
}


struct Ripple: ViewModifier {
    // MARK: Lifecycle

    init(rippleColor: Color) {
        self.color = rippleColor
    }

    // MARK: Internal

    let color: Color

    @State private var scale: CGFloat = 0.5
    
    @State private var animationPosition: CGFloat = 0.0
    @State private var x: CGFloat = 0.0
    @State private var y: CGFloat = 0.0
    
    @State private var opacityFraction: CGFloat = 0.0
    
    let timeInterval: TimeInterval = 0.5
    
    func body(content: Content) -> some View {
        GeometryReader { geometry in
            ZStack {
                Rectangle()
                    .foregroundColor(.gray.opacity(0.05))
                Circle()
                    .foregroundColor(color)
                    .opacity(0.2*opacityFraction)
                    .scaleEffect(scale)
                    .offset(x: x, y: y)
                content
            }
            .onTapGesture(perform: { location in
                x = location.x-geometry.size.width/2
                y = location.y-geometry.size.height/2
                opacityFraction = 1.0
                withAnimation(.linear(duration: timeInterval)) {
                    scale = 3.0*(max(geometry.size.height, geometry.size.width)/min(geometry.size.height, geometry.size.width))
                    opacityFraction = 0.0
                    DispatchQueue.main.asyncAfter(deadline: .now() + timeInterval) {
                        scale = 1.0
                        opacityFraction = 0.0
                    }
                }
            })
            .clipped()
        }
    }
}

extension View {
    func rippleEffect(rippleColor: Color = .accentColor.opacity(0.5)) -> some View {
        modifier(Ripple(rippleColor: rippleColor))
    }
}
