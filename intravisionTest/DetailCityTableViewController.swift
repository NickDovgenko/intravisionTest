//
//  DetailCityTableViewController.swift
//  intravisionTest
//
//  Created by Nick on 14.11.16.
//  Copyright © 2016 Nick. All rights reserved.
//

import UIKit

class DetailCityTableViewController: UITableViewController {
    
    var recievedData = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //print("Полученные данные \(recievedData)")
        tableView.reloadData()
        let backgroundImage = UIImage(named: "background.png")
        let imageView = UIImageView(image: backgroundImage)
        imageView.contentMode = .scaleAspectFit
        self.tableView.backgroundView = imageView
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return recievedData.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "nameId", for: indexPath)
        
        cell.backgroundColor = .clear
        cell.textLabel?.textColor = UIColor.white
        cell.textLabel?.text = recievedData[indexPath.row]
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "returnDataCity" {
            let indexPath = tableView.indexPathForSelectedRow!
            let destViewController: TableViewController! = segue.destination as! TableViewController
            var detail = ""
            detail = recievedData[(indexPath as IndexPath).row]
            print(detail)
            destViewController.city = detail
        }
    }
    
}
