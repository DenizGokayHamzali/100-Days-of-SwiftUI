//  ViewsAndModifiers
//  Created by Deniz Gökay Hamzalı on 27.02.2024.

import SwiftUI

struct Style: ViewModifier {
    func body(content: Content) -> some View {
        content
            .imageScale(.large)
            .foregroundStyle(.tint)
    }
}

struct Title: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.largeTitle)
            .foregroundColor(.blue)
    }
}

extension View {
    func titleStyle() -> some View {
        modifier(Title())
    }
}

struct ContentView: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .modifier(Style())
            Text("Hello, world!")
                .titleStyle()
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
