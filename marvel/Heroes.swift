//
//  Heroes.swift
//  marvel
//
//  Created by Gu Xinran on 4/28/19.
//  Copyright © 2019 Gu Xinran. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON
import CryptoSwift // needed for md5

class Heroes{
    static let avengers = ["1009165"]
    static let endgame = ["1009624","1009547","1009664","1010326","1009167","1010809"]
    let limit = 50
    var heroesArray : [Hero]=[]
    var apiURL = ""
    var offset = 0
    var total = 1491
    var recorded = 0

    func getURL() -> String{
        let ts = Date().timeIntervalSince1970.description
        let hash = "\(ts)\(MarvelAPIKeys.privatekey)\(MarvelAPIKeys.apikey)".md5()
        var r = "ts=\(ts)&apikey=\(MarvelAPIKeys.apikey)&hash=\(hash)"
        return r
    }
    func getHero(completed: @escaping () -> ()) {
        var url = MarvelAPIKeys.baseURL + "offset=\(self.offset)&limit=\(self.limit)&" + getURL()
        //print(url)
        Alamofire.request(url).responseJSON{ response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                let count = json["data"]["results"].count
                self.recorded = self.recorded+count
                //print("count:\(count)")
                //print("recordes:\(self.recorded)")
                for i in 0..<count{//parse into array
                    let id = json["data"]["results"][i]["id"].stringValue
                    let name = json["data"]["results"][i]["name"].stringValue
                    let description = json["data"]["results"][i]["description"].stringValue
                    let img = json["data"]["results"][i]["thumbnail"]["path"].stringValue
                    let URL = json["data"]["results"][i]["thumbnail"]["extension"].stringValue
                    let comics = json["data"]["results"][i]["comics"]["available"].intValue
                    let series = json["data"]["results"][i]["series"]["available"].intValue
                    let imgURL = img+"/portrait_medium."+URL
                    self.heroesArray.append(Hero(id:id,name:name,description:description,imgURL:imgURL,seriesNum:series,comicNum:comics,isAvengers:Heroes.endgame.contains(id) ? true : false))
                }
            case .failure(let error):
                print("ERROR:\(error.localizedDescription)")
            }
            completed()
        }
    }

    
    func hasRemaining()->Bool{
        if self.recorded<total{
            self.offset = self.recorded
            return true
        }
        else{
            return false
        }
    }
}
