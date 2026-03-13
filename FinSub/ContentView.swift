//
//  ContentView.swift
//  FinSub
//
//  Created by Michael on 10/03/26.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    
    var repository: SwiftDataSubscriptionRepository {
        SwiftDataSubscriptionRepository(modelContex: modelContext)
    }
    
    var viewModel: SubscriptionViewModel {
        SubscriptionViewModel(repository:repository,brandDetection: BrandDetector(clientId: "1idfsfExBvFLlotLbUE"))
        
    }
    var body: some View {
        TabView{
            NavigationStack {
                ListSubscriptionView(viewModel: viewModel)
            }
            .tabItem{
               Label("Home", systemImage: "home")
            }
        }
        
    }
}

#Preview {
    ContentView()
        .modelContainer(for: Item.self, inMemory: true)
}
