//
//  ChatBubbleView.swift
//

import SwiftUI

// チャットバブル
public struct ChatBubbleView: View {
    
    public init(message: Message) {
        self.message = message
    }
    
    let message: Message // メッセージ

    private var assistantBackgroundColor: Color {
        return Color(uiColor: UIColor.systemGray5)
    }

    private var userForegroundColor: Color {
        return Color(uiColor: .white)
    }

    private var userBackgroundColor: Color {
        return Color(uiColor: .systemBlue)
    }

    public var body: some View {
        HStack {
            switch message.role {
            case .assistant:
                Text(message.content)
                    .padding(.horizontal, 16)
                    .padding(.vertical, 12)
                    .background(assistantBackgroundColor)
                    .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
                Spacer(minLength: 24)
            case .user:
                Spacer(minLength: 24)
                Text(message.content)
                    .padding(.horizontal, 16)
                    .padding(.vertical, 12)
                    .foregroundColor(userForegroundColor)
                    .background(userBackgroundColor)
                    .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
            case .function:
              Text(message.content)
                  .font(.footnote.monospaced())
                  .padding(.horizontal, 16)
                  .padding(.vertical, 12)
                  .background(assistantBackgroundColor)
                  .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
              Spacer(minLength: 24)
            case .system:
                EmptyView()
            }
        }
    }
}
