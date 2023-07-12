//
//  API.swift
//  sale4you 1.2
//
//  Created by Balaska Zoltán on 2022. 12. 23..
//

import Foundation
import UIKit


//MARK: APICall CustomerReg POST


var mainAPi = API()

class API {

    func apiCallCustomerReg(firstname: String, lastname: String, password: String, email: String){
            
            guard let url = URL(string: "http://192.168.1.138:5010/userc/create") else {
                return
            }
            
            var request = URLRequest(url: url)
            
            request.httpMethod = "POST"
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            let body: [String: AnyHashable] = [
                "roleId": 1,
                "firstname": firstname,
                "lastname":  lastname,
                "password":  password,
                "email":     email
            ]
            

            
            request.httpBody = try? JSONSerialization.data(withJSONObject: body, options: .fragmentsAllowed)
            
            
            let task = URLSession.shared.dataTask(with: request) { data, _, error in
                guard let data = data, error == nil else {
                    print(data)
                    return
                }
                do{
                    let response = try JSONSerialization.jsonObject(with: data, options: .fragmentsAllowed)
                    print(response)
                }
                catch{
                    print(error)
                }
            }
            task.resume()
            
        }
    
//MARK: APILOGIN POST
    func login (email: String, password: String){
        
        guard let url = URL(string: "http://192.168.1.138:5010/userc/login") else {
            return
        }
        
        var request = URLRequest(url: url)
        
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let body: [String: AnyHashable] = [
            "password":  password,
            "email":     email
        ]
        

        
        request.httpBody = try? JSONSerialization.data(withJSONObject: body, options: .fragmentsAllowed)
        
        
        let task = URLSession.shared.dataTask(with: request) { data, _, error in
            guard let data = data, error == nil else {
                print(data)
                return
            }
            do{
                let response = try JSONSerialization.jsonObject(with: data, options: .fragmentsAllowed)
                print(response)
            }
            catch{
                print(error)
            }
        }
        task.resume()
        
    }
    
    
//MARK: Change Pass POST
    func changepass(oldpass: String, newpass: String){
        
        guard let url = URL(string: "http://192.168.1.138:5010/userc/changepass") else {
            return
        }
        
        var request = URLRequest(url: url)
        
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let body: [String: AnyHashable] = [
            "oldpass":  oldpass,
            "newpass":  newpass
        ]
        

        
        request.httpBody = try? JSONSerialization.data(withJSONObject: body, options: .fragmentsAllowed)
        
        
        let task = URLSession.shared.dataTask(with: request) { data, _, error in
            guard let data = data, error == nil else {
                print(data)
                return
            }
            do{
                let response = try JSONSerialization.jsonObject(with: data, options: .fragmentsAllowed)
                print(response)
            }
            catch{
                print(error)
            }
        }
        task.resume()

        
    }
    
//MARK: Sale POST
    
    func createSale(des: String, picture: String, oldPrice: Int, newPrice: Int){
        
        guard let url = URL(string: "http://192.168.1.138:5010/sale/create") else {
            return
        }
        
        var request = URLRequest(url: url)
        
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let body: [String: AnyHashable] = [
            "Description":  des,
            "Picture":  picture,
            "OldPrice": oldPrice,
            "NewPrice": newPrice
        ]
        

        
        request.httpBody = try? JSONSerialization.data(withJSONObject: body, options: .fragmentsAllowed)
        
        
        let task = URLSession.shared.dataTask(with: request) { data, _, error in
            guard let data = data, error == nil else {
                print(data)
                return
            }
            do{
                let response = try JSONSerialization.jsonObject(with: data, options: .fragmentsAllowed)
                print(response)
            }
            catch{
                print(error)
            }
        }
        task.resume()
        
    }
    
//MARK: Sale API GET
    
    
    struct Say: Codable {
        let result: [Result]
    }

    struct Result: Codable {
        let address, Description, marketing, img: String
        let newPrice, oldPrice: Int
        

        enum CodingKeys: String, CodingKey {
            case address = "Address"
            case Description  = "Description"
            case newPrice = "NewPrice"
            case oldPrice = "OldPrice"
            case marketing = "Marketing"
            case img = "Picture"
        }
    }
    
    


    func GetDataApi(completion: @escaping ([Result])->()){
        guard let url = URL(string: "http://192.168.1.138:5010/sales/list") else{return}

        let task = URLSession.shared.dataTask(with: url){
            data, response, error in
            
            let decoder = JSONDecoder()

            if let data = data{
                do{
                    let say = try JSONDecoder().decode(Say.self, from: data)
                    completion(say.result)
                  
                }catch{
                    print(error)
                }
            }
        }
        task.resume()

    }
    
//MARK: Base64 to IMG
    
    func ConvertBase64StringToImage (imageBase64String:String) -> UIImage {
        let imageData = Data.init(base64Encoded: imageBase64String, options: .init(rawValue: 0))
        let image = UIImage(data: imageData!)
        return image!
    }
    
}

