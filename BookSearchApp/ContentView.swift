//
//  ContentView.swift
//  BookSearchApp
//
//  Created by Sewell, Aramaea on 4/9/25.
//
import SwiftUI


struct ContentView: View {
    var body: some View {
        TabView{
            SearchViewPreview()
                .tabItem{
                    Label("Search", systemImage: "magnifyingglass")
                }
        }
    }
}

#Preview {
    ContentView()
}
