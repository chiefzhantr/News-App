//
//  File.swift
//  News App
//
//  Created by Жанторе  on 19.08.2022.
//

import Foundation

final class APICaller {
    static let shared = APICaller()
    
    struct Constants{
        static let topHEadLinesURL = URL(string: "https://newsapi.org/v2/top-headlines?country=us&apiKey=fe8531672bc14bc39b0989204dbf3ee4")
    }
    
    private init(){}
    
    public func getTopStories(completion: @escaping(Result<[Article],Error>) -> Void) {
        guard let url = Constants.topHEadLinesURL else {return}
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error {
                completion(.failure(error))
            }
            else if let data = data {
                do {
                    let result = try JSONDecoder().decode(APIResponse.self, from: data)
                    completion(.success(result.articles))
                } catch {
                    completion(.failure(error))
                }
            }
        }
        
        task.resume()
        
    }
}


//Models

struct APIResponse: Codable {
    let articles: [Article]
}
struct Article: Codable {
    let source: Source
    let title: String
    let description: String?
    let url: String?
    let urlToImage: String?
    let publishedAt: String
}
struct Source: Codable {
    let name: String
}
