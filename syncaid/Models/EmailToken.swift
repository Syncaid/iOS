

import Foundation



struct EmailToken: Codable {
    
    let _id:String?
    let userId:String?
    let token:String?
  
    
    
    
    enum CodingKeys: String, CodingKey {
        case _id
        case userId
        case token
       
        
   
    }
    
    
    
 
    
    init(_id:String,userId:String,token:String)
    {
        self._id = _id
        self.userId = userId
        self.token = token

        
        
    }
                
        }
    



