import CoraNetwork

protocol ExtractDetailServicing {
    func getDetail(usingId id: String) async throws -> ExtractDetail
}

final class ExtractDetailService: ExtractDetailServicing {
    let requestManager: RequestManager = .default
    
    func getDetail(usingId id: String) async throws -> ExtractDetail {
        try await requestManager.execute(endpoint: CoraEndpoint.extractDetail(id: id))
    }
}

struct ExtractDetail: Decodable {
    let description: String
    let label: String
    let amount: Int
    let counterPartyName: String
    let dateEvent: String
    let recipient: AccountDetail
    let sender: AccountDetail
    
    struct AccountDetail: Decodable {
        let bankName: String
        let documentNumber: String
        let documentType: DocumentType
        let accountNumber: String
        let accountNumberDigit: String
        let agencyNumber: String
        let agencyNumberDigit: String
        let name: String
        
        enum DocumentType: String, Decodable {
            case cpf = "CPF"
            case cnpj = "CNPJ"
        }
    }
}

