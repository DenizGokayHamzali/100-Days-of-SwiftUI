//  Created by Deniz Gökay Hamzalı on 18.10.2024.

import SwiftUI

struct AddressView: View {
    @Bindable var order: Order
    @State private var showingSaved = false
    
    var body: some View {
        ZStack {
            Color(.systemGroupedBackground)
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                Form {
                    Section {
                        TextField("Name", text: $order.name)
                        TextField("Street Address", text: $order.streetAddress)
                        TextField("City", text: $order.city)
                        TextField("Zip", text: $order.zip)
                    }
                    
                    Section {
                        NavigationLink("Check out") {
                            CheckoutView(order: order)
                        }
                    }
                    .disabled(!(order.hasValidAddress))
                }
                
                Button(action: {
                    order.saveOrderAddress()
                    showingSaved = true
                }) {
                    Text("Save Address")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.blue)
                        .cornerRadius(10)
                        .padding(.horizontal)
                }
                .padding(.bottom, 20)
                .alert("Thank you!", isPresented: $showingSaved) {
                   // Button("OK") { } Don't need this actually.
                } message: {
                    Text("Your address has been saved.")
                }
            }
        }
        .navigationTitle("Delivery details")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    AddressView(order: Order())
}
