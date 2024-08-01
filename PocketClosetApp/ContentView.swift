//
//  ContentView.swift
//  PocketClosetApp
//
//  Created by Robbie Tabor on 4/1/24.
//
import SwiftUI

struct ContentView: View {
    @State private var selectedTab: Int = 0
    
    var body: some View {
        TabView(selection: $selectedTab) {
            ClothingItemListScreen()
                .tabItem {
                    Label("Items", systemImage: "tshirt")
                }
                .tag(0)

            ClothingOutfitListScreen()
                .tabItem {
                    Label("Outfits", systemImage: "suitcase")
                }
                .tag(1)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
