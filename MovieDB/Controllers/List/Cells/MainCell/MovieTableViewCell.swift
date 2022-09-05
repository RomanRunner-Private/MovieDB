//
//  MovieTableViewCell.swift
//  MovieDB
//
//  Created by Roman Bigun on 03.09.2022.
//

import UIKit

class MovieTableViewCell: UITableViewCell {
     
    @IBOutlet private var posterImageView: UIImageView!
    @IBOutlet private var movieTitleLabel: UILabel!
    
    func configure(with data: Result, viewModel: MovieListViewModel) {
        Task {
            await processData(with: data, viewModel: viewModel)
        }
    }
    
    private func processData(with data: Result, viewModel: MovieListViewModel) async {
        
        movieTitleLabel.text = data.title
        
        Task {
            
            // MARK: - in case we are having an image in the local storage
            if let imageData = data.imageData {
                DispatchQueue.main.async {
                    // MARK: - async image converter from Data
                    self.posterImageView.image = UIImage(data: imageData)
                }
                return
            }
            
            // MARK: - have just loaded model from the moviedb backend
            let image = await viewModel.loadImage(by: data.posterPath) as? UIImage
            posterImageView.image = image
        }
    }
}
