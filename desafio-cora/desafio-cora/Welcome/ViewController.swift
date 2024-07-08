import UIKit
import CoraNetwork

class ViewController: UIViewController {
    let requestManager = RequestManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
        Task {
            await tentar()
        }
    }
    
    func tentar() async {
        do {
            let ess: Access = try await requestManager.execute(endpoint: CoraEndpoint.auth(credential: .init(cpf: "12345678909", password: "123456")))
            print(ess)
        } catch {
            print(error)
        }
    }
}

struct Access: Decodable {
    let token: String
}

