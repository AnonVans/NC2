//
//  SwiftUIView.swift
//  NC2Watch Watch App
//
//  Created by Stevans Calvin Candra on 21/05/24.
//

import SwiftUI

struct WatchProgressRing: View {
    @ObservedObject var itemViewModel: WatchBudItemViewModel
    
    var body: some View {
        ZStack {
            if !itemViewModel.changeDisplay {
                Image(systemName: itemViewModel.budItem!.imageName )
                    .font(.system(size: 75))
                    .foregroundColor(itemViewModel.budItem!.colorScheme)
                    .offset(y: 7)
            } else {
                VStack {
                    Text(itemViewModel.fetchRemainingAmountString())
                        .font(.headline)
                        .bold()
                        .foregroundStyle(itemViewModel.budItem!.colorScheme)
                    Text("remaining")
                        .font(.caption)
                }
                .frame(width: 120, height: 120)
            }
            
            Circle()
                .trim(from: 0.0, to: 0.75)
                .stroke(style: StrokeStyle(lineWidth: 7.5, lineCap: .round, lineJoin: .round))
                .frame(width: 115)
                .opacity(0.25)
                .foregroundColor(.gray)
                .rotationEffect(.degrees(135))
            
            Circle()
                .trim(from: 0.0, to: CGFloat(min(itemViewModel.calculateItemProgress(), 0.75)))
                .stroke(style: StrokeStyle(lineWidth: 7.5, lineCap: .round, lineJoin: .round))
                .frame(width: 115)
                .foregroundColor(itemViewModel.budItem!.colorScheme)
                .rotationEffect(.degrees(-225))
        }
        .frame(height: 125)
    }
}

//#Preview {
//    WatchProgressRing()
//}
