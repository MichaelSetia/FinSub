//
//  HeaderHomeView.swift
//  FinSub
//
//  Created by Michael on 18/03/26.
//

import SwiftUI

struct HeaderHomeView: View {
    @Environment(\.modelContext) private var modelContext
    @Bindable var viewModel: SubscriptionViewModel
    let currencyCode = Locale.current.currency?.identifier ?? "USD"
    @State private var floating = false

    var body: some View {
        HStack(spacing: 10) {
            VStack(alignment: .leading, spacing: 10) {
                Text("Monthly Average")
                    .font(.title3.bold())
                    .foregroundStyle(Color.white)
                Text(viewModel.monthlyCost, format: .currency(code: currencyCode))
                    .font(.subheadline)
                    .foregroundStyle(.white)
                Spacer()
                HStack(alignment: .firstTextBaseline, spacing: 5) {
                    Text("\(viewModel.subscriptions.count)")
                        .font(.system(size: 26, weight: .bold, design: .rounded))
                        .foregroundColor(.white)
                    Text("Active")
                        .font(.system(size: 14, weight: .medium, design: .rounded))
                        .foregroundColor(.white.opacity(0.55))
                }
            }
            .padding()
            .frame(maxWidth: .infinity, maxHeight: 160)
            .background(Color(white: 0.12))
            .cornerRadius(20)

            VStack(alignment: .leading, spacing: 8) {
                Text("Nearest Renewals")
                    .font(.headline.bold())
                    .foregroundStyle(Color.white)
                    .padding(.bottom, 4)

                let items = Array(viewModel.nearestRenewals.prefix(3))
                ZStack(alignment: .topLeading) {
                    ForEach(Array(items.enumerated()), id: \.element.id) { index, subscription in
                        BubbleView(bubble: subscription, viewModel: viewModel)
                            .offset(x: CGFloat(index * 25), y: floating ? -5 : 5)
                            .animation(
                                Animation.easeInOut(duration: 1.5)
                                .repeatForever(autoreverses: true)
                                .delay(Double(index) * 0.2),
                            value: floating
                            )
                    }
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
            }
            .padding()
            .frame(width: 160, height: 160)
            .background(Color(white: 0.12))
            .cornerRadius(20)
        }
        .padding()
        .onAppear {
            withAnimation {
                floating = true
            }
        }
    }
}
