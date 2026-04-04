enum BilingCycle: Codable, Hashable, CaseIterable {
    case monthly
    case threemonth
    case sixmonth
    case yearly
    case custom(Int)

    static var allCases: [BilingCycle] {
        return [.monthly, .threemonth, .sixmonth, .yearly]
    }

    // MARK: - Custom Codable

    private enum CodingKeys: String, CodingKey {
        case type, days
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        switch self {
        case .monthly:
            try container.encode("monthly", forKey: .type)
        case .threemonth:
            try container.encode("threemonth", forKey: .type)
        case .sixmonth:
            try container.encode("sixmonth", forKey: .type)
        case .yearly:
            try container.encode("yearly", forKey: .type)
        case .custom(let days):
            try container.encode("custom", forKey: .type)
            try container.encode(days, forKey: .days)
        }
    }
    
    static func == (lhs: BilingCycle, rhs: BilingCycle) -> Bool {
            switch (lhs, rhs) {
            case (.monthly, .monthly):         return true
            case (.threemonth, .threemonth):   return true
            case (.sixmonth, .sixmonth):       return true
            case (.yearly, .yearly):           return true
            case (.custom(let a), .custom(let b)): return a == b
            default: return false
            }
        }
    
    var rawString: String {
            switch self {
            case .monthly:          return "monthly"
            case .threemonth:       return "threemonth"
            case .sixmonth:         return "sixmonth"
            case .yearly:           return "yearly"
            case .custom(let days): return "custom_\(days)"
            }
        }

        // Konversi dari String saat membaca dari SwiftData
    init(rawString: String) {
        switch rawString {
        case "monthly":    self = .monthly
        case "threemonth": self = .threemonth
        case "sixmonth":   self = .sixmonth
        case "yearly":     self = .yearly
        default:
            if rawString.hasPrefix("custom_"),
               let days = Int(rawString.dropFirst(7)) {
                self = .custom(days)
            } else {
                self = .monthly // fallback
            }
        }
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let type = try container.decode(String.self, forKey: .type)
        switch type {
        case "monthly":    self = .monthly
        case "threemonth": self = .threemonth
        case "sixmonth":   self = .sixmonth
        case "yearly":     self = .yearly
        case "custom":
            let days = try container.decode(Int.self, forKey: .days)
            self = .custom(days)
        default:           self = .monthly // fallback
        }
    }
}
