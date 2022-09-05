//
//  UIImage+Data.swift
//  MovieDB
//
//  Created by Roman Bigun on 05.09.2022.
//

import UIKit

extension UIImage {
    
    func convertToData() -> Data {
        if let possibleJpegData = self.jpegData(compressionQuality: 1.0) {
           return possibleJpegData
        }
        return self.pngData()!
    }
}
