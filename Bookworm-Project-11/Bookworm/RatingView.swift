//  Created by Deniz Gökay Hamzalı on 23.10.2024.

import SwiftUI

struct RatingView: View {
    @Binding var rating: Int
    
    var label = ""
    var maximumRating = 5
    
    var offImage: Image?
    var onImage = Image(systemName: "star.fill")
    
    var offColor = Color.gray
    var onColor = Color.yellow
    
    var body: some View {
        HStack {
            if label.isEmpty == false {
                Text(label)
            }
            
            ForEach(1..<maximumRating + 1, id: \.self) { number in
                Button {
                    withAnimation(.spring(response: 0.3)) {
                        rating = number
                    }
                } label: {
                    image(for: number)
                        .font(.title3)
                        .foregroundStyle(number > rating ? offColor : onColor)
                        .scaleEffect(rating == number ? 1.2 : 1.0)
                }
            }
        }
        .buttonStyle(.plain)
    }
    
    func image(for number: Int) -> Image {
        if number > rating {
            offImage ?? onImage
        } else {
            onImage
        }
    }
}

#Preview {
    RatingView(rating: .constant(4))
}
