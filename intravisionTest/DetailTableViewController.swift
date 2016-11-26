//
//  DetailTableViewController.swift
//  intravisionTest
//
//  Created by Nick on 11.11.16.
//  Copyright © 2016 Nick. All rights reserved.
//

import UIKit

class DetailTableViewController: UITableViewController {
    
    var yearArray = [Int]()
    var stringArray = [String]()
    
    override func viewDidLoad() {
        
        let backgroundImage = UIImage(named: "background.png")
        let imageView = UIImageView(image: backgroundImage)
        imageView.contentMode = .scaleAspectFit
        self.tableView.backgroundView = imageView
        
        stringArray = yearArray.map
            {
                String($0)
        }
        
        super.viewDidLoad()
        print ("Year array ", yearArray)
    }

    override func didReceiveMemoryWarning() {
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return yearArray.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
        cell.backgroundColor = .clear
        cell.textLabel?.textColor = UIColor.white
        
        cell.textLabel?.text = stringArray[indexPath.row]

        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail" {
            let indexPath = tableView.indexPathForSelectedRow!
            let destViewController: TableViewController! = segue.destination as! TableViewController
            var detail = ""
            detail = stringArray[(indexPath as IndexPath).row]
            print(detail)
            destViewController.year = detail
        }
    }

}
