//
//  ContentView.swift
//  BigWallet
//
//  Created by Alfred Lotsu on 02/06/2025.
//

import SwiftUI
import Foundation

// TransactionRecord is the model object for
// the Transaction entity
struct TransactionRecord: Identifiable {
    let id: String = UUID().uuidString
    let senderName: String
    let receiverName: String
    let amount: Double
    let date: Date
    
}

struct ContentView: View {
    /*
    this function adds a new record to the array, with the slide animation
     */
    func addNewTransaction() {
        withAnimation(.spring()) {
                   self.sampleTransactionData.insert(TransactionRecord(senderName: "Alfred Lotsu", receiverName: "BamBam", amount: 22.4782, date: .now), at: 0)
               }
    }
    
    @State var sampleTransactionData: [TransactionRecord] = []
    @State var searchText: String = ""
    /*
    this computed property performs a filter on the sampleTransactionData, based on the text in the search bar
     [sender or receiver name]
     */
    var filteredTransactions: [TransactionRecord] {
           guard !searchText.isEmpty else {
               return sampleTransactionData
           }
           return sampleTransactionData.filter { record in
               record.senderName.localizedCaseInsensitiveContains(searchText) ||
               record.receiverName.localizedCaseInsensitiveContains(searchText)
           }
       }

    /**
            Sample array of dummy data for the UI
     */
    let transactionRecords: [TransactionRecord] = [
             TransactionRecord(senderName: "Alfred Lotsu", receiverName: "Bob Johnson", amount: 150.75, date: Date(timeIntervalSinceReferenceDate: 779435161.0)),
             TransactionRecord(senderName: "Charlie Brown", receiverName: "Alfred Lotsu", amount: 25.00, date: Date(timeIntervalSinceReferenceDate: 779590861.0)),
             TransactionRecord(senderName: "Eva Green", receiverName: "Alfred Lotsu", amount: 500.00, date: Date(timeIntervalSinceReferenceDate: 778917961.0)),
             TransactionRecord(senderName: "Alfred Lotsu", receiverName: "Harry Potter", amount: 12.30, date: Date(timeIntervalSinceReferenceDate: 779677261.0)),
             TransactionRecord(senderName: "Alfred Lotsu", receiverName: "Jack Sparrow", amount: 761.0, date: Date(timeIntervalSinceReferenceDate: 779763661.0)),
             TransactionRecord(senderName: "Oscar Wilde", receiverName: "Alfred Lotsu", amount: 300.50, date: Date(timeIntervalSinceReferenceDate: 779270461.0)),
             TransactionRecord(senderName: "Alfred Lotsu", receiverName: "Rachel Ray", amount: 88.20, date: Date(timeIntervalSinceReferenceDate: 779184061.0)),
             TransactionRecord(senderName: "Steve Martin", receiverName: "Alfred Lotsu", amount: 75.00, date: Date(timeIntervalSinceReferenceDate: 779097661.0)),
             TransactionRecord(senderName: "Ursula K. Le Guin", receiverName: "Alfred Lotsu", amount: 123.45, date: Date(timeIntervalSinceReferenceDate: 778831561.0)),
             TransactionRecord(senderName: "Alfred Lotsu", receiverName: "Xavier Niel", amount: 99.99, date: Date(timeIntervalSinceReferenceDate: 778745161.0))
  
    ]
    var body: some View {
        NavigationStack {
            // this renders the list of transactions from the dummy data array in a vertical scrollable view
            ScrollView {
                VStack(spacing: 20) {
                
                    ForEach(filteredTransactions) { record in
                        TransactionCard(transactionData: record)
                            .transition(.move(edge: .leading))
                    }
                }
                .padding()
                .navigationTitle("BigWallet")
                .navigationBarTitleDisplayMode(.inline)

                .onAppear {
                    sampleTransactionData = transactionRecords
                }
            }
            .searchable(text: $searchText)
            
            
        }
        // This is for placing the button at the bottom-trailing inset
        .safeAreaInset(edge: .bottom, alignment: .trailing) {
            Button(action: addNewTransaction) {
                Text("Add new transaction")
                    .padding(20)
                    .background(Color.white.clipShape(RoundedRectangle(cornerRadius: 25)))
                    .padding(.trailing, 20)
                    .shadow(color: Color.gray.opacity(0.7), radius: 20)

            }
        }
    }
}

struct TransactionCard: View {
    // This Date formatter sets the format of the date
    // in this case, short date and short time displayed
    static let cardDateFormatter: DateFormatter = {
          let formatter = DateFormatter()
          formatter.dateStyle = .medium
          formatter.timeStyle = .short
          return formatter
      }()
    var transactionData: TransactionRecord
    
    var body: some View {
            VStack(alignment: .leading, spacing: 5) {
                HStack {
                    VStack(alignment: .leading) {
                        Group {
                            Text("GH¢ \(transactionData.amount, specifier: "%.2f")")
                                .font(.title3)
                            HStack {
                                HStack {
                                    Text(transactionData.senderName == "Alfred Lotsu" ? "Me" : transactionData.senderName)
                                    
                                }
                                Image(systemName: "arrow.forward")
                                    .fontWeight(.regular)
                                Text(transactionData.receiverName == "Alfred Lotsu" ? "Me" :transactionData.receiverName)
                                Spacer()
                            }
                            .fontWeight(.bold)
                            .font(.headline)
                            Text("\(transactionData.date, formatter: Self.cardDateFormatter)")
                            
                        }
                        .foregroundStyle(Color.white)
                    }
                    VStack(alignment: .leading, spacing: 5) {
                        Text("Reference")
                        Text("lukatme")
                    }
                    .foregroundStyle(.white)
                }
                
            }.padding(.horizontal, 20)
                .padding(.vertical, 25)
                .background(
                    LinearGradient(
                        gradient: Gradient(colors: [Color.blue, Color.indigo]),
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                    .clipShape(RoundedRectangle(cornerRadius: 12))
                )            .frame(maxWidth: .infinity)
        
           
        
    }
}

#Preview {
    ContentView()
}
