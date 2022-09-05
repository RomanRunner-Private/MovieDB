//
//  ImageProcessing.swift
//  MovieDB
//
//  Created by Roman Bigun on 03.09.2022.
//

import UIKit

extension UIImage {
    @available(iOS 13, *)
    var poster: UIImage? {
        get async {
            let size = CGSize(width: 300, height: 500)
            return await self.byPreparingThumbnail(ofSize: size)
        }
    }
}

enum FetchError: Error {
    case badID
    case badImage
    
}

actor ImageProcessing {
    
    private enum CacheEntry {
        case inProgress(Task<UIImage, Error>)
        case ready(UIImage)
    }
    
    private var cache: [URL: CacheEntry] = [:]
    
    func image(from url: URL) async throws -> UIImage? {
        if let cached = cache[url] {
            switch cached {
                case .ready(let image):
                    return image
                case .inProgress(let handle):
                    return try await handle.value
            }
        }
        
        let handle = Task.init {
            try await downloadImage(from: url)
        }
        
        cache[url] = .inProgress(handle)
        
        do {
            let image = try await handle.value
            cache[url] = .ready(image)
            return image
        } catch {
            cache[url] = nil
            throw error
        }
    }
    
   private func downloadImage(from url: URL) async throws -> UIImage {
       
        let request = URLRequest.init(url:url)
        let (data, response) = try await URLSession.shared.data(for: request)
        guard (response as? HTTPURLResponse)?.statusCode == 200 else {
            throw FetchError.badID
            
        }
        let maybeImage = UIImage(data: data)
        guard let poster = await maybeImage?.poster else { throw FetchError.badImage }
        return  poster
    }
    
    func convertToImage(source: AnyObject) -> UIImage {
        return source as! UIImage
    }
}
