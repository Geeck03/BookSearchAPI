//
//  SearchView.swift
//  BookSearchApp
//
//  Created by Sewell, Aramaea on 4/9/25.
//

import SwiftUI

//
//  SearchView.swift
//  Book_Search_App_CoreData
//
//  Created by Sewell, Aramaea on 3/29/25.
//

import SwiftUI

struct SearchViewPreview: View {
    @ObservedObject var viewModel = SearchViewModel()
    //@Published var books: [BookModel] = []
    
    var body: some View {
        VStack {
            TextField("Search for books", text: $viewModel.query, onCommit: {
                viewModel.searchBooks()
                
            })
            .textFieldStyle(RoundedBorderTextFieldStyle())
            .padding()
            
            if viewModel.isLoading {
                ProgressView("Loading...")
            } else if let errorMessage = viewModel.errorMessage {
                Text("Error: \(errorMessage)")
            }
            
            
             ForEach(viewModel.books, id: \.self) { book in
                 BookRow()
             }
             
        }
    }
}


#Preview {
    SearchViewPreview()
}
