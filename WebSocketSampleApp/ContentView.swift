//
//  ContentView.swift
//  WebSocketSampleApp
//
//  Created by 佐々木一樹 on 2022/08/26.
//

import SwiftUI

struct ContentView: View {
    
    /// ViewModel
    @StateObject var vm: ContentViewModel
    
    var body: some View {
        
        VStack {
            if let errorMessage = vm.errorMessage {
                Text(errorMessage)
                    .foregroundColor(.red)
                    .padding()
            }
            ScrollView {
                ForEach(vm.messages, id: \.self) { message in
                    Text(message)
                        .padding()
                }
            }
            
            TextField("send messages...", text: $vm.message)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .onSubmit {
                    Task {
                        vm.send(message: vm.message)
                    }
                }
        }
    }
}
