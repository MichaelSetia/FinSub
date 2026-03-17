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
        List {
            ForEach(viewModel.nearestRenewals.prefix(5), id: \.id) { item in
                CardSubscriptionRow(
                    viewModel: viewModel,
                    subscription: item
                )
                .listRowInsets(EdgeInsets())
                .listRowSeparator(.hidden)
                .swipeActions(edge: .trailing, allowsFullSwipe: true){
                    Button(role: .destructive){
                        Task {
                            await viewModel.deleteSubscription(item)
                        }
                    } label: {
                        Label("Delete", systemImage: "trash")
                    }
                    NavigationLink(destination: AddSubscriptionView(viewModel: viewModel, EditSubscriptionData: item)) {
                        Label("Edit", systemImage: "pencil")
                    }
                    .background(Color.blue)
                    
                }

            }
            
        }
        .listStyle(.plain)
    }
}

//#Preview {
//    let container = try! ModelContainer(
//           for: SubscriptionModel.self,
//           configurations: ModelConfiguration(isStoredInMemoryOnly: true)
//       )
//       
//       let context = container.mainContext
//       
//    let repository = SwiftDataSubscriptionRepository(modelContex: context)
//       
//       let viewModel = SubscriptionViewModel(
//           repository: repository,
//           brandDetection: BrandDetector(clientId: "preview")
//       )
//       
//    ListSubscriptionView(viewModel:viewModel)
//}
