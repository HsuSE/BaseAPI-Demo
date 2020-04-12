//
//  ResultViewController.swift
//  BaseAPI-Demo
//
//  Created by SE Hsu on 2020/4/12.
//  Copyright © 2020 HsuSE. All rights reserved.
//

import UIKit

class ResultViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    var collectionView: UICollectionView!
    var fullScreenSize: CGSize!
    let cellIdentifier = "collectionViewCell"
    var images = [ImageDetail]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        let resourceURL = URL(string: "https://jsonplaceholder.typicode.com/photos")!
        
        fetchJSON(url: resourceURL) { result in
            switch result {
            case .success(let images):
                self.images = images
                self.collectionView.reloadData()
                print("reload")
            case .failure(.decodeError):
                print("Decode Error")
            case .failure(.responseError):
                print("Response Error")
            }
        }
        setUpCollectionViewController()
        
    }
    
    fileprivate func setUpCollectionViewController() {
        fullScreenSize = UIScreen.main.bounds.size
        
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        
        layout.itemSize = CGSize(width: fullScreenSize.width/4,
                                 height: fullScreenSize.width/4)
        
        collectionView = UICollectionView(frame: CGRect(
            x: 0, y: 20,
            width: fullScreenSize.width,
            height: fullScreenSize.height - 20),
                                          collectionViewLayout: layout)
        collectionView.backgroundColor = .white
        collectionView.register(CollectionViewCell.self, forCellWithReuseIdentifier: cellIdentifier)
        
        collectionView.delegate = self as UICollectionViewDelegate
        collectionView.dataSource = self as UICollectionViewDataSource
        view.addSubview(collectionView)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! CollectionViewCell
        
        cell.imageView.image = UIImage(imageLiteralResourceName: "default")
        ImageLoader.load(url: images[indexPath.row].url) { data in
            cell.imageView.image = UIImage(data: data)
        }
        cell.idLabel.text = String(images[indexPath.row].id)
        cell.titleLabel.text = images[indexPath.row].title
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let detailVC = DetailViewController()
        detailVC.image = images[indexPath.row]
        navigationController?.pushViewController(detailVC, animated: true)
    }
    
    fileprivate func fetchJSON(url: URL, complation: @escaping  (Result<[ImageDetail], Err>) -> ()) {
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "GET"
        urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200,
                let jsonData = data else { return complation(.failure(.responseError)) }
            
            let decoder = JSONDecoder()
            guard let images = try? decoder.decode([ImageDetail].self, from: jsonData) else { return complation(.failure(.decodeError)) }
            
            DispatchQueue.main.async {
                complation(.success(images))
            }
            print("Fetch completed.")
        }.resume()
    }

    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}

enum Err: Error {
    case responseError
    case decodeError
}
