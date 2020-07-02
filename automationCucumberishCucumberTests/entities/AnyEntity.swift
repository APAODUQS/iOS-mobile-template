import Foundation

struct AnyEntity: Codable{
    var anyField1: String?
    var anyField2: String?
    
    init(){
        anyField1 = nil
        anyField2 = nil
    }
}
