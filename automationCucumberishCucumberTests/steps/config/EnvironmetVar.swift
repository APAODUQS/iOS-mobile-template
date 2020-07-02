import Foundation

class EnvironmentVar {
    
    static let IP_SERVER = ExternalVariables().GET_IP_SERVER
    static var PORT_SERVER = "9090"
    
    public func setPort(port: String) {
        EnvironmentVar.PORT_SERVER = port
    }
    
}
