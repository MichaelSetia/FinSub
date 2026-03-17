//
//  SubscriptionModel.swift
//  FinSub
//
//  Created by Michael on 10/03/26.
//

import Foundation
import SwiftData

@Model
final class SubscriptionModel : Identifiable {
    var id : UUID
    var name: String
    var price : Decimal
    var startDate : Date
    var billingCycle: BilingCycle
    var category: CategoryModel?
    var iconName : String?
    
    init(name: String, price: Decimal, startDate: Date, billingCycle: BilingCycle, category: CategoryModel? = nil, iconName: String? = nil) {
        self.id = UUID()
        self.name = name
        self.price = price
        self.startDate = startDate
        self.billingCycle = billingCycle
        self.category = category
        self.iconName = iconName
    }
    
    var monthlyCost : Decimal {
        switch billingCycle{
            case .month: return price
            case .yearly: return price / 12
            case .inActive: return 0
        }
    }
    
    var nextPayment: Date {
        let calendar = Calendar.current
        let now = Date()
        
      
        let increment: DateComponents
        switch billingCycle {
        case .month:
            increment = DateComponents(month: 1)
        case .yearly:
            increment = DateComponents(year: 1)
        case .inActive:
            return startDate
        }
        
        var nextDate = startDate
        while nextDate <= now {
            guard let newDate = calendar.date(byAdding: increment, to: nextDate) else {
                break
            }
            nextDate = newDate
        }
        return nextDate
    }
}
