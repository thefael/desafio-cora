import CoraNetwork

struct ExtractList: Decodable {
    let results: [Section]
    
    struct Section: Decodable {
        let items: [Item]
        let date: String
        
        struct Item: Decodable {
            let description: String
            let label: String
            let name: String
            let amount: Int
            let dateEvent: String
            let entry: Entry
            
            enum Entry: String, Decodable {
                case debit = "DEBIT"
                case credit = "CREDIT"
            }
        }
    }
}

extension ExtractList {
    var allItems: [Section.Item] {
        results.flatMap { $0.items }
    }
}

protocol ExtractServicing {
    func getList() async throws -> ExtractList
}

final class ExtractService: ExtractServicing {
    let requestManager: RequestManager = .default
    
    func getList() async throws -> ExtractList {
        try await requestManager.execute(endpoint: CoraEndpoint.extract())
    }
}
