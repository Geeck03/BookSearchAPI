//  BookModel.swift
//  Book_Search_App_CoreData
//
//  Created by Sewell, Aramaea on 3/29/25.
//

/*
 !1 Need to determine what areas are
 
 */

import Foundation

//Identifiable allows us to use for reach to display information

struct BookModel: Identifiable, Decodable, Hashable {
    //Using Search Model API
    let id: String
    let title: String
    let authors: [String]
    //let publisher: String
    //Optional
    let coverId: Int?
    let description: String?
    
    
    enum CodingKeys: String, CodingKey {
        case id = "key"
        case title
        case authors = "author_name" //The author field
        //case publisher
        case coverId = "cover_i"
        case description
    }

    
    func getCoverURL() -> URL? {
       guard let coverId = coverId else { return nil }
       return URL(string: "https://covers.openlibrary.org/b/id/\(coverId)-L.jpg")
    }
 
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    static func == (lhs: BookModel, rhs: BookModel) -> Bool {
        return lhs.id == rhs.id
    }
    
}

extension BookModel {
    static let example = BookModel(
        id: "/works/OL12345W",
        title: "The Swift Programming Language",
        authors: ["Apple"],
        //publisher: "Apple Books",
        coverId: 123456, // This is the Open Library cover ID
        description: "A comprehensive guide to the Swift programming language."
    )
}

//Response structure for APIs
struct BookResponse: Decodable {
    let results: [BookModel]
}



