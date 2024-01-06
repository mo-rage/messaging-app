//
//  messages.swift
//  messaging app
//
//  Created by Mohamed Rage on 2024-01-05.
//

import SwiftUI

struct MessagingView: View {
    var body: some View {
        NavigationView {
            VStack {
                // Search bar placeholder
                SearchBar() // We will define this custom component below
                
                // Placeholder for messages list
                ScrollView {
                    VStack {
                        // This will contain the message previews
                    }
                }
                
                // This is just a placeholder text for end-to-end encryption info
                Text("Your personal messages are end-to-end encrypted")
                    .font(.footnote)
                    .foregroundColor(.gray)
                    .padding()
            }
            .navigationTitle("Chats")
            .navigationBarItems(trailing: Button(action: {
                // Logic for add contact or new message
            }) {
                Image(systemName: "plus")
            })
        }
    }
}

// Custom SearchBar component
struct SearchBar: View {
    @State private var searchText = ""
    
    var body: some View {
        HStack {
            TextField("Search", text: $searchText)
                .padding(7)
                .padding(.horizontal, 25)
                .background(Color(.systemGray6))
                .cornerRadius(8)
                .overlay(
                    HStack {
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(.gray)
                            .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                            .padding(.leading, 8)
                        
                        if !searchText.isEmpty {
                            Button(action: {
                                self.searchText = ""
                            }) {
                                Image(systemName: "multiply.circle.fill")
                                    .foregroundColor(.gray)
                                    .padding(.trailing, 8)
                            }
                        }
                    }
                )
                .padding(.horizontal, 10)
        }
        .padding()
    }
}
