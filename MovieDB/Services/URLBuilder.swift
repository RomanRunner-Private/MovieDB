//
//  URLBuilder.swift
//  MovieDB
//
//  Created by Roman Bigun on 04.09.2022.
//

import Foundation

struct URLBuilder {
    
    enum ApiTargetType {
        case base(listNumber: Int = 1, page: Int = 1)
        case image(endpoint: String = "")
    }
    
    private func constructImagePath(endpoint: String) -> URL {
        return URL(string: "https://image.tmdb.org/t/p/w500" + endpoint)!
    }
    
    private func constructMoviesPath(listNumber: Int, page: Int) -> URL {
        return URL(string: "https://api.themoviedb.org/4/list/\(listNumber)?page=\(page < 1 ? 1 : page)&api_key=\(ApiTokens.apiKey.rawValue)")!
    }
    
    func constructURL(for target: ApiTargetType) -> URL {
        switch target {
        case .base(let listNumber, let page):
            return self.constructMoviesPath(listNumber: listNumber, page: page)
        case .image(let endpoint):
            return self.constructImagePath(endpoint: endpoint)
        }
    }
}

