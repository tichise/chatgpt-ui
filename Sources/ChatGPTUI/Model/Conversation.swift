//
//  Conversation.swift
//

import Foundation

// 会話
struct Conversation: Equatable, Identifiable {
    init(id: String, messages: [Message] = []) {
        self.id = id
        self.messages = messages
    }
    
    typealias ID = String
    
    let id: String
    var messages: [Message]
}
