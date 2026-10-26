//
//  ContentView.swift
//  NavigationStack
//
//  Created by Jurgen Bert on 26/10/2026.
//

import SwiftUI

struct ContentView: View {
    // Simple array of fruit names to display in a list
    let fruits = ["Apple", "Banana", "Cherry"]

    var body: some View {
        NavigationStack {
            List(fruits, id: \.self) { fruit in
                // Pass `fruit` into the destination so it knows which item to show
                NavigationLink(fruit) {
                    FruitDetailView(fruit: fruit)
                }
            }
            .navigationTitle("Fruits")
        }
    }
}

struct FruitDetailView: View {
    // The destination receives the value as a stored property
    let fruit: String
    @State private var showSheet = false

    var body: some View {
        Text("You selected: \(fruit)")
            .navigationTitle(fruit)
            .navigationBarTitleDisplayMode(.inline)
        Button("Open \(fruit) Sheet") {
            showSheet = true
        }
        .sheet(isPresented: $showSheet) {
        SheetContentView(fruit: fruit)
        }
    }
}

struct SheetContentView: View {
    // @Environment(\.dismiss) gives access to the dismiss action
    @Environment(\.dismiss) var dismiss
    let fruit: String

    var body: some View {
        VStack {
            Image("\(fruit.lowercased())")
                .resizable()
                .scaledToFit()
            Text("This is \(fruit) sheet")
            // Calling dismiss() closes the sheet from inside it
            Button("Close") {
                dismiss()
            }
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
