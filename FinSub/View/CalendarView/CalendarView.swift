import SwiftUI

struct CalendarHeaderView : View{
    var date : String
    var nextButton : () -> Void
    var previousButton : () -> Void
    
    var body: some View{
            HStack{
                Button(action: previousButton) {
                    Image(systemName: "chevron.left")
                }
                Spacer()
                Text(date)
                    .font(.subheadline)
                Spacer()
                Button(action: nextButton) {
                    Image(systemName: "chevron.right")
                }
            }
            .padding()
            
        
    }
}

struct CalendarDayWeeks : View{
    private let days = ["S","M","T","W","T","F","S"]
    var body: some View {
        HStack(spacing : 0){
            ForEach(days.indices, id:\.self){ day in
                 Text(days[day])
                    .font(.system(size: 12, weight: .medium))
                    .foregroundColor(.secondary)
                    .frame(maxWidth: .infinity)
            }
        }
    }
}


struct DayCalendarView : View {
    var day : Int?
    var isDay : Bool
    var subscriptions : [SubscriptionModel]
    let maxDots = 3
    var viewModel: SubscriptionViewModel
    
    var body: some View {
        VStack(spacing: 2) {
            ZStack {
                if isDay {
                    Circle()
                        .fill(Color.purple.opacity(0.15))
                        .frame(width: 28, height: 28)
                }
                Text(day.map { "\($0)" } ?? "")
                    .font(.system(size: 13, weight: isDay ? .bold : .regular, design: .rounded))
                    .foregroundColor(isDay ? .purple : (day == nil ? .clear : .primary))
            }
            .frame(height: 28)
            
            if !subscriptions.isEmpty {
                HStack(spacing: 2) {
                    ForEach(subscriptions.prefix(maxDots)) { sub in
                        if let url = viewModel.buildLabelLogoUrl(forBrand: sub.iconName ?? "brand") {
                            AsyncImage(url: url) { image in
                                image
                                    .resizable()
                                    .scaledToFill()  // ganti scaledToFit -> scaledToFill
                            } placeholder: {
                                Circle()
                                    .fill(Color.gray.opacity(0.3))
                            }
                            .frame(width: 25, height: 25)  // perbesar dari 6x6 -> 14x14
                            .cornerRadius(2)
                        }
                    }
                    
                    // Pindah ke LUAR ForEach
                    if subscriptions.count > maxDots {
                        Text("+\(subscriptions.count - maxDots)")
                            .font(.system(size: 7, weight: .bold))
                            .foregroundColor(.secondary)
                    }
                }
                .frame(height: 20)  // sesuaikan height
            }
            else {
                Spacer().frame(height: 20)
            }
               
        }
        .frame(maxWidth: .infinity)
        
    }
    
}



struct FullCalendarView : View {
    let year: Int
    let month: Int
    let subscriptions: [SubscriptionModel]
    var viewModel: SubscriptionViewModel
    
       private var cells: [Int?] {
           var cal = Calendar.current
           cal.firstWeekday = 2   // Monday = 2
    
           let comps = DateComponents(year: year, month: month, day: 1)
           guard let firstDay = cal.date(from: comps) else { return [] }
    
           let weekday = cal.component(.weekday, from: firstDay)
           // Convert to 0-based Mon-first index
           let offset = (weekday - 2 + 7) % 7
    
           let range = cal.range(of: .day, in: .month, for: firstDay)!
           let daysInMonth = range.count
    
           var cells: [Int?] = Array(repeating: nil, count: offset)
           cells += (1...daysInMonth).map { Optional($0) }
    
           // Pad to complete last row
           while cells.count % 7 != 0 { cells.append(nil) }
           return cells
       }
    
       private var todayDay: Int {
           let cal = Calendar.current
           let now = Date()
           guard cal.component(.year, from: now) == year,
                 cal.component(.month, from: now) == month else { return -1 }
           return cal.component(.day, from: now)
       }
    
    
        private func isPaymentDay(sub: SubscriptionModel, day: Int, month: Int, year: Int) -> Bool {
            let calendar = Calendar.current
            let startDay = calendar.component(.day, from: sub.startDate)
            let startMonth = calendar.component(.month, from: sub.startDate)
            let startYear = calendar.component(.year, from: sub.startDate)
            
            // Hanya tampilkan jika hari cocok dengan startDate
            guard day == startDay else { return false }
            
            // Harus setelah atau sama dengan startDate
            let targetComponents = DateComponents(year: year, month: month, day: day)
            guard let targetDate = calendar.date(from: targetComponents),
                  targetDate >= sub.startDate else { return false }
            
            switch sub.billingCycle {
            case .monthly:
                // Setiap bulan di hari yang sama
                return true
                
            case .threemonth:
                // Setiap 3 bulan
                let monthDiff = (year - startYear) * 12 + (month - startMonth)
                return monthDiff % 3 == 0
                
            case .sixmonth:
                // Setiap 6 bulan
                let monthDiff = (year - startYear) * 12 + (month - startMonth)
                return monthDiff % 6 == 0
                
            case .yearly:
                // Setiap tahun di bulan & hari yang sama
                return month == startMonth
                
            case .custom(let days):
                // Hitung berdasarkan interval hari
                guard let targetDate = calendar.date(from: targetComponents) else { return false }
                let diff = calendar.dateComponents([.day], from: sub.startDate, to: targetDate).day ?? 0
                return diff >= 0 && diff % days == 0
            }
        }
    
        private func subs(for day: Int) -> [SubscriptionModel] {
            subscriptions.filter { sub in
                
                isPaymentDay(sub: sub, day: day, month: month, year: year)
            }
        }
    
       var body: some View {
           VStack(spacing: 4) {
               ForEach(0..<(cells.count / 7), id: \.self) { row in
                   HStack(spacing: 0) {
                       ForEach(0..<7) { col in
                           let cell = cells[row * 7 + col]
                           DayCalendarView (
                               day: cell,
                               isDay: cell == todayDay,
                               subscriptions: cell.map { subs(for: $0) } ?? [], viewModel: viewModel
                           )
                       }
                   }
               }
           }
       }
}


struct CalendarSubscription : View{
    @State var month = Calendar.current.component(.month, from: Date())
    @State var year = Calendar.current.component(.year, from: Date())
    var viewModel: SubscriptionViewModel
    
    private var displayDate : String {
        let component = DateComponents(year: year, month: month)
        let date = Calendar.current.date(from: component) ?? Date()
        let format = DateFormatter()
        format.dateFormat = "MMMM yyyy"
        
        return format.string(from: date)
        
        
    }
    
    private func changeMonth( delta : Int = 1){
        var m = month + delta
        var y = year
        if m > 12{
            y+=1
            m=1
        }
        if m<1 {
            y-=1
            m=12
        }
        month=m
        year=y
    }
    
    var body: some View{
        VStack{
            VStack{
                CalendarHeaderView(date: self.displayDate, nextButton: {
                    self.changeMonth(delta: +1)
                }, previousButton: {
                    self.changeMonth(delta: -1)
                }
                )
                CalendarDayWeeks()
                FullCalendarView(year: year, month: month, subscriptions: viewModel.subscriptions , viewModel: viewModel)
                
            }
            Spacer()
        }
        .task {
            await viewModel.loadSubscription()
        }
    }
}
