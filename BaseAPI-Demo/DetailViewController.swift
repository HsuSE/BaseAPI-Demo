//
//  DetailViewController.swift
//  BaseAPI-Demo
//
//  Created by SE Hsu on 2020/4/12.
//  Copyright © 2020 HsuSE. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    var imageView: UIImageView!
    var idLabel: UILabel!
    var titleLabel: UILabel!
    var image: ImageDetail!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let navBarHeight = UIApplication.shared.statusBarFrame.size.height +
                (navigationController?.navigationBar.frame.height ?? 0.0)
        view.backgroundColor = .white
        let fullScreenSize = UIScreen.main.bounds.size
        imageView = UIImageView(frame: CGRect(
            x: 0, y: navBarHeight,
            width: fullScreenSize.width,
            height: fullScreenSize.width
        ))
        imageView.contentMode = .scaleToFill
        
        view.addSubview(imageView)
        
        idLabel = UILabel(frame: CGRect(
            x: 15, y: navBarHeight + imageView.frame.height + 15,
            width: fullScreenSize.width - 30,
            height: 20
        ))
        idLabel.textAlignment = .left
        view.addSubview(idLabel)
        
        titleLabel = UILabel(frame: CGRect(
            x: 15, y: idLabel.frame.origin.y + idLabel.frame.height + 15,
            width: fullScreenSize.width - 30,
            height: 20
        ))
        titleLabel.textAlignment = .left
        view.addSubview(titleLabel)
        imageView.image = UIImage(imageLiteralResourceName: "default")
        imageload(url: image.thumbnailUrl) { (data) in
            self.imageView.image = UIImage(data: data)
        }
        idLabel.text = "id: \(image.id)"
        titleLabel.text = "title: \(image.title)"
        
    }
    
    func imageload(url: URL?, completion: @escaping (Data) -> ()) {
        if let url = url {
            URLSession.shared.dataTask(with: url) { (data, _, _) in
                guard let data = data else { return }
                DispatchQueue.main.async {
                    completion(data)
                }
                
            }.resume()
        }
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
