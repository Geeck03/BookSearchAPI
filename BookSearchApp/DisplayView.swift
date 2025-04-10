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
        }
        
        //Might need to add other things like author and the like, but I'm wating
    }
}


#Preview {
    BookRow(book: BookModel.example, networkManager: NetworkManager.mock)
}

