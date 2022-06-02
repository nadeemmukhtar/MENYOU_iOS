//
//  TextView.swift
//  MENYOU
//
//  Created by Appcrates_Dev on 7/20/20.
//  Copyright © 2020 Appcrates_Dev. All rights reserved.
//

import SwiftUI

struct TextView: UIViewRepresentable {
    typealias UIViewType = UITextView

    var placeholderText: String = ""
    var isFirstResponder: Bool = false
    var returnKeyClosesKeyboard: Bool = false
    var autoCap: Bool = true
    var autoCorrect: Bool = true
    var spellCheck: Bool = true
    @Binding var text: String
    @Binding var didEditing: Bool
    var blackText: Bool = true
    var largeText: Bool = false
    var textColor: UIColor = .black

    func makeUIView(context: UIViewRepresentableContext<TextView>) -> UITextView {
        let textView = UITextView()

        textView.textContainer.lineFragmentPadding = 0
        textView.textContainerInset = .zero
        textView.font = UIFont.systemFont(ofSize: largeText ? 18 : 16)
        textView.backgroundColor = UIColor.clear
        textView.returnKeyType = .done
        textView.autocapitalizationType = autoCap ? .sentences : .none
        textView.autocorrectionType = autoCorrect ? .default : .no
        textView.spellCheckingType = spellCheck ? .default : .no

        textView.text = placeholderText
        textView.textColor = .placeholderText

        return textView
    }

    func updateUIView(_ uiView: UITextView, context: UIViewRepresentableContext<TextView>) {
        if text != "" || uiView.textColor == textColor {
            uiView.text = text
            uiView.textColor = textColor
        }

        if isFirstResponder && !context.coordinator.didBecomeFirstResponder {
            uiView.becomeFirstResponder()
            context.coordinator.didBecomeFirstResponder = true
        }

        uiView.delegate = context.coordinator
    }

    func frame(numLines: CGFloat) -> some View {
        let height = UIFont.systemFont(ofSize: 20).lineHeight * numLines
        return self.frame(height: height)
    }

    func makeCoordinator() -> TextView.Coordinator {
        Coordinator(self)
    }

    class Coordinator: NSObject, UITextViewDelegate {
        var parent: TextView
        var didBecomeFirstResponder = false

        init(_ parent: TextView) {
            self.parent = parent
        }

        func textViewDidChange(_ textView: UITextView) {
            parent.text = textView.text
        }

        func textViewDidBeginEditing(_ textView: UITextView) {
            parent.didEditing = true
            if textView.textColor == .placeholderText {
                textView.text = ""
                textView.textColor = .label
            }
        }

        func textViewDidEndEditing(_ textView: UITextView) {
            parent.didEditing = false
            if textView.text == "" {
                textView.text = parent.placeholderText
                textView.textColor = .placeholderText
            }
        }

        func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
            if text == "\n" && parent.returnKeyClosesKeyboard {
                textView.resignFirstResponder()
                return false
            }
            
            let currentText = textView.text ?? ""
            guard let stringRange = Range(range, in: currentText) else { return false }
            let updatedText = currentText.replacingCharacters(in: stringRange, with: text)
            return updatedText.count <= 44
        }
    }
}
