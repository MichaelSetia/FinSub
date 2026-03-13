//
//  ListSubscriptionView.swift
//  FinSub
//
//  Created by Michael on 12/03/26.
//

import SwiftUI
import SwiftData

struct ListSubscriptionView: View {
    
    @Environment(\.modelContext) private var modelContext
    
    @Bindable var viewModel: SubscriptionViewModel
    
    var body: some View {
        VStack{
            ForEach(viewModel.subscriptions)   { item in
                CardSubscriptionRow(viewModel: viewModel, subscription: item)
            }
        }
        
    }
}

#Preview {
    let container = try! ModelContainer(
           for: SubscriptionModel.self,
           configurations: ModelConfiguration(isStoredInMemoryOnly: true)
       )
       
       let context = container.mainContext
       
    let repository = SwiftDataSubscriptionRepository(modelContex: context)
       
       let viewModel = SubscriptionViewModel(
           repository: repository,
           brandDetection: BrandDetector(clientId: "preview")
       )
       
    ListSubscriptionView(viewModel:viewModel)
}
