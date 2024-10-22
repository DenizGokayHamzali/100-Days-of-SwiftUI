//  Created by Deniz Gökay Hamzalı on 19.10.2024.

import SwiftUI

struct CheckoutView: View {
    var order: Order
    
    @State private var confirmationMessage = ""
    @State private var showingConfirmation = false
    @State private var requestFailMessage = ""
    @State private var showingRequestFail = false
    
    var body: some View {
        ScrollView {
            VStack {
                AsyncImage(url: URL(string: "https://hws.dev/img/cupcakes@3x.jpg"), scale: 3) { image in
                    image
                        .resizable()
                        .scaledToFit()
                } placeholder: {
                    ProgressView()
                }
                .frame(height: 233)
                
                Text("Your total is \(order.cost, format: .currency(code: "USD"))")
                    .font(.title)
                
                Button("Place Order") {
                    Task {
                        await placeOrder()
                    }
                }
                .padding()
            }
        }
        .navigationTitle("Check out")
        .navigationBarTitleDisplayMode(.inline)
        .scrollBounceBehavior(.basedOnSize)
        .alert("Thank you!", isPresented: $showingConfirmation) {
           // Button("OK") { } Don't need this actually.
        } message: {
            Text(confirmationMessage)
        }
        .alert("Checkout Failed", isPresented: $showingRequestFail) {
            
        } message: {
            Text(requestFailMessage)
        }
    }
    
    func placeOrder() async {
        // Converting the JSON data.
        guard let encoded = try? JSONEncoder().encode(order) else {
            print("Failed to encode order")
            return
        }
        
        // Data over a network call.
        let url = URL(string: "https://reqres.in/api/cupcakes")!
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        
        // Making network request.
        do {
            let (data, _) = try await URLSession.shared.upload(for: request, from: encoded)
            
            // Handle the result.
            let decodedOrder = try JSONDecoder().decode(Order.self, from: data)
            confirmationMessage = "Your order for \(decodedOrder.quantity)x \(Order.types[decodedOrder.type].lowercased()) cupcakes is on its way!"
            showingConfirmation = true
            
        } catch {
            print("Checkout failed: \(error.localizedDescription)")
            requestFailMessage = "Checkout failed: \(error.localizedDescription)"
            showingRequestFail = true
        }
    }
}


#Preview {
    CheckoutView(order: Order())
}
