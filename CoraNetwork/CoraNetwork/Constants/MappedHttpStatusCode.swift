struct MappedHttpStatusCode {
    enum Success: Int {
        case ok = 200
    }
    
    enum ClientError: Int {
        case unauthorized = 401
    }
}
