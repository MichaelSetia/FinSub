//
//  AddSubscriptionView.swift
//  FinSub
//
//  Created by Michael on 13/03/26.
//

import SwiftUI

struct AddSubscriptionView: View {
//    var viewModel : SubscriptionViewModel
    @State private var name: String = ""
    @State private var price: Int = 0
    @State private var date : Date = Date()
    @State private var billingCycle : BilingCycle = .month
    @State private var customCategory: String = ""
    let columns = [
        GridItem(.adaptive(minimum: 110))
    ]
    
    @State private var category: String = "Entertainment"
    let categories = [
            "Entertainment",
            "Music",
            "Productivity",
            "Other"
        ]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20){
            VStack(alignment: .leading, spacing: 4){
                Text("Name")
                TextField("Name", text: $name)
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(8)
            }
            VStack(alignment: .leading, spacing: 5){
                Text("Price")
                TextField("Price", value: $price, format: .currency(code: "USD"))
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(8)
                
            }
            DatePicker("Start Subscription Date", selection: $date)
        
            HStack{
                Text("Billing Cycle")
                Spacer()
                Picker("Biling Cycle",selection: $billingCycle) {
                    ForEach(BilingCycle.allCases, id:\.self){ cycle in
                        Text(cycle.rawValue.capitalized)
                            .tag(cycle)
                    }
                    
                }
            }
            
            VStack(alignment: .leading) {

                Text("Category")
                    .font(.headline)

                LazyVGrid(columns: columns, spacing: 12) {

                    ForEach(categories, id: \.self) { item in

                        Button {
                            withAnimation {
                                category = item
                            }
                        } label: {

                            Text(item)
                                .font(.subheadline)
                                .padding(.vertical, 8)
                                .frame(maxWidth: .infinity)
                                .background(
                                    
                                    category == item
                                    ? Color.blue
                                    : Color(.systemGray6)
                                )
                                .foregroundColor(
                                    category == item
                                    ? .white
                                    : .primary
                                )
                                .cornerRadius(10)
                        }
                    }
                }
            }
            
            if category == "Other" {
                
                TextField("Custom Category", text: $customCategory)
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(8)
            }
            
//            
//            
//            if categori others {
//                add category
//            }
//            
            Spacer()
            Button("Add Subscription"){
//                Task{
//                    await viewModel.addSubscription(name: name, price: price, date: date)
//                }
            }
            .buttonStyle(.borderedProminent)
            .buttonSizing(.flexible)
            .frame(maxWidth: .infinity)
        }
        .padding()
        .navigationTitle("Add Subscription")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    AddSubscriptionView()
}

