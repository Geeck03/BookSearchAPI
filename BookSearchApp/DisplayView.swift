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
            AsyncImage(url: book.getCoverURL(from: networkManager)) {
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
            Text(book.name)
                .font(.headline)
                .lineLimit(2)
        }
        
        //Might need to add other things like author and the like, but I'm wating
    }
}

/*
struct DisplayListPreview: View {
    var body: some View {
        VStack {
            //example should be glowing. last book should not be
            BookRow(book: BookModel.example, networkManager:
                        book.mockNetworkManger)
        }
    }
}
 */


#Preview {
    BookRow(book: BookModel.example, networkManager: NetworkManager.mock)
}

