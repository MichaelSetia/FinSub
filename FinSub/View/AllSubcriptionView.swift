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
    
    
    var body: some View {
        VStack{
            ListSubscriptionView(viewModel: viewModel, subscriptions: viewModel.nearestRenewals)
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

