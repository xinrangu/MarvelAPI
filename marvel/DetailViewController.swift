//
//  DetailViewController.swift
//  marvel
//
//  Created by Gu Xinran on 4/29/19.
//  Copyright © 2019 Gu Xinran. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class DetailViewController: UIViewController {

    @IBOutlet weak var NameLabel: UILabel!
    @IBOutlet weak var descriptionText: UITextView!
    @IBOutlet weak var spoilerLabel: UILabel!
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var series: UILabel!
    @IBOutlet weak var comics: UILabel!
    @IBOutlet weak var avengersR: UILabel!
    @IBOutlet weak var Avengers: UILabel!
    var hero = Hero()
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
    }
    
    func downloadImage() {
        guard let url = URL(string: hero.imgURL) else { return }
        let request = URLRequest(url: url)
        
        URLSession.shared.dataTask(with: request) { [weak self] data, response, error in
            DispatchQueue.main.async {
                guard let rawData = data, let thumbnailImage = UIImage(data: rawData) else { return }
                self?.image.image = thumbnailImage
            }
            }.resume()
    }
    
    func loadImage() {
        guard let url = URL(string: hero.imgURL) else { return }
        do {
            let data = try Data(contentsOf: url) // make sure your image in this url does exist, otherwise unwrap in a if let check / try-catch
            image.image = UIImage(data: data)
        } catch {
            print("ERROR: error thrown trying to get image from URL \(url)")
        }
    }
    
    func updateUI(){
        descriptionText.text = hero.description
        NameLabel.text = hero.name
        series.text = "Total Series:\(hero.seriesNum)"
        comics.text = "Total Comics:\(hero.comicNum)"
        loadImage()
        spoilerLabel.text = "Dies In End Game?"
    }
    
    @IBAction func Spoiler(_ sender: UIButton) {
        //avengersR.text = "1st gen of Avengers?"
        //Avengers.text = hero.isAvengers ? "Assembled" : "late"
        if hero.name.hasPrefix("Iron Man") || hero.name.hasPrefix("Black Widow") || hero.id == "1009547" || hero.id == "1009624"{
            spoilerLabel.text="Yes"
        }else{
            spoilerLabel.text="No"
        }
        }
}
