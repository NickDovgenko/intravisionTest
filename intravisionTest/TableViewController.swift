//
//  TableViewController.swift
//  intravisionTest
//
//  Created by Nick on 09.11.16.
//  Copyright © 2016 Nick. All rights reserved.
//

import UIKit
import Alamofire

class TableViewController: UITableViewController, UITextFieldDelegate {
    
    @IBOutlet weak var emailAdress: UITextField!
    @IBOutlet weak var phoneNumber: AKMaskField!
    @IBOutlet weak var middleName: UITextField!
    @IBOutlet weak var firstName: UITextField!
    @IBOutlet weak var lastName: UITextField!
    @IBOutlet weak var genderSwitch: UISegmentedControl!
    @IBOutlet weak var vinCode: UITextField!
    @IBOutlet weak var yearOfCreate: UILabel!
    @IBOutlet weak var chooseClass: UILabel!
    @IBOutlet weak var chooseCity: UILabel!
    @IBOutlet weak var chooseDiler: UILabel!
    
    var dataClass = [String]()
    var dataCity = [String]()
    var dataDiler = [String]()
    
    //Взят в качестве проверки работы кода
    let baseURL = "https://jsonplaceholder.typicode.com/posts"
    
    var year = ""
    var autoClass = ""
    var city = ""
    var diler = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.requestDataClass()
        self.requestDataCity()
        self.requestDataDiler()
        
        // Проверка текста ячеек
        if year == "" {
            yearOfCreate?.text = "Выберите год выпуска"
        }
        else {
            yearOfCreate?.text = year
        }
        if autoClass == "" {
            chooseClass?.text = "Выберите класс"
        }
        else {
            chooseClass?.text = autoClass
        }
        if city == ""  {
            chooseCity?.text = "Выберите город"
        }
        else {
            chooseCity?.text = city
        }
        if diler == ""  {
            chooseDiler?.text = "Выберите дилера"
        }
        else {
            chooseDiler?.text = diler
        }
        
        //
        vinCode.delegate = self
        
        tableView.tableFooterView = UIView()

        //Фон таблицы
        let backgroundImage = UIImage(named: "background.png")
        let imageView = UIImageView(image: backgroundImage)
        imageView.contentMode = .scaleAspectFit
        self.tableView.backgroundView = imageView
        
        //Заголовок View
        self.title = "Service Привилегия 3+"
        
        //Цвет navigationBar
        self.navigationController?.navigationBar.barStyle = .black
        
        //Левая и правая кнопки
        let backbutton = UIBarButtonItem.init(image: #imageLiteral(resourceName: "backArrow"), style: .plain, target: self, action: nil)
        let forwardButton = UIBarButtonItem.init(image: #imageLiteral(resourceName: "arrow"), style: .plain, target: self, action: nil)
        navigationItem.leftBarButtonItem = backbutton
        navigationItem.rightBarButtonItem = forwardButton

    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 2
    }
    
    //Максимум 16 символов в строке VIN
    func textField(_ textField: UITextField,
                   shouldChangeCharactersIn range: NSRange,
                   replacementString string: String) -> Bool
    {
        var startString = ""
        if (textField.text != nil)
        {
            startString += textField.text!
        }
        startString += string
        let limitNumber = startString.characters.count
        if limitNumber > 17
        {
            alert(message: "Максимум 17 символов в поле VIN", title: "Ошибка")
            return false
        }
        else
        {
            return true
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showYear" {
            let destViewController: DetailTableViewController! = segue.destination as! DetailTableViewController
            var detail = [Int]()
            let date = NSDate()
            let calendar = NSCalendar.current
            let year = calendar.component(.year, from: date as Date)
            print(year)
            let pastYear = year  - 15
            print(pastYear)
            let nextYear = year  - 2
            var yearEnum = pastYear
            while  yearEnum < nextYear {
                yearEnum += 1
                detail.append(yearEnum)
            }
            print(detail)
            destViewController.yearArray = detail
            destViewController.title = "Выберите год выпуска"
        }
        if segue.identifier == "chooseClass" {
            let destViewController: DetailClassTableViewController! = segue.destination as! DetailClassTableViewController
            destViewController.recievedData = dataClass
            destViewController.title = "Выберите класс"
        }
        if segue.identifier == "chooseCity" {
            let destViewController: DetailCityTableViewController! = segue.destination as! DetailCityTableViewController
            destViewController.recievedData = dataCity
            destViewController.title = "Выберите город"
        }
        if segue.identifier == "showDiler" {
            if chooseCity.text == "Выберите город" {
                alert(message: "Пожалуйста, сначала выберите город", title: "Ошибка")
            }
            else {
            let destViewController: DetailDilerTableViewController! = segue.destination as! DetailDilerTableViewController
            destViewController.recievedData = dataDiler
            destViewController.title = "Выберите дилера"
            }
        }
    }
    func requestDataClass() {
        let headers: HTTPHeaders = [
            "Accept": "application/json"
        ]
        Alamofire.request("http://3plus-authless.test.intravision.ru/Classes", headers: headers)
            .validate(contentType: ["application/json"])
            .responseJSON { response in
                switch response.result {
                case .success:
                    print("Validation Successful")
                case .failure(let error):
                    print(error)
                }
                if let JSONArray = response.result.value {
                    //print("JSON: \(JSONArray)")
                    let json = JSON(JSONArray)
                    for results in json.arrayValue {
                        let name = results["name"].stringValue
                        self.dataClass.append(name)
                    }
                }
        }
    }
    func requestDataCity() {
        let headers: HTTPHeaders = [
            "Accept": "application/json"
        ]
        Alamofire.request("http://3plus-authless.test.intravision.ru/Cities", headers: headers)
            .validate(contentType: ["application/json"])
            .responseJSON { response in
                switch response.result {
                case .success:
                    print("Validation Successful")
                case .failure(let error):
                    print(error)
                }
                if let JSONArray = response.result.value {
                    //print("JSON: \(JSONArray)")
                    let json = JSON(JSONArray)
                    for results in json.arrayValue {
                        let name = results["name"].stringValue
                        self.dataCity.append(name)
                    }
                }
        }
    }
    func requestDataDiler() {
        let headers: HTTPHeaders = [
            "Accept": "application/json"
        ]
        Alamofire.request("http://3plus-authless.test.intravision.ru/ShowRooms", headers: headers)
            .validate(contentType: ["application/json"])
            .responseJSON { response in
                switch response.result {
                case .success:
                    print("Validation Successful")
                case .failure(let error):
                    print(error)
                }
                if let JSONArray = response.result.value {
                    //print("JSON: \(JSONArray)")
                    let json = JSON(JSONArray)
                    for results in json.arrayValue {
                        let name = results["name"].stringValue
                        self.dataDiler.append(name)
                        print(self.dataDiler)
                    }
                }
        }
    }

}
extension UIViewController {
    
    func alert(message: String, title: String = "") {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let OKAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(OKAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
}
