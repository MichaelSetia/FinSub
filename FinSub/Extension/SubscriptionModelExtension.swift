//
//  SubscriptionModelExtension.swift
//  FinSub
//
//  Created by Michael on 17/03/26.
//

import Foundation

extension SubscriptionModel{
    var formattedPrice : String{
        let currentCode = Locale.current.currency?.identifier ?? "USD"
        return price.formatted(.currency(code: currentCode))
    }
    
    var formattedNextPayment : String{
        let formatted = DateFormatter()
        formatted.dateStyle = .medium
        formatted.timeStyle = .none
        return formatted.string(from: nextPayment)
    }
    
    var isNearRenewal : Bool{
        let day = Calendar.current.dateComponents([.day], from: Date(), to: nextPayment).day ?? 0
        return day <= 3
    }
    

}
