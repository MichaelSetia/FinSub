//
//  HomeView.swift
//  FinSub
//
//  Created by Michael on 13/03/26.
//

import SwiftUI

struct HomeView: View {
    var viewModel : SubscriptionViewModel
    
    
    let currencyCode = Locale.current.currency?.identifier ?? "USD"
    
    var colum = [
        GridItem(.adaptive(minimum: 100)),
        GridItem(.adaptive(minimum: 100))
    ]
    var body: some View {
        VStack (alignment: .leading){
            
            LazyVGrid(columns: colum, alignment: .leading, spacing: 10){
                VStack(alignment:.leading){
                    Text("Monthly Cost")
                    Text(viewModel.monthlyCost, format: .currency(code: currencyCode))
                        .font(.headline)
                    Text("Yearly Cost")
                    Text(viewModel.monthlyCost*12, format: .currency(code: currencyCode))
                        .font(.headline)
                }
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 10)
                        .frame(height: 100)
                        .foregroundColor(.white)
                )
               
                
                
               
                ZStack{
                    RoundedRectangle(cornerRadius: 10)
                        .frame(height: 100)
                        .foregroundColor(.white)
                    VStack(alignment:.leading){
                        Text("Yearly")
                        Text(viewModel.monthlyCost*12, format: .currency(code: currencyCode))
                            .font(.headline)
                    }
                    .padding()
                }
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
            viewModel.notificationPermission()
           
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
