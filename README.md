# ChatGPTUI
This repository is a repository to prepare UI for chat GPT.

## Support
iOS, iPadOS, visionOS

## Screenshot

### visionOS
[Added a View that calls ChatGPT to visionOS app - YouTube](https://www.youtube.com/watch?v=wsMPrtFplsM)

![image](https://github.com/tichise/ChatGPTUI/assets/43707/ea41ebf4-4382-4803-8971-42b500445ed8)

## Examples

#### SwiftUI
```
    var chatViewModel = ChatViewModel(openAIClient: OpenAI(apiToken: ""))

    var body: some View {
        ChatView(chatViewModel: chatViewModel)
        .padding()
        .navigationTitle("Chat")
    }
```

### License
ChatGPTUI is available under the MIT license. See the LICENSE file for more info.
