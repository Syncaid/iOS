import Foundation


struct User: Codable {
    
    let _id:String?
    let FirstName:String?
    let LastName:String?
    let Age : String?
    let Gender : String?
    let Tel : String?
    let Email : String?
    let Password : String
    let token : String?
    let Role : String?
    let Verified : Bool?
    let vString:String?
    
    
    
    enum CodingKeys: String, CodingKey {
        case _id
        case FirstName
        case LastName
        case Age
        case Gender
        case Tel
        case Email
        case Password
        case token
        case Role
        case Verified
        case vString
        
   
    }
    
    
    
 
    
    init(_id:String,FirstName:String,LastName:String,Age:String,Gender:String,Tel:String,Email:String,Password:String
         ,Role:String,ProfilePhoto:String,Verified:Bool,vString:String,token:String)
    {
        self._id=_id
        self.FirstName=FirstName
        self.LastName=LastName
        self.Age = Age
        self.Gender = Gender
        self.Tel = Tel
        self.Email = Email
        self.Password = Password
        self.token = token
        self .Role = Role
        self.Verified = Verified
        self.vString = vString
        
        
    }
                
        }
    



