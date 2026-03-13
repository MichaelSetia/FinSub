import SwiftUI
import SwiftData

struct CardSubscriptionRow: View {
    
    @Environment(\.modelContext) private var modelContext
    
    var viewModel: SubscriptionViewModel
    
    var subscription : SubscriptionModel?
    
    var brand : String = "netflix"
    
    var body: some View {
        
        VStack(alignment:.leading) {
            HStack{
                if let url = viewModel.buildLabelLogoUrl(forBrand: subscription?.iconName ?? brand) {
                    
                    AsyncImage(url: url) { image in
                        image
                            .resizable()
                            .scaledToFit()
                    } placeholder: {
                        ProgressView()
                    }
                    .frame(width: 50, height: 50)
                    .cornerRadius(10)
                    
                }
                VStack(alignment: .leading){
                    Text("\(subscription?.name ?? "Netflix")")
                        .font(.title)
                    Text("Monthly")
                }
                Spacer()
                Text("\(subscription?.price ?? 10.99)")
                    .font(.title)
                    .fontWeight(.bold)
            }
        }
        .clipShape(RoundedRectangle(cornerRadius: 10))
        .padding()
        
    }
}

//#Preview {
//    CardSubscriptionRow()
//        .modelContainer(for: SubscriptionModel.self)
//}

