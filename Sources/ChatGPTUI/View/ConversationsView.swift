//
//  ConversationsView.swift
//

import SwiftUI

/// 会話の一覧画面
struct ConversationsView: View {
    @Binding var conversations: [Conversation]
    @Binding var selectedConversationId: Conversation.ID?
    
    var body: some View {
        List(
            $conversations,
            editActions: [.delete],
            selection: $selectedConversationId
        ) { $conversation in
            Text(
                conversation.messages.last?.content ?? "New Conversation"
            )
            .lineLimit(2)
        }
    }
}
