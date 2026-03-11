//
//  SubscriptionModel.swift
//  FinSub
//
//  Created by Michael on 10/03/26.
//

import Foundation
import SwiftData

@Model
final class SubscriptionModel {
    var id : UUID
    var name: String
    var price : Decimal
    var startDate : Date
    var billingCycle: BilingCycle
    var category: CategoryModel?
    
    init(id: UUID, name: String, price: Decimal, startDate: Date, billingCycle: BilingCycle, category: CategoryModel? = nil) {
        self.id = id
        self.name = name
        self.price = price
        self.startDate = startDate
        self.billingCycle = billingCycle
        self.category = category
    }
    
    var monthlyCost : Decimal {
        switch billingCycle{
            case .month: return price
            case .yearly: return price / 12
        }
    }
    
    var nextPayment : Date {
        let calender = Calendar.current
        let now = Date()
        
        let increment : DateComponents
        switch billingCycle {
        case .month: increment = DateComponents(month: 1)
        case .yearly: increment = DateComponents(year: 1)
        }
        
        var newStartDate = self.startDate
        while startDate < now{
            guard let newDate = calender.date(byAdding: increment, to: startDate) else{
                break
            }
            newStartDate = newDate
        }
        return newStartDate
    }
}
