//
//  ViewController.swift
//  tableGCD
//
//  Created by Pham An on 5/25/17.
//  Copyright © 2017 Pham An. All rights reserved.
//

import UIKit

class ViewController: UIViewController ,UITableViewDataSource, UITableViewDelegate{

    @IBOutlet weak var tb_view: UITableView!
    var arrNumber:[Number] = []
    var arrImage:[UIImage] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tb_view.dataSource = self
        tb_view.delegate = self
        let url = URL(string: "http://khoapham.vn/KhoaPhamTraining/json/numbers.php")
        do {
            let data = try Data(contentsOf: url!)
            let jsarray = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as! [Dictionary<String, AnyObject>]
            for json in jsarray{
            let name = json["NAME"] as! String
            let image_url = json["URL"] as! String
                print (name)
                print (image_url)
            self.arrNumber.append(Number(t: name, h: image_url))
            self.arrImage.append(UIImage(named: "a")!)
            }
            loadImage()
            
        } catch  {
        print ("cant get data")
        }
        
        
    }
    func loadImage(){
        for i in 0..<arrNumber.count {
            let hd1 = DispatchQueue(label: "hd1")
            hd1.async {
                let u = URL(string: self.arrNumber[i].img_url)
                do
                {
                    let d = try Data(contentsOf: u!)
                    DispatchQueue.main.async {
                        self.arrImage[i] = UIImage(data: d)!
                        self.tb_view.reloadData()
                    }
                }  catch{}
            }
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CELL") as! DONGTableViewCell
        cell.lbl.text = arrNumber[indexPath.row].name
        cell.img.image = arrImage[indexPath.row]
        //let hd1 = DispatchQueue(label: "hd1")
      //  hd1.async {
      //      let u = URL(string: self.arrNumber[indexPath.row].img_url)
      //      do
      //      {
      //          let d = try Data(contentsOf: u!)
      //          DispatchQueue.main.async {
     //               cell.img.image = UIImage(data: d)
      //          }
     //       }  catch{}
    //    }
           return cell
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrNumber.count
    }


}

