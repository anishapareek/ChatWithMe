//
//  ContentView.swift
//  ChatWithMe
//
//  Created by Anisha Pareek
//

import SwiftUI

struct ContentView: View {
    @State private var userMessage: String = ""
    @State private var chatMessages: [ChatMessage] = []

    var body: some View {
        VStack {
            List(chatMessages) { message in
                HStack {
                    if message.isUser {
                        Spacer()
                        Text(message.text)
                            .padding()
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(8)
                    } else {
                        Text(message.text)
                            .padding()
                            .background(Color.gray)
                            .foregroundColor(.black)
                            .cornerRadius(8)
                        Spacer()
                    }
                }
            }

            HStack {
                TextField("Enter your message", text: $userMessage)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()

                Button(action: sendMessage) {
                    Text("Send")
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }
                .disabled(userMessage.isEmpty)
            }
            .padding()
        }
        .onTapGesture {
            hideKeyboard()
        }
    }

    func sendMessage() {
        let newMessage = ChatMessage(text: userMessage, isUser: true)
        chatMessages.append(newMessage)
        userMessage = ""

        CohereAPI.sendMessage(message: newMessage.text) { response in
            if let responseMessage = response {
                let botMessage = ChatMessage(text: responseMessage, isUser: false)
                chatMessages.append(botMessage)
            }
        }
    }
}

struct ChatMessage: Identifiable {
    let id = UUID()
    let text: String
    let isUser: Bool
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

extension View {
    func hideKeyboard() {
        let resign = #selector(UIResponder.resignFirstResponder)
        UIApplication.shared.sendAction(resign, to: nil, from: nil, for: nil)
    }
}

