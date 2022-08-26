//
//  ContentViewModel.swift
//  WebSocketSampleApp
//
//  Created by 佐々木一樹 on 2022/08/26.
//

import Foundation
import SwiftUI

final class ContentViewModel: ObservableObject {
    
    @Published var message: String = ""
    
    @Published var messages: [String] = []
    
    @Published var errorMessage: String?
    
    private var webSocketTask: URLSessionWebSocketTask?
    
    init() {
        setup()
        Task {
            await connect()
        }
    }
    
    func setup() {
        let urlSession = URLSession(configuration: .default)
        
        // sample mock server...
        webSocketTask = urlSession.webSocketTask(with: URL(string: "wss://demo.piesocket.com/v3/channel_1?api_key=VCXCEuvhGcBDP7XhiJJUDvR1e1D3eiVjgZ9VRiaV&notify_self")!)
    }
    
    func connect() async {
        webSocketTask?.resume()
        await receive()
    }
    
    func disconnect() {
        webSocketTask?.cancel(with: .goingAway, reason: nil)
    }
    
    func send(message: String) {
        let socketMessage = URLSessionWebSocketTask.Message.string(message)
        
        Task {
            do {
                try await webSocketTask?.send(socketMessage)
                
            } catch {
                DispatchQueue.main.async {
                    self.errorMessage = error.localizedDescription
                }
            }
        }
    }
    
    func receive() async {
        do {
            let socketMessage = try await webSocketTask?.receive()
            
            switch socketMessage {
            case .string(let message):
                print(message)
                DispatchQueue.main.async {
                    self.messages.insert(message, at: 0)
                }
            case .data(let data):
                print(data)
            case .none:
                print("none")
            case .some(_):
                print("some")
            }
            
            // 再帰処理
            await receive()
            
        } catch {
            DispatchQueue.main.async {
                self.errorMessage = error.localizedDescription
            }
        }
    }
}
