//
//  DisplayView.swift
//  Book_Search_App_CoreData
//
//  Created by Sewell, Aramaea on 4/2/25.
//

import SwiftUI

struct BookRow: View {
    let book: BookModel
    
    //We pass this to get posterURL
    @ObservedObject var networkManager: NetworkManager
    
    var body: some View {
        HStack(spacing: 15) {
            AsyncImage(url: book.getCoverURL()) {
                image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 80, height: 120)
                    .cornerRadius(8)
            } placeholder: {
                Rectangle()
                    .fill(Color.gray.opacity(0.3))
                    .frame(width: 80, height: 120)
                    .cornerRadius(8)
                
            }
        }
        
        VStack(alignment: .leading, spacing: 8) {
            Text(book.title)
                .font(.headline)
                .lineLimit(2)
            //Add authors
            //Add descirption
            
            //Text(book.description)
            
            if !book.authors.isEmpty {
                Text("By: \(book.authors.joined(separator: ", "))")
                    .font(.subheadline)
                    .foregroundColor(.gray)
                //Add authors
                //Add descirption
            } else {
                Text("No author available")
                    .font(.subheadline)
            }
            
            if let description = book.description, !description.isEmpty {
                Text(description)
                    .font(.body)
                    .foregroundColor(.gray)
            }
            else {
                Text("No description available")
                    .font(.body)
                    .foregroundColor(.gray)
            }
        }
        .padding(.vertical, 8)
    }
}


#Preview {
    BookRow(book: BookModel.example, networkManager: NetworkManager.mock)
}

