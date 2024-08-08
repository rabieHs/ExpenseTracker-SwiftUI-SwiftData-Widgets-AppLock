//
//  NewExpenseView.swift
//  ExpenseTracker
//
//  Created by rabie houssaini on 8/8/2024.
//

import SwiftUI

struct NewExpenseView: View {
    
    @Environment(\.modelContext) private var context
    @Environment(\.dismiss) private var dismiss
    
    @State private var title: String = ""
    @State private var remarks: String = ""
    @State private var amount: Double = .zero
    @State private var dateAdded: Date = .now
    @State private var category: Category = .expense
    
    @State var tint: TintColor = tints.randomElement()!
    
    var editTransaction: Transaction?
    
    var body: some View {
        ScrollView(.vertical) {
            VStack(spacing: 15){
                Text("Preview")
                    .font(.caption)
                    .foregroundStyle(.gray)
                    .hSpacing(.leading)
                
                TransactionCardView(transaction: .init(title: title.isEmpty ? "Title" : title , remarks: remarks.isEmpty ? "Remarks" : remarks, amount: amount, dateAdded: dateAdded, category: category, tintColor: tint))
                
                CustomSection("Title",hint: "Magic Keyboard", value: $title)
                CustomSection("Remarks", hint: "Apple Product",value: $remarks)
                
                VStack(alignment:.leading,spacing: 10){
                    Text("Amount & Category")
                        .font(.caption)
                        .foregroundStyle(.gray)
                        .hSpacing(.leading)
                    HStack(spacing:15){
                        HStack(spacing:4){
                            Text(currencySymbol)
                                .font(.callout.bold())
                            TextField("0.0", value: $amount, formatter: numberFormatter)
                                .keyboardType(.decimalPad)

                        }
                            .padding(.horizontal,15)
                            .padding(.vertical,12)
                            .background(.background,in: .rect(cornerRadius: 10))
                            .frame(maxWidth: 130)
                        
                        CategoryCheckBox()
                    }
                }
                
                VStack(alignment:.leading, spacing: 10) {
                    Text("Date")
                    .font(.caption)
                    .foregroundStyle(.gray)
                    .hSpacing(.leading)
                    
                    DatePicker("", selection: $dateAdded, displayedComponents: [.date])
                        .datePickerStyle(.graphical)
                        .padding(.horizontal,15)
                        .padding(.vertical,12)
                        .background(.background,in: .rect(cornerRadius: 10))
                }
                
             
            }
            .padding(15)
        }.navigationTitle(editTransaction != nil ? "Edit Transaction" : "Add Transaction")
            .background(.gray.opacity(0.15))
            .toolbar(content: {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Save", action: save)
                }
            })
            .onAppear(perform: {
                if let editTransaction {
                    title = editTransaction.title
                    remarks = editTransaction.remarks
                    amount = editTransaction.amount
                    if let tint = editTransaction.tint {
                        self.tint = tint
                        
                    }
                    category = editTransaction.rawCategory
                    dateAdded = editTransaction.dateAdded
                    
                }
            })
    }
    
    func save(){
        
        if editTransaction != nil {
            // update
            editTransaction?.title = title
            editTransaction?.amount = amount
            editTransaction?.dateAdded = dateAdded
            editTransaction?.remarks = remarks
            editTransaction?.category = category.rawValue
        }else{
            // save
            let transaction = Transaction(title: title, remarks: remarks, amount: amount, dateAdded: dateAdded, category: category, tintColor: tint)
            context.insert(transaction)

        }
        dismiss()
    }
    
    @ViewBuilder
    func CustomSection(_ title: String,hint: String ,value:Binding<String>)-> some View{
        VStack(alignment:.leading,spacing: 10){
            Text(title)
                .font(.caption)
                .foregroundStyle(.gray)
                .hSpacing(.leading)
            
            TextField(hint, text:value)
                .padding(.horizontal,15)
                .padding(.vertical,12)
                .background(.background,in: .rect(cornerRadius: 10))
            
            
            
        }
    }
    
    @ViewBuilder
    func CategoryCheckBox()->some View{
        HStack(spacing:10){
            ForEach(Category.allCases,id: \.rawValue){category in
                HStack(spacing:5){
                    ZStack {
                        Image(systemName: "circle")
                            .font(.title3)
                            .foregroundStyle(appTint)
                        
                        if self.category == category {
                            Image(systemName: "circle.fill")
                                .font(.caption)
                                .foregroundStyle(appTint)
                        }
                    }
                    Text(category.rawValue)
                        .font(.caption)
                }
                .contentShape(.rect)
                .onTapGesture {
                    self.category = category
                }
                
            }
            
        }
        .padding(.horizontal,15)
        .padding(.vertical,12)
        .hSpacing(.leading)
        .background(.background, in: .rect(cornerRadius: 10))
    }
    
    var numberFormatter: NumberFormatter{
        let formatter =  NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = 2
        return formatter
    }
}

#Preview {
    NavigationStack{
        NewExpenseView()
    }
}
