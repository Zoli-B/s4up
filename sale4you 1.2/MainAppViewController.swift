//
//  MainAppViewController.swift
//  sale4you 1.2
//
//  Created by Balaska Zoltán on 2022. 12. 25..
//

import UIKit

class MainAppViewController: UIViewController{
    
    @IBOutlet weak var SaleSearch: UISearchBar!
    
    @IBOutlet weak var SaleTable: UITableView!
    
    public var saleData = [API.Result]()
    
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        SaleTable.dataSource = self
        mainAPi.GetDataApi(completion: {data in
            self.saleData = data
            DispatchQueue.main.async {
                self.SaleTable.reloadData()
            }
        })
        
    }

}


//MARK: CustomCell
class CustomSaleDataCell: UITableViewCell{
    
    @IBOutlet weak var SaleIMG: UIImageView!
    @IBOutlet weak var CompNameAdress: UILabel!
    @IBOutlet weak var SaleProd: UILabel!
    @IBOutlet weak var SaleOldP: UILabel!
    @IBOutlet weak var SaleNewP: UILabel!
    @IBOutlet weak var SalePercentage: UILabel!
    

}




//MARK: TableView DataSource

extension MainAppViewController : UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return saleData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "saleCell", for: indexPath) as? CustomSaleDataCell else {
            return UITableViewCell()
        }
        
        self.SaleTable.rowHeight = 330
        
        cell.CompNameAdress.text = saleData[indexPath.row].address
        cell.SaleProd.text = saleData[indexPath.row].Description
        cell.SaleProd.numberOfLines = 0
        cell.SaleProd.sizeToFit()
        
        let parentWidth = cell.contentView.frame.width
        let imageWidth: CGFloat = 180
        let imageHeight: CGFloat = 180
        let imageX = (parentWidth - imageWidth) / 2
        
        cell.SaleIMG.contentMode = .scaleAspectFit
        cell.SaleIMG.frame = CGRect(x: imageX, y: 10, width: imageWidth, height: imageHeight)
        cell.SaleIMG.image = mainAPi.ConvertBase64StringToImage(imageBase64String: saleData[indexPath.row].img)
        cell.SaleIMG.layer.cornerRadius = imageWidth / 2
        cell.SaleIMG.clipsToBounds = true
        
        let saleProdY = cell.SaleIMG.frame.origin.y + cell.SaleIMG.frame.height + 10
        cell.SaleProd.frame = CGRect(x: 10, y: saleProdY, width: parentWidth - 20, height: 50)
        
        let saleOldPY = cell.SaleProd.frame.origin.y + cell.SaleProd.frame.height + 10
        cell.SaleOldP?.text = "Régi ár: " + String(saleData[indexPath.row].oldPrice) + " Ft"
        cell.SaleOldP?.frame = CGRect(x: 10, y: saleOldPY, width: parentWidth - 20, height: 20)
        
        let saleNewPY = cell.SaleOldP!.frame.origin.y + cell.SaleOldP!.frame.height + 5
        cell.SaleNewP?.text = "Akciós ár: " + String(saleData[indexPath.row].newPrice) + " Ft"
        cell.SaleNewP?.frame = CGRect(x: 10, y: saleNewPY, width: parentWidth - 20, height: 20)
        
        let salePercentY = cell.SaleNewP!.frame.origin.y + cell.SaleNewP!.frame.height + 5
        let salePercent = saleData[indexPath.row].oldPrice - saleData[indexPath.row].newPrice
        cell.SalePercentage.text = "Megtakírás: " + String(salePercent) + " Ft"
        cell.SalePercentage.frame = CGRect(x: 10, y: salePercentY, width: parentWidth - 20, height: 20)
        
        return cell
    }
    
}




