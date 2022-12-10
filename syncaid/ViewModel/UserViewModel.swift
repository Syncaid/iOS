
import Foundation
import Alamofire

class UserViewModel:ObservableObject{
    
    @Published var UserGuardians = [User]()

    
    func Login (Email:String,Password:String,onSuccess: @escaping () -> Void ,onFailure: @escaping (_ errorMessage: String) -> Void ) {
        
        
        
        AF.request(Variables.DEVURL+"/user/login" , method: .post,
                   
                   parameters : ["Email":Email,"Password": Password] ,encoding: JSONEncoding.default)
        .validate()
        .responseDecodable(of: User.self) {
            (response) in
            //Error handling
            switch response.result {
            case .success(let res):
                
                
                print("Login successful")
                let defaults = UserDefaults.standard
                defaults.set(res._id, forKey: "ID")
                defaults.set(res.FirstName, forKey: "FIRSTNAME")
                defaults.set(res.LastName, forKey: "LASTNAME")
                defaults.set(res.Email, forKey: "EMAIL")
                defaults.set(res.Tel, forKey: "TEL")
                
                defaults.set(res.Role, forKey: "ROLE")
                defaults.set(res.Verified, forKey: "VERIFIED")
                defaults.set(res.vString, forKey: "VSTRING")
                defaults.set(res.Age, forKey: "AGE")
                defaults.synchronize()
                
               
                    onSuccess()
             
             
                
                
                
            case .failure(let err):
                onFailure(err.localizedDescription)
                print("Login failed",err)
                return
            }
            
            
            
        }
        
        
    }
    
    
    func Register (FirstName:String,LastName:String,Email:String,Password:String,onSuccess: @escaping () -> Void ,onFailure: @escaping (_ errorMessage: String) -> Void ) {
        
        
        AF.request(Variables.DEVURL+"/user/register" , method: .post,
                   
                   parameters : ["FirstName":FirstName,"LastName":LastName,"Email":Email,"Password":Password] ,encoding: JSONEncoding.default)
        .validate()
        .responseDecodable(of: User.self) {
            (response) in
            //Error handling
            switch response.result {
            case .success(let res):
                print("Register successful")
                let defaults = UserDefaults.standard
                defaults.set(res._id, forKey: "ID")
                
                defaults.set(res.Email, forKey: "RegisteredEmail")
                defaults.set(Password, forKey: "RegisteredPassword")
                defaults.synchronize()
                AF.request(Variables.DEVURL+"/user/verificationemail", method: .post, parameters: ["Email":res.Email!] , encoding: JSONEncoding.default)
                    .validate()
                    .responseDecodable(of: EmailToken.self) {
                        (response) in
                        switch response.result {
                        case .success(_):
                            print("Verification email sent")
                        case .failure(let err):
                            onFailure(err.localizedDescription)
                            print("Email sending failed",err)
                        }
                    }
                onSuccess()
                
            case .failure(let err):
                onFailure(err.localizedDescription)
                print("Register failed",err)
                return
            }
            
        }
        
        
    }
    
    func Register2 (ID:String,Age:String,Gender:String,Tel:String,Role:String,onSuccess: @escaping () -> Void ,onFailure: @escaping (_ errorMessage: String) -> Void ) {
        
        
        
        AF.request(Variables.DEVURL+"/user/update/"+ID, method: .put,
                   
                   parameters : ["Gender":Gender,"Age":Age,"Tel":Tel,"Role":Role] ,encoding: JSONEncoding.default)
        .validate()
        .responseDecodable(of: User.self) {
            (response) in
          switch response.result {
                
          case .success(_):
                
                print("Register 2 successful")
                onSuccess()
                
            case .failure(let err):
                onFailure(err.errorDescription!)
                print("Register 2 failed",err)
                return
            }
            
        }
        
        
    }
    
    
    
    func SendOTP(Email:String,onSuccess: @escaping () -> Void ,onFailure: @escaping (_ errorMessage: String) -> Void) {
        AF.request(Variables.DEVURL+"/user/passwordemail", method: .post, parameters: ["Email":Email] , encoding: JSONEncoding.default)
            .validate()
            .responseDecodable(of: String.self) {
                (response) in
                switch response.result {
                case .success(let res):
                    let defaults = UserDefaults.standard
                    defaults.set(res, forKey: "OTP")
                    defaults.synchronize()
                    print("OTP sending successful")
                    onSuccess()
                    
                case .failure(let err):
                    onFailure(err.errorDescription!)
                    print("OTP sending failed",err)
                    return
                    
                }
            }
        
    }
    
    func VerifyOTP(Email:String,Password:String,vString:String,onSuccess: @escaping () -> Void ,onFailure: @escaping (_ errorMessage: String) -> Void ) {
        AF.request(Variables.DEVURL+"/user/resetpassword", method: .post, parameters: ["Email":Email,"Password":Password,"vString":vString] , encoding: JSONEncoding.default)
            .validate()
            .responseDecodable(of: User.self) {
                (response) in
                switch response.result {
                    
                case .success(_):
                    
                    
                    
                    print("Reset password successful")
                    onSuccess()
                    
                case .failure(let err):
                    onFailure(err.errorDescription!)
                    print("Reset password failed",err)
                    return
                }
                
            }
        
    }
    
    
    func Logout (id: String, onSuccess: @escaping () -> Void ,onFailure: @escaping (_ errorMessage: String) -> Void )
    {
        
        
        AF.request(Variables.DEVURL+"/user/logout/"+id, method: .post, encoding: JSONEncoding.default)
            .validate()
            .responseDecodable(of: User.self) {
                (response) in
                switch response.result {
                    
                case .success(_):
                    print("Logout successful")
                    onSuccess()
                    
                case .failure(let err):
                    onFailure(err.errorDescription!)
                    print("Logout failed",err)
                    return
                }
                
            }
        
    }
    
    
    func editprofile (ID:String,Firstname:String,Lastname:String,Tel:String,Age:String,onSuccess: @escaping () -> Void ,onFailure: @escaping (_ errorMessage: String) -> Void ) {
        
        
        
        AF.request(Variables.DEVURL+"/user/update/"+ID, method: .put,
                   
                   parameters : ["FirstName":Firstname,"LastName":Lastname,"Tel":Tel,"Age":Age] ,encoding: JSONEncoding.default)
        .validate()
        .responseDecodable(of: User.self) {
            (response) in
            //Error handling
            
            switch response.result {
                
            case .success(_):
                
                print("Update successful")
                onSuccess()
                
            case .failure(let err):
                onFailure(err.errorDescription!)
                print("Update failed",err)
                return
            }
            
        }
        
        
    }
 
    func getGuardians (ID:String,onSuccess: @escaping () -> Void ,onFailure: @escaping (_ errorMessage: String) -> Void ) {
        
        
        
        AF.request(Variables.DEVURL+"/user/getGuardians/"+ID, method: .get
                   
                   ,encoding: JSONEncoding.default)
        .validate()
        .responseDecodable(of: [User].self) {
            (response) in
            //Error handling
            
            switch response.result {
                
            case .success(let res):
                
                self.UserGuardians = res
                
                print("Update successful")
                onSuccess()
                
            case .failure(let err):
                onFailure(err.errorDescription!)
                print("Update failed",err)
                return
            }
            
        }
        
        
    }
    
    func deleteGuardian (userId:String,guardianId:String,onSuccess: @escaping () -> Void ,onFailure: @escaping (_ errorMessage: String) -> Void ) {
        
        
        
        AF.request(Variables.DEVURL+"/user/deleteGuardian/"+userId, method: .post
                   ,parameters: ["id":guardianId]
                   ,encoding: JSONEncoding.default)
        .validate()
        .responseDecodable(of: User.self) {
            (response) in
            //Error handling
            
            switch response.result {
                
            case .success(_):
                
                
                
                print("Guardian delete successful")
                onSuccess()
                
            case .failure(let err):
                onFailure(err.errorDescription!)
                print("Guardian delete failed",err)
                return
            }
            
        }
        
        
    }
    
    func GoogleLogin (Email:String,onSuccess: @escaping () -> Void ,onFailure: @escaping (_ errorMessage: String) -> Void ) {
        
        
        
        AF.request(Variables.DEVURL+"/user/googlelogin" , method: .post,
                   
                   parameters : ["Email":Email] ,encoding: JSONEncoding.default)
        .validate()
        .responseDecodable(of: User.self) {
            (response) in
            //Error handling
            switch response.result {
            case .success(let res):
                
                
                print("Login successful");
                let defaults = UserDefaults.standard
                defaults.set(res._id, forKey: "ID")
                defaults.set(res.FirstName, forKey: "FIRSTNAME")
                defaults.set(res.LastName, forKey: "LASTNAME")
                defaults.set(res.Email, forKey: "EMAIL")
                defaults.set(res.Tel, forKey: "TEL")
                
                defaults.set(res.Role, forKey: "ROLE")
                defaults.set(res.Verified, forKey: "VERIFIED")
                defaults.set(res.vString, forKey: "VSTRING")
                defaults.set(res.Age, forKey: "AGE")
                defaults.synchronize()
                
                 onSuccess()
                
             
                
                
                
            case .failure(let err):
                onFailure(err.localizedDescription)
                print("Login failed",err)
                return
            }
            
            
            
        }
        
        
    }
    
    
    
    
    
}
    
    
    
    
    
 

     
   
    
    
    
    
    
 

     
    
    

