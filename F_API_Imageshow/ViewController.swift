//
//  ViewController.swift
//  F_API_Imageshow
//
//  Created by apple on 2/17/20.
//  Copyright © 2020 apple. All rights reserved.
//

import UIKit
import AlamofireImage


class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
   
    
    var modeData = [MyModel]()
       var imageName = [String]()
       
    var newArrary = ["1","2","3"]

    @IBOutlet weak var Tableview: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    Tableview.rowHeight = 405
            
            // Do any additional setup after loading the view.
           
            loadData()
        }
        func loadData(){
        let url = URL(string: "https://jsonplaceholder.typicode.com/photos")
        URLSession.shared.dataTask(with: url!) { (data, response, error) in
            if error == nil {
                do{
                    let myData = try! JSONDecoder().decode([MyModel].self, from: data!)
                    
                    DispatchQueue.main.async {
                        for n in myData {
                            self.imageName.append(n.url)
                        }
                        print(self.imageName)
                        self.Tableview.reloadData()
                    }
                    
                }
                catch{
                    print(":( Nothing Found")
                        }
                    }
                    
        }.resume()
        }
   func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
               return imageName.count
           }
           
           func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
               let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! TableViewCell
               let url = URL (string: imageName[indexPath.row])
                     
                     DispatchQueue.global().async {
                         let data = try? Data(contentsOf: url! )
                         DispatchQueue.main.async {
                            cell.imageview.image = UIImage (data: data!)
                         }
                     }
               
    

                  cell.accessoryType = .disclosureIndicator
                           
                           return cell
                       }
}
