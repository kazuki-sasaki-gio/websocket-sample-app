# websocket-sample-app
WebSocket通信を試験的に実装するためのリポジトリです。

# websocket test server
> https://www.piesocket.com/websocket-tester
上記のサイトで手軽にwebsocketサーバーを立ち上げることができます。

発行されたURLを下記のソースにおいて置換すれば動作します。
```swift
func setup() {
  let urlSession = URLSession(configuration: .default)

  // sample mock server...
  webSocketTask = urlSession.webSocketTask(with: URL(string: "wss://demo.piesocket.com/v3/channel_1?api_key=VCXCEuvhGcBDP7XhiJJUDvR1e1D3eiVjgZ9VRiaV&notify_self")!)
}
```
