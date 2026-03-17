//
//  HomeView.swift
//  FinSub
//
//  Created by Michael on 13/03/26.
//

import SwiftUI

struct HomeView: View {
    @Bindable var viewModel : SubscriptionViewModel
    
    
    let currencyCode = Locale.current.currency?.identifier ?? "USD"
    
    var colum = [
        GridItem(.adaptive(minimum: 100)),
        GridItem(.adaptive(minimum: 100))
    ]
    var body: some View {
        VStack (alignment: .leading){
            
            LazyVGrid(columns: colum, alignment: .leading, spacing: 10){
                ZStack{
                    RoundedRectangle(cornerRadius: 10)
                        .frame(height: 100)
                        .foregroundColor(.white)
                    Text(viewModel.monthlyCost, format: .currency(code: currencyCode))
                        .font(.title)
                }
               
//                RoundedRectangle(cornerRadius: 10)
//                    .frame(height: 100)
//                    .foregroundColor(.white)
            }
            .padding()
            Spacer()
            VStack(alignment:.leading){
                HStack{
                    Text("List Subscription")
                        .font(Font.headline)
                    Spacer()
                    NavigationLink(destination : AddSubscriptionView(viewModel: viewModel)){
                        Text("See All")
                            .font(Font.caption)
                    }
                }
                ListSubscriptionView(viewModel: viewModel)
            }
            .padding()
            .background(.white)
            .cornerRadius(20)
        }
        .task {
            await viewModel.loadSubscription()
        }
        .navigationBarTitle("Home")
        .background(
            VStack{
                Color.blue
                Color.white
            }
                .ignoresSafeArea()
        )
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
