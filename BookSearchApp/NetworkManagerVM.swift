//
//  NetworkManagerVM.swift
//  BookSearchApp
//
//  Created by Sewell, Aramaea on 4/9/25.
//

import Foundation

//
/*
 
 NetworkManger:
 
 Fetching Data-- Requests Book cover URL, author, publisher, titles, optional description
 
 Handling Responses:-- Parses JSON into Usable Models
 
 Error Handling-- Manages network failures, timeouts, or invalid response
 
 Caching-- Stores Data to reduce API calls and improve performance
 
 
 Authentication-- Not needed, beacuse we do not have an API key.
 
 
 
 */
//  Created by Sewell, Aramaea on 3/30/25.
//

import Foundation

class NetworkManager: ObservableObject {
    private let baseURL = "https://openlibrary.org"
    @Published var books: [BookModel] = []
    @Published var isLoading = false
    @Published var errorMessage: String?
    
    //Constructing the correct URL using a search query
    
    func fetchBooks(query: String) async -> [BookModel]? {
        guard let url = URL(string: "\(baseURL)/search.json?q=\(query)") else {
            return nil
        }
        
        
        var components = URLComponents(url: url, resolvingAgainstBaseURL: false)
        components?.queryItems = [
            URLQueryItem(name: "q", value: query),
            URLQueryItem(name: "limit", value: "10") // Example of limiting the results
        ]
        
        guard let finalURL = components?.url else { return nil }
        
        var request = URLRequest(url: finalURL)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = ["Accept": "application/json"]
        
        do {
            
            // Decode the response into an instance of the Bookresponse model
            
            let (data, _) = try await URLSession.shared.data(for: request)
            let decoder = JSONDecoder()
            //Decodes the response into the BookResponse model
            let bookResponse = try decoder.decode(BookResponse.self, from: data)
            
            await MainActor.run {
                self.books = bookResponse.results
                self.isLoading = false
            }
            
            return bookResponse.results
        }
        
        catch {
            await MainActor.run {
                self.errorMessage = "Failed to load books: \(error.localizedDescription)"
                self.isLoading = false
                //should return nil
            }
            return nil
        }
    }
}


extension NetworkManager {
    static let mock = NetworkManager()
}
