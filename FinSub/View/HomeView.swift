//
//  HomeView.swift
//  FinSub
//
//  Created by Michael on 13/03/26.
//

import SwiftUI

struct HomeView: View {
    var viewModel : SubscriptionViewModel
    var body: some View {
        VStack{
            ListSubscriptionView(viewModel: viewModel)
        }
        .task {
            await viewModel.loadSubscription()
        }
        .navigationBarTitle("Home")
        .toolbar{
            ToolbarItem(placement: .topBarTrailing){
                NavigationLink ("Add", destination: AddSubscriptionView())
            }
        }
    }
    
}

//#Preview {
//    HomeView()
//}
