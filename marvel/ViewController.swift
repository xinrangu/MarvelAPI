//
//  ViewController.swift
//  marvel
//
//  Created by Gu Xinran on 4/28/19.
//  Copyright © 2019 Gu Xinran. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var heroes = Heroes()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        loadData()
    }
    
    func loadData(){
        heroes.getHero {
            self.tableView.reloadData()
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowDetail" {
            let destination = segue.destination as! DetailViewController
            let selectedIndexPath = tableView.indexPathForSelectedRow!
            destination.hero = heroes.heroesArray[selectedIndexPath.row]
        } else {
            // note: we don't really need this code since we are not adding records and this is code
            //to deselect any rows before adding records
            if let selectedPath = tableView.indexPathForSelectedRow {
                tableView.deselectRow(at: selectedPath, animated: true)
            }
        }
    }
    
//    func sortBasedOnSegmentPressed() {
//        switch sortSegmentedControl.selectedSegmentIndex {
//        case 0: // A-Z
//            spots.spotArray.sort(by: {$0.name < $1.name})
//        case 1: // Closest
//            spots.spotArray.sort(by: {$0.location.distance(from: currentLocation) < $1.location.distance(from:currentLocation)} )
//        case 2: // Avg. Rating
//            spots.spotArray.sort(by: {$0.averageRating > $1.averageRating})
//        default:
//            print("*** ERROR: Hey, you should have gotten here, our segmented control should just have 3 segments")
//        }
//        tableView.reloadData()
//    }
//
//    @IBAction func sortSegmentPressed(_ sender: UISegmentedControl) {
//        sortBasedOnSegmentPressed()
//    }
    

}

extension ViewController: UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return heroes.heroesArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell",for: indexPath)
        cell.textLabel?.text = heroes.heroesArray[indexPath.row].name
        if indexPath.row == heroes.heroesArray.count-1 && heroes.hasRemaining(){
            heroes.getHero {
                self.tableView.reloadData()
            }
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if heroes.heroesArray[indexPath.row].isAvengers{
            cell.contentView.backgroundColor = UIColor.red
        }else{
            if (indexPath.row % 2 == 0){
                cell.contentView.backgroundColor = UIColor(hue: 0, saturation: 0.66, brightness: 1, alpha: 1.0) /* #ff5656 */
            }else{
                cell.contentView.backgroundColor = UIColor(hue: 0.1667, saturation: 0.48, brightness: 0.97, alpha: 1.0) /* #f7f780 */
            }
        }
    }
}
