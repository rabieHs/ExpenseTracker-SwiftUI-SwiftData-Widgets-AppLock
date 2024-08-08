//
//  TransactionCardView.swift
//  ExpenseTracker
//
//  Created by rabie houssaini on 6/8/2024.
//

import SwiftUI

struct TransactionCardView: View {
    @Environment(\.modelContext) private var context
    var transaction: Transaction
    var body: some View {
        SwipeAction(cornerRadius: 10,direction: .trailing) {
            HStack(spacing: 12){
                // get the first lettre from string
                
                Text("\(transaction.title.prefix(1))")
                    .font(.title)
                    .fontWeight(.semibold)
                    .frame(width: 45,height:45)
                    .foregroundStyle(.white)
                    .background(transaction.color.gradient,in: .circle)
                
                VStack(alignment: .leading, spacing: 4){
                    Text(transaction.title)
                        .foregroundStyle(Color.primary)
                    
                    Text(transaction.remarks)
                        .font(.caption)
                        .foregroundStyle(Color.secondary)
                    Text(format(date: transaction.dateAdded, format: "dd MMM yyyy"))
                        .font(.caption2)
                        .foregroundStyle(.gray)
                }
                .lineLimit(1)
                .hSpacing(.leading)
                
                Text(currencyString(transaction.amount, allowedDigits: 1))
                    .fontWeight(.semibold)
            }
            .padding(.horizontal,15)
            .padding(.vertical,10)
            .background(.background,in: RoundedRectangle(cornerRadius: 10))
        } actions: {
            Action(tint: .red, icon: "trash") {
                context.delete(transaction)
            }
        }

        
    }
}

