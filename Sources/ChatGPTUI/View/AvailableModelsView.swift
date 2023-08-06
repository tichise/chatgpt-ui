//
//  AvailableModelsView.swift
//

import SwiftUI

/// 利用可能なモデルの一覧画面
public struct AvailableModelsView: View {
    @ObservedObject var availableModelsViewModel: AvailableModelsViewModel
    
    public var body: some View {
        NavigationStack {
            List($availableModelsViewModel.availableModels) { row in
                Text(row.id)
            }
            .listStyle(.insetGrouped)
            .navigationTitle("Models")
        }
        .onAppear {
            Task {
                // 利用可能なモデルを取得
                await availableModelsViewModel.getModels()
            }
        }
    }
}
