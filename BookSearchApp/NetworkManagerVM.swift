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
    
    
    //Converts String into a usable URL object
    func fetchBooks(query: String) async -> [BookModel]? {
        guard let url = URL(string: "\(baseURL)/search.json") else {
            return nil
        }
        
        
        //Breaks the URL a part so we can add query paramters
        // q = the search term you're passing
        // limit limits the results you want.
        var components = URLComponents(url: url, resolvingAgainstBaseURL: false)
        components?.queryItems = [
            URLQueryItem(name: "q", value: query),
            URLQueryItem(name: "limit", value: "20") // Example of limiting the results
        ]
        
        //Builds the finalURL with the parameters stated above
        guard let finalURL = components?.url else { return nil }
        
        //This creates a network request with the above URL
        // Uses the "GET" JSON command which means retrieve data
        // Gets the response back in JSON format
        var request = URLRequest(url: finalURL)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = ["Accept": "application/json"]
        
        do {
            
            // Decode the response into an instance of the Bookresponse model
            // Asynchronously sends the request for data, and waits for the server to respond. Gets raw data
            let (data, _) = try await URLSession.shared.data(for: request)
            
            //Creates a JSON decorder.
            //Matches the JSON fields to your BookResponse and BookModel structs
            let decoder = JSONDecoder()
            //Decodes the response into the BookResponse model
            let bookResponse = try decoder.decode(BookResponse.self, from: data)
            
            
            //Updates the UI (on the main thread)
            // books arrays now has the new results
            await MainActor.run {
                self.books = bookResponse.docs
                self.isLoading = false
            }
            
            return bookResponse.docs
        }
        
        //Updates the main thread if there is an error.
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
