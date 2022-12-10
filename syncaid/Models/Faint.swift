
import Foundation


struct Faint: Codable {
    
    var _id:String
    var UserId:String
    var Duration : String
    var Time:String
    
    
    enum CodingKeys: String, CodingKey {
        case _id
        case UserId
        case Duration
        case Time

    }

    init(_id:String,UserId:String,Duration:String,Time:String)
    {
        self._id=_id
        self.UserId=UserId
        self.Duration = Duration
        self.Time=Time
   
    }
                
        }
    


