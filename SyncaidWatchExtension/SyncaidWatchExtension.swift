//
//  SyncaidWatchExtension.swift
//  SyncaidWatchExtension
//
//  Created by AhmedFatma on 28/11/2022.
//

import AppIntents

struct SyncaidWatchExtension: AppIntent {
    static var title: LocalizedStringResource = "SyncaidWatchExtension"
    
    func perform() async throws -> some IntentResult {
        return .result()
    }
}
