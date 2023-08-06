//
//  ChatView.swift
//

import Combine
import SwiftUI

// チャット画面
public struct ChatView: View {
    @ObservedObject var chatViewModel: ChatViewModel
    
    public init(chatViewModel: ChatViewModel) {
        self.chatViewModel = chatViewModel
    }

    public var body: some View {
        
        NavigationSplitView(columnVisibility: .constant(.automatic), sidebar: {
            // 会話一覧
            ConversationsView(
                conversations: $chatViewModel.conversations,
                selectedConversationId: Binding<Conversation.ID?>(
                    get: {
                    chatViewModel.selectedConversationID
                }, set: { newId in
                    chatViewModel.selectConversation(newId)
                })
            )
            .toolbar {
                ToolbarItem(
                    placement: .primaryAction
                ) {
                    Button(action: {
                        // 会話を追加
                        chatViewModel.createConversation()
                    }) {
                        Image(systemName: "plus")
                    }
                    .buttonStyle(.borderedProminent)
                }
            }
        }, detail: {
            // 会話詳細
            if let conversation = chatViewModel.selectedConversation {
                DetailView(
                    conversation: conversation,
                    error: chatViewModel.conversationErrors[conversation.id],
                    sendMessage: { message, selectedModel in
                        Task {
                            // メッセージを送信
                            await chatViewModel.sendMessage(
                                Message(
                                    id: UUID().uuidString,
                                    role: .user,
                                    content: message,
                                    createdAt: Date()
                                ),
                                conversationId: conversation.id,
                                model: selectedModel
                            )
                        }
                    }
                )
            }
        }).navigationSplitViewStyle(.balanced)
    }
}
