//
//  MovieCell.swift
//  spider_man
//
//  Created by Жанадил on 6/14/21.
//  Copyright © 2021 Жанадил. All rights reserved.
//

import UIKit
import SDWebImage

class MovieCell: UICollectionViewCell {
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var rating: UILabel!
    @IBOutlet weak var lbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setData(movie: Movie){
        self.img.sd_setImage(with: URL(string: movie.movieImage))
        self.rating.text = String(round(Double(movie.rating)! * 100)/100)
        self.lbl.text = "\(movie.title)\n \(movie.release_date)"
    }
}
