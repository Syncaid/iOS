//
//  FaintViewModel.swift
//  syncaid
//
//  Created by AhmedFatma on 30/11/2022.
//

import Foundation
import Alamofire

class FaintViewModel:ObservableObject{
    
    @Published var UserFaints = [Faint]()
    
    func AddFaints (ID:String, Duration: String,Time: String, onSuccess: @escaping () -> Void ,onFailure: @escaping (_ errorMessage: String) -> Void ) {
        
        
        
        AF.request(Variables.DEVURL+"/faint", method: .post,
                   
                   parameters : ["UserId": ID, "Duration": Duration,"Time": Time ] ,encoding: JSONEncoding.default)
        .validate()
        .responseDecodable(of: Faint.self){
            (response) in

            switch response.result {
                
            case .success(let res):
                self.UserFaints.insert(res, at: 0)
                print("Faint added successful")
                onSuccess()
                
            case .failure(let err):
                onFailure(err.errorDescription!)
                print("Faint add failed",err)
                return
            }
        }
    }
    
    
    
    func getFaintsByUser (id : String,onSuccess: @escaping () -> Void ,onFailure: @escaping (_ errorMessage: String) -> Void ) {

        AF.request(Variables.DEVURL+"/faint/byUserId/"+id, method: .get,
                   
                   encoding: JSONEncoding.prettyPrinted)
       
        .responseDecodable(of: [Faint].self ) {
            (response) in
          
            switch response.result {
                
            case .success(let res):
                
                self.UserFaints = res
              
                print("Get faints successful")
            
                onSuccess()
                
                
            case .failure(let err):
                onFailure(err.errorDescription!)
                print("Get faints failed",err)
                return
            }
        }
    }
    func DeleteFaint (id : String,onSuccess: @escaping () -> Void ,onFailure: @escaping (_ errorMessage: String) -> Void ) {
       
        AF.request(Variables.DEVURL+"/faint/"+id, method: .delete,
                   
                   encoding: JSONEncoding.prettyPrinted)
       
        .responseDecodable(of: Faint.self) {
            (response) in
          
            switch response.result {
                
            case .success(_):
        
                print("Delete faints successful")
                 
                onSuccess()
                
                
            case .failure(let err):
                onFailure(err.errorDescription!)
                print("Delete faints failed",err)
                return
            }
        }
    }
    
    
    
    
    
    
    
}




