import Foundation

class ConfigBuilder {
    
    var anyEntity = AnyEntity()

    
    func addAnyValue1(value: String) -> ConfigBuilder {
        anyEntity.anyField1 = value
        
        return self
    }
    
    func addAnyValue2(value: String) -> ConfigBuilder {
        anyEntity.anyField2 = value
        
        return self
    }
    
    func buildConfig() -> AnyEntity {
        var messageBody =  try! JSONEncoder().encode(anyEntity)
        
        return messageBody
    }
    
}
