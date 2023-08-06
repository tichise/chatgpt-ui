//
//  Message.swift
//

import Foundation
import OpenAI

// メッセージ
public struct Message: Equatable, Codable, Hashable, Identifiable {
    public var id: String
    public var role: Chat.Role
    public var content: String
    public var createdAt: Date
}
