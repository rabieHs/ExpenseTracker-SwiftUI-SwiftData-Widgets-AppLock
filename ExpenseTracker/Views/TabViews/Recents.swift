//
//  Recents.swift
//  ExpenseTracker
//
//  Created by rabie houssaini on 5/8/2024.
//

import SwiftUI

struct Recents: View {
    
    @AppStorage("userName") private var userName: String = ""
    
    @State private var startDate: Date = .now.startOfMonth
    @State private var endDate: Date = .now.endOfMonth
    @State private var selectedCategory: Category = .expense
    
    // animation
    @Namespace private var animation
    
    var body: some View {
        GeometryReader {
            let size = $0.size
            NavigationStack{
                ScrollView(.vertical){
                    LazyVStack(spacing:10,pinnedViews: [.sectionHeaders]){
                        Section{
                            Button{
                                
                            }label: {
                                Text("\(format(date: startDate, format: "dd MMM yy")) to \(format(date: endDate, format: "dd MMM yy"))")
                                    .font(.caption2)
                                    .foregroundStyle(.gray)
                                
                            }
                            .hSpacing(.leading)
                            
                            CardView(income: 150, expense: 200)
                            
                            customSegmentedControl()
                                .padding(.bottom,10)
                            
                            ForEach(sampleTransactions.filter({$0.category == selectedCategory.rawValue})){transaction in
                                TransactionCardView(transaction: transaction)
        
                                    
                            }.onDelete { set in
                                sampleTransactions.remove(atOffsets: set)
                            }
                            
                            
                        }header: {
                            HeaderView(size)
                        }
                    }
                    .padding(15)
                    
                }
                .background(.gray.opacity(0.15))
            }
          
        }
    }
    
    @ViewBuilder
    func HeaderView(_ size: CGSize)->some View {
        HStack(spacing:10){
            VStack(alignment:.leading,spacing: 5){
                Text("Welcome!")
                    .font(.title)
                    .bold()
                
                if !userName.isEmpty {
                    Text(userName)
                        .font(.callout)
                        .foregroundStyle(.gray)
                }
            }
            .visualEffect { content, geometryProxy in
                
                
                content
                    .scaleEffect(headerScale(size, proxy: geometryProxy))
            }
            Spacer()
            NavigationLink{
                
            }label: {
                Image(systemName: "plus")
                    .font(.title3)
                    .fontWeight(.semibold)
                    .foregroundStyle(.white)
                    .frame(width: 45,height: 45)
                    .background(appTint.gradient, in: .circle)
                    .contentShape(.circle)
            }
        }
  
   
        .hSpacing(.leading)
        .padding(.bottom, userName.isEmpty ? 10: 5)
        .background{
            VStack(spacing:0){
                Rectangle()
                    .fill(.ultraThinMaterial)
                Divider()
            }
            .visualEffect { content, geometryProxy in
                content.opacity(headerBGOpacity(geometryProxy))
            }
        
            
                .padding(.horizontal,-15)
            
                .padding(.top,-(safeArea.top+15))
            
                
        }
        
    }
    
    @ViewBuilder
    func customSegmentedControl()-> some View {
        HStack(spacing : 0){
            ForEach(Category.allCases, id: \.rawValue){category in
                Text(category.rawValue)
                    .hSpacing()
                    .padding(.vertical,10)
                    .background{
                        if category == selectedCategory {
                            Capsule().fill(.background)
                                .matchedGeometryEffect(id: "ACTIVETAB", in: animation)
                        }
                    }
                    .contentShape(.capsule)
                    .onTapGesture {
                        withAnimation(.snappy) {
                            selectedCategory = category
                        }
                    }
            }
        }
        .background(.gray.opacity(0.15), in: .capsule)
        .padding(.top,5)
    }
    
    @ViewBuilder
    func datefilterView()-> some View {
        
    }
    
    func headerBGOpacity(_ proxy: GeometryProxy)->CGFloat {
        let minY = proxy.frame(in: .scrollView).minY+safeArea.top
        return minY > 0 ?  0 : (-minY/15)
    }
    
    func headerScale(_ size:CGSize,proxy: GeometryProxy)->CGFloat{
        let minY = proxy.frame(in: .scrollView).minY
        let screenHeight = size.height
        
        let progress = minY / screenHeight
        let scale = min(max(progress, 0), 1)*0.3
        
        return 1 + scale
    }
    
}

#Preview {
    Recents()
}
