//
//  WebSocketSampleAppApp.swift
//  WebSocketSampleApp
//
//  Created by 佐々木一樹 on 2022/08/26.
//

import SwiftUI

@main
struct WebSocketSampleAppApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView(vm: ContentViewModel())
        }
    }
}
