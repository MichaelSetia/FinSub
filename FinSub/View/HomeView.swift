//
//  HomeView.swift
//  FinSub
//
//  Created by Michael on 13/03/26.
//

import SwiftUI

struct HomeView: View {
    @Bindable var viewModel : SubscriptionViewModel
    var body: some View {
        VStack (alignment: .leading){
            ScrollView{
                ListSubscriptionView(viewModel: viewModel)
            }
        }
        .task {
            await viewModel.loadSubscription()
        }
        .navigationBarTitle("Home")
        .toolbar{
            ToolbarItem(placement: .topBarTrailing){
                NavigationLink(destination: AddSubscriptionView(viewModel: viewModel)) {
                        Image(systemName: "plus")
                    }
            }
        }
        
    }
    
}

//#Preview {
//    HomeView()
//}
