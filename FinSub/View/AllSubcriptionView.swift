//
//  AllSubcriptionView.swift
//  FinSub
//
//  Created by Michael on 18/03/26.
//

import SwiftUI

struct AllSubcriptionView: View {
    @Environment(\.modelContext) private var modelContext
    
    @Bindable var viewModel: SubscriptionViewModel
    
    @State var searchText : String = ""
    
    var subscriptions: [SubscriptionModel] {
        if searchText.isEmpty {
            return viewModel.furthestRenewals
        }
        else{
            return viewModel.subscriptions.filter{ $0.name.localizedStandardContains(searchText)}
        }
    }
    
    var body: some View {
        VStack{
            HStack {
                Image(systemName: "magnifyingglass")
                    .foregroundColor(.gray)
                TextField("Search", text: $searchText)
            }
            .padding(8)
            .background(Color(.systemGray6))
            .cornerRadius(8)
            ListSubscriptionView(viewModel: viewModel, subscriptions: subscriptions)
        }
        .padding()
        .navigationBarTitleDisplayMode(.inline)
        .navigationTitle("All Subscriptions")
        .listStyle(.inset)
        .redacted(reason: viewModel.isLoading ? .placeholder : [])
        .overlay {
            if viewModel.isLoading {
                ProgressView() 
            }
        }
    }
}

