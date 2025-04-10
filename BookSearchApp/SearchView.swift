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
            .padding()
            
            if viewModel.isLoading {
                ProgressView("Loading...")
            } else if let errorMessage = viewModel.errorMessage {
                Text("Error: \(errorMessage)")
            }
            
            /*
             ForEach(viewModel.books, id: \.self) { book in
             Text(book.title)
             }
             */
            
            
            List(viewModel.books, id: \.self) { book in
                HStack {
                    if let coverURL = book.getCoverURL() {
                        AsyncImage(url: coverURL) { image in
                            image.resizable()
                                .scaledToFit()
                                .frame(width: 50, height: 75)
                            
                            
                        } placeholder: {
                            ProgressView()
                            /*
                             Rectangle()
                             .fill(Color.gray.opacity(0.3))
                             .frame(width: 80, height: 120)
                             .cornerRadius(8)
                             */
                            
                        }
                    }
                    
                    VStack(alignment: .leading) {
                        Text(book.title)
                            .font(.headline)
                            .lineLimit(1)
                        if let authors = book.author_name, !authors.isEmpty {
                            Text(authors.joined(separator: ", "))
                                .font(.subheadline)
                                .foregroundColor(.gray)
                            //Add authors
                            //Add descirption
                        } else {
                            Text("No author available")
                                .font(.subheadline)
                                .forgroundColor(.gray)
                            
                            //Might need to add other things like author and the like, but I'm wating
                        }
                    }
                }
            }
        }
    }
}
                    
    


#Preview {
    SearchViewPreview()
}
