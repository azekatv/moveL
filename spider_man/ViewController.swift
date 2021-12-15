//
//  ViewController.swift
//  spider_man
//
//  Created by Жанадил on 6/14/21.
//  Copyright © 2021 Жанадил. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class ViewController: UIViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    
    private let baseUrl = "https://api.themoviedb.org/3/movie/550/similar?"
    private var mainList: [Movie] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.barTintColor = #colorLiteral(red: 0.1136245802, green: 0.1930128038, blue: 0.3314402401, alpha: 1)
        setupCollectionView()
        requestInfo()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        collectionView.reloadData()
    }
    
    private func setupCollectionView() {
        self.collectionView.register(UINib(nibName: "MovieCell", bundle: nil), forCellWithReuseIdentifier: "MovieCell")
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.collectionViewLayout = UICollectionViewFlowLayout()
}
    
    func requestInfo(){
        let parameters: [String: String] = [
            "api_key":"6bcdd11fee2e662ba70b0c7d272cec4c"
        ]
        
        Alamofire.request(baseUrl, method: .get, parameters: parameters).responseJSON{
            (response) in
            if response.result.isSuccess{
                let movieJSON: JSON = JSON(response.result.value!)
                for i in 0..<movieJSON["results"].count{
                    let title = movieJSON["results"][i]["title"].stringValue
                    let rating = movieJSON["results"][i]["vote_average"].stringValue
                    let release_date = movieJSON["results"][i]["release_date"].stringValue
                    let overview = movieJSON["results"][i]["overview"].stringValue
                    let img = "https://image.tmdb.org/t/p/w500\(movieJSON["results"][i]["backdrop_path"].stringValue)"
                    let item = Movie(title: title, movieImage: img, rating: rating, release_date: release_date, overview: overview)
                    self.mainList.append(item)
                }
                self.collectionView.reloadData()
            }
        }
    }
}

extension ViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return mainList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard indexPath.row < mainList.count else {
            return UICollectionViewCell()
        }
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieCell", for: indexPath) as! MovieCell
        cell.setData(movie: mainList[indexPath.row])
        return cell
    }
}

extension ViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 375, height: 300)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
}

extension ViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let viewController = ViewController2()
        viewController.setData(movie: mainList[indexPath.row])
        self.navigationController?.pushViewController(viewController, animated: true)
    }
}
