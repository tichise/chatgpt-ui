//
//  AvailableModelsViewModel.swift
//

import Foundation
import OpenAI

/// 利用可能なOpenAIのモデル一覧を取得するViewModel
public final class AvailableModelsViewModel: ObservableObject {
    public var openAIClient: OpenAIProtocol
    
    @Published var availableModels: [ModelResult] = [] // 利用可能なモデル一覧
    
    public init(openAIClient: OpenAIProtocol) {
        self.openAIClient = openAIClient
    }

    /// モデル一覧を取得する
    @MainActor
    func getModels() async {
        do {
            let response = try await openAIClient.models()
            availableModels = response.data
        } catch {
            print(error.localizedDescription)
        }
    }
}
