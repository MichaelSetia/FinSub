//
//  AddSubscriptionView.swift
//  FinSub
//
//  Created by Michael on 13/03/26.
//

import SwiftUI

struct AddSubscriptionView: View {
    @Bindable var viewModel : SubscriptionViewModel
    @State private var name: String = ""
    @State private var price: Decimal = 0
    @State private var startDate : Date = Date()
    @State private var billingCycle : BilingCycle = .month
    @State private var customCategory: String = ""
    @Environment(\.dismiss) var dismiss
    var EditSubscriptionData: SubscriptionModel?
    
    let currencyCode = Locale.current.currency?.identifier ?? "USD"
    
    @State private var category: String = "Entertainment"
    let categories = [
            "Entertainment",
            "Music",
            "Productivity",
            "Other"
        ]
    
    let columns = [
        GridItem(.adaptive(minimum: 110))
    ]
    
    init(viewModel: SubscriptionViewModel, EditSubscriptionData: SubscriptionModel? = nil) {
         self.viewModel = viewModel
         self.EditSubscriptionData = EditSubscriptionData
         
         if let sub = EditSubscriptionData {
             _name = State(initialValue: sub.name)
             _price = State(initialValue: sub.price)
             _startDate = State(initialValue: sub.startDate)
             _billingCycle = State(initialValue: sub.billingCycle)
             
             
             let categoryName = sub.category?.name ?? "Entertainment"
             _category = State(initialValue: categoryName)

         }
     }
    
    var body: some View {
            VStack(alignment: .leading, spacing: 20){
                HStack{
                    if name.isEmpty{
                        RoundedRectangle(cornerRadius: 8)
                            .frame(width: 60, height: 60)
                    }
                    else{
                        if let url = viewModel.buildLabelLogoUrl(forBrand: name) {
                            
                            AsyncImage(url: url) { image in
                                image
                                    .resizable()
                                    .scaledToFit()
                            } placeholder: {
                                ProgressView()
                            }
                            .frame(width: 60, height: 60)
                            .cornerRadius(10)
                            
                        }
                    }
                    VStack(alignment: .leading, spacing: 4){
                        Text("Name")
                        TextField("Name", text: $name)
                            .padding()
                            .background(Color(.systemGray6))
                            .cornerRadius(8)
                    }
                }
                VStack(alignment: .leading, spacing: 5){
                    Text("Price")
                    TextField("Price", value: $price, format: .currency(code: currencyCode))
                        .padding()
                        .background(Color(.systemGray6))
                        .cornerRadius(8)
                    
                }
                DatePicker("Start Subscription Date", selection: $startDate)
                
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

                Spacer()
                Button((EditSubscriptionData != nil) ? "Update Subscription" : "Add Subscription"){
                    let categoryModel = CategoryModel(name: category == "Other" ? customCategory : category)
                            if let sub = EditSubscriptionData {
                                Task{
                                    await viewModel.updateSubscription(
                                        sub,
                                        name: name,
                                        price: price,
                                        startDate: startDate,
                                        billingCycle: billingCycle,
                                        category: categoryModel,
                                        iconName: name
                                    )
                                }
                            } else {
                                Task{
                                    await viewModel.addSubscription(
                                        name: name,
                                        price: price,
                                        date: startDate,
                                        billingCycle: billingCycle,
                                        category: categoryModel,
                                        iconName: name
                                    )
                                }
                            }
                            dismiss()
                }
                .buttonStyle(.borderedProminent)
                .buttonSizing(.flexible)
                .frame(maxWidth: .infinity)
            }
            .padding()
            .navigationTitle((EditSubscriptionData != nil) ? "Update Subscription" : "Add Subscription")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar(.hidden, for: .tabBar)
        
    }
}

//#Preview {
//    AddSubscriptionView()
//}
//
