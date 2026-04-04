//
//  DisplayNameExtension.swift
//  FinSub
//
//  Created by Michael on 04/04/26.
//

extension BilingCycle {
    var displayName: String {
        switch self {
        case .monthly: return "Monthly"
        case .threemonth: return "3-Month"
        case .sixmonth: return "6-Month"
        case .yearly: return "Yearly"
        case .custom(let days): return "Custom (\(days) days)"
        }
    }
}
