//
//  DetailView.swift
//

import UIKit
import OpenAI
import SwiftUI

/// 詳細画面
struct DetailView: View {

    @State var inputText: String = "" // 入力テキスト
    @FocusState private var isFocused: Bool // フォーカス状態
    @State private var showsModelSelectionSheet = false // モデル選択シート表示フラグ
    @State private var selectedChatModel: Model = .gpt3_5Turbo0613 // 選択中のモデル
    private let availableChatModels: [Model] = [.gpt3_5Turbo0613, .gpt4_0613] // 利用可能なモデル一覧

    let conversation: Conversation // 会話
    let error: Error? // エラー
    let sendMessage: (String, Model) -> Void // メッセージ送信

    var body: some View {
        NavigationStack {
            ScrollViewReader { scrollViewProxy in
                VStack {
                    List {
                        // 会話
                        ForEach(conversation.messages) { message in
                            ChatBubbleView(message: message)
                        }
                        .listRowSeparator(.hidden)
                    }
                    .listStyle(.plain)
                    .animation(.default, value: conversation.messages)

                    if let error = error {
                        // エラー表示
                        errorMessage(error: error)
                    }

                    inputBar(scrollViewProxy: scrollViewProxy)
                }
                .navigationTitle("Chat")
                .safeAreaInset(edge: .top) {
                    HStack {
                        Text(
                            "Model: \(selectedChatModel)"
                        )
                        .font(.caption)
                        .foregroundColor(.secondary)
                        Spacer()
                    }
                    .padding(.horizontal, 16)
                    .padding(.vertical, 8)
                }
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button(action: {
                            showsModelSelectionSheet.toggle()
                        }) {
                            Image(systemName: "brain")
                        }
                    }
                }
                .confirmationDialog(
                    "Select model",
                    isPresented: $showsModelSelectionSheet,
                    titleVisibility: .visible,
                    actions: {
                        ForEach(availableChatModels, id: \.self) { model in
                            Button {
                                selectedChatModel = model
                            } label: {
                                Text(model)
                            }
                        }

                        Button("Cancel", role: .cancel) {
                            showsModelSelectionSheet = false
                        }
                    },
                    message: {
                        Text("Select the model to use for chat.")
                    }
                )
            }
        }
    }

    @ViewBuilder private func errorMessage(error: Error) -> some View {
        Text(
            error.localizedDescription
        )
        .font(.caption)
        .foregroundColor({
            #if os(iOS)
            return Color(uiColor: .systemRed)
            #elseif os(macOS)
            return Color(.systemRed)
            #endif
        }())
        .padding(.horizontal)
    }

    @ViewBuilder private func inputBar(scrollViewProxy: ScrollViewProxy) -> some View {
        HStack {
            TextEditor(
                text: $inputText
            )
            .padding(.vertical, -8)
            .padding(.horizontal, -4)
            .frame(minHeight: 22, maxHeight: 300)
            .foregroundColor(.primary)
            .padding(EdgeInsets(top: 12, leading: 16, bottom: 12, trailing: 16))
            /*.background(
                RoundedRectangle(
                    cornerRadius: 16,
                    style: .continuous
                )
                .fill(fillColor)
                .overlay(
                    RoundedRectangle(
                        cornerRadius: 16,
                        style: .continuous
                    )
                    .stroke(
                        strokeColor,
                        lineWidth: 1
                    )
                )
                
            )
            */
            .fixedSize(horizontal: false, vertical: true)
            .onSubmit {
                withAnimation {
                    tapSendMessage(scrollViewProxy: scrollViewProxy)
                }
            }
            .padding(.leading)

            Button(action: {
                withAnimation {
                    tapSendMessage(scrollViewProxy: scrollViewProxy)
                }
            }) {
                Image(systemName: "paperplane")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 24, height: 24)
                    .padding(.trailing)
            }
        }
        // 下と右だけpadding
        .padding(.bottom).padding(.trailing)
    }
    
    /// 入力テキストの送信
    private func tapSendMessage(scrollViewProxy: ScrollViewProxy) {
        sendMessage(inputText, selectedChatModel)
        inputText = ""
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(
            conversation: Conversation(
                id: "1",
                messages: [
                    Message(id: "1", role: .assistant, content: "Hello, how can I help you today?", createdAt: Date(timeIntervalSinceReferenceDate: 0)),
                    Message(id: "2", role: .user, content: "I need help with my subscription.", createdAt: Date(timeIntervalSinceReferenceDate: 100)),
                    Message(id: "3", role: .assistant, content: "Sure, what seems to be the problem with your subscription?", createdAt: Date(timeIntervalSinceReferenceDate: 200)),
                    Message(id: "4", role: .function, content:
                              """
                              get_current_weather({
                                "location": "Glasgow, Scotland",
                                "format": "celsius"
                              })
                              """, createdAt: Date(timeIntervalSinceReferenceDate: 200))
                ]
            ),
            error: nil,
            sendMessage: { _, _ in }
        )
    }
}


extension DetailView {
    private var fillColor: Color {
        return Color(uiColor: UIColor.systemBackground)
    }

    private var strokeColor: Color {
        return Color(uiColor: UIColor.systemGray5)
    }
}
