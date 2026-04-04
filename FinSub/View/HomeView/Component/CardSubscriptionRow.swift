import SwiftUI
import SwiftData

struct CardSubscriptionRow: View {
    
    @Environment(\.modelContext) private var modelContext
    
    @Bindable var viewModel: SubscriptionViewModel
    
    var subscription : SubscriptionModel?
    
    var brand : String = "netflix"
    
    let currencyCode = Locale.current.currency?.identifier ?? "USD"
    
    var body: some View {
        
        VStack(alignment:.leading) {
            if let sub = subscription {
                HStack{
                    if let url = viewModel.buildLabelLogoUrl(forBrand: sub.iconName ?? brand) {
                        
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
                        Text("\(sub.alternativeName != nil ? sub.alternativeName! : sub.name)")
                            .font(.headline)
                            .fontWeight(.bold)
                        Text("Renewal on \(sub.formattedNextPayment)")
                            .font(Font.caption.weight(.light))
                            .foregroundStyle(sub.isNearRenewal ? Color.red : Color.black)
                    
                        
                    }
                    Spacer()
                    VStack(alignment : .trailing){
                        Text((sub.price), format:.currency(code: currencyCode) )
                            .font(.headline)
                            .fontWeight(.bold)
                        Text(sub.billingCycle.displayName)
                            .font(Font.caption.weight(.light))
                    }
                        
                   
                }
            }
            else{
               EmptyView()
            }
            
        }
        .padding(.horizontal,8)
        .padding(.vertical,10)
        .clipShape(RoundedRectangle(cornerRadius: 5))
        
    }
}

//#Preview {
//    CardSubscriptionRow()
//        .modelContainer(for: SubscriptionModel.self)
//}

