import Foundation

public struct Credential: Encodable {
    let cpf: String
    let password: String
    
    public init(cpf: String, password: String) {
        self.cpf = cpf
        self.password = password
    }
}

func toData<T: Encodable>(_ t: T) -> Data? {
    try? JSONEncoder().encode(t)
}

