//
//  SubscriptionModel.swift
//  FinSub
//
//  Created by Michael on 10/03/26.
//

import Foundation
import SwiftData

@Model
final class SubscriptionModel: Identifiable {
    var id: UUID
       var name: String
       var alternativeName: String?
       var price: Decimal
       var startDate: Date
       var billingCycleRaw: String
       var category: CategoryModel?
       var iconName: String?
       var isTrial: Bool
       var trialEndDate: Date?

       // TAMBAH @Transient agar SwiftData tidak coba persist ini
       @Transient
       var billingCycle: BilingCycle {
           get { BilingCycle(rawString: billingCycleRaw) }
           set { billingCycleRaw = newValue.rawString }
       }

    init(name: String, price: Decimal, startDate: Date, billingCycle: BilingCycle,
         category: CategoryModel? = nil, iconName: String? = nil,
         alternativeName: String? = nil, isTrial: Bool = false, trialEndDate: Date? = nil) {
        self.id = UUID()
        self.name = name
        self.price = price
        self.startDate = startDate
        self.billingCycleRaw = billingCycle.rawString
        self.category = category
        self.iconName = iconName
        self.alternativeName = alternativeName
        self.isTrial = isTrial
        self.trialEndDate = trialEndDate
    }

    var isTrialActive: Bool {
        guard let trialEndDate else { return false }
        return Date() < trialEndDate
    }

    var monthlyCost: Decimal {
        switch billingCycle {
        case .monthly:        return price
        case .threemonth:     return price / 3
        case .sixmonth:       return price / 6
        case .yearly:         return price / 12
        case .custom(let d):  return price / Decimal(365.0 / Double(d))
        }
    }

    var nextPayment: Date {
        let calendar = Calendar.current
        let now = Date()
        let increment: DateComponents

        switch billingCycle {
        case .monthly:       increment = DateComponents(month: 1)
        case .threemonth:    increment = DateComponents(month: 3)
        case .sixmonth:      increment = DateComponents(month: 6)
        case .yearly:        increment = DateComponents(year: 1)
        case .custom(let d): increment = DateComponents(day: d)
        }

        var nextDate = startDate
        while nextDate <= now {
            guard let newDate = calendar.date(byAdding: increment, to: nextDate) else { break }
            nextDate = newDate
        }
        return nextDate
    }
}
    
    

