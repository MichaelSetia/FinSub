//
//  ActiveSubscription.swift
//  FinSub
//
//  Created by Michael on 18/03/26.
//

import SwiftUI

struct ActiveSubscription: View {
//    @Environment(\.modelContext) private var modelContext
//    
//    @Bindable var viewModel: SubscriptionViewModel
//    
//    var subscription : SubscriptionModel?
    var body: some View {
        VStack(alignment:.leading){
            VStack{
                Text("Active Subscription")
                    .foregroundStyle(Color.white)
                VStack{
                    Image(systemName: "mic.fill")
                        .font(Font.largeTitle)
                        .foregroundStyle(Color.white)
                    
                }
                .padding()
                .background(Circle().foregroundStyle(Color.gray))
            }
        }
        .padding()
        .frame(width: 160, height: 160)
        .background(Color.black)
        .cornerRadius(20)
    }
}

#Preview {
    ActiveSubscription()
}
