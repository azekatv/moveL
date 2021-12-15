//
//  ViewController2.swift
//  spider_man
//
//  Created by Жанадил on 6/14/21.
//  Copyright © 2021 Жанадил. All rights reserved.
//

import UIKit
import SDWebImage

class ViewController2: UIViewController {
    
    // MARK: - UI
    private var scrollView: UIScrollView = {
        let view = UIScrollView()
        view.showsHorizontalScrollIndicator = false
        return view
    }()
    private var contentView = UIView()
    private var imageView = UIImageView()
    private var titleLabel = UILabel()
    private var ratingLabel = UILabel()
    private var overviewLabel = UILabel()
    
    var mov: Movie?
    
//    MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupConfiguration()
    }

// MARK: - Setup
    private func setupUI() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        contentView.translatesAutoresizingMaskIntoConstraints = false

        [imageView,
         titleLabel,
         ratingLabel,
         overviewLabel].forEach({
            contentView.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        })
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.leftAnchor.constraint(equalTo: view.leftAnchor),
            scrollView.rightAnchor.constraint(equalTo: view.rightAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leftAnchor.constraint(equalTo: scrollView.leftAnchor),
            contentView.rightAnchor.constraint(equalTo: scrollView.rightAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: view.widthAnchor)
        ])
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            imageView.rightAnchor.constraint(equalTo: contentView.rightAnchor),
            imageView.heightAnchor.constraint(equalToConstant: 300),
            
            titleLabel.leftAnchor.constraint(equalTo: imageView.leftAnchor, constant: 16),
            titleLabel.rightAnchor.constraint(equalTo: imageView.rightAnchor, constant: -16),
            titleLabel.bottomAnchor.constraint(equalTo: imageView.bottomAnchor, constant: -8),
            
            ratingLabel.topAnchor.constraint(equalTo: imageView.topAnchor, constant: 16),
            ratingLabel.leftAnchor.constraint(equalTo: imageView.leftAnchor, constant: 16),
            ratingLabel.widthAnchor.constraint(equalToConstant: 50),
            ratingLabel.heightAnchor.constraint(equalToConstant: 50),

            overviewLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 16),
            overviewLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 8),
            overviewLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -8),
            overviewLabel.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor),
        ])
    }
    
    private func setupConfiguration() {
        view.backgroundColor = #colorLiteral(red: 0.1136245802, green: 0.1930128038, blue: 0.3314402401, alpha: 1)

        titleLabel.backgroundColor = .white
        
        ratingLabel.layer.cornerRadius = 25
        ratingLabel.layer.masksToBounds = true
        ratingLabel.textAlignment = .center
        ratingLabel.backgroundColor = .white
        
        overviewLabel.numberOfLines = 0
        overviewLabel.textColor = .white
    }
    
    func setData(movie: Movie){
        imageView.sd_setImage(with: URL(string: movie.movieImage))
        ratingLabel.text = String(round(Double(movie.rating)! * 100)/100)
        titleLabel.text = "\(movie.title)\n \(movie.release_date)"
        overviewLabel.text = movie.overview
    }
}
