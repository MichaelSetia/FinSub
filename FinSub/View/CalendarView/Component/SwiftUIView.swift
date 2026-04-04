import SwiftUI

// MARK: - Data Model

struct BubbleView: View {
    let bubble: SubscriptionModel
    var viewModel: SubscriptionViewModel
    
    var body: some View {
        HStack {
            if let url = viewModel.buildLabelLogoUrl(forBrand: bubble.iconName ?? "netflix") {
                
                AsyncImage(url: url) { image in
                    image
                        .resizable()
                        .scaledToFit()
                } placeholder: {
                    ProgressView()
                }
                .frame(width: 50, height: 50)
                .cornerRadius(10)
                .foregroundColor(.white)
                
            }
            
        }
        .padding()
//        .offset(bubble.offset)
    }
}

