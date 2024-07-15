@testable import desafio_cora
import XCTest
import CoraNetwork

final class PasswordValidationInteractorTests: XCTestCase {
    func test_loadScreen_shouldCall_presentScreen() {
        let (doubles, sut) = makeSut(cpf: "12345678909")
        let expectedCallOrder = ["didCallPresentScreen"]
        var receivedCallOrder: [String] = []
        doubles.presenter.presentScreenAction = {
            receivedCallOrder.append(expectedCallOrder[0])
        }
        
        sut.loadScreen()
        
        XCTAssertEqual(receivedCallOrder, expectedCallOrder)
    }
    func test_login_whenSucceeds_shouldStoreCallAccessToken_andPresentExtractScreen() {
        let (doubles, sut) = makeSut(cpf: "12345667809")
        let expectation1 = expectation(description: "didCallStore")
        let expectation2 = expectation(description: "didCallPresent")
        doubles.repository.storeAction = { storedToken, _ in
            XCTAssertEqual(storedToken, .fixture())
            expectation1.fulfill()
        }
        doubles.presenter.presentExtractScreenAction = {
            expectation2.fulfill()
        }
        doubles.service.authenticateAction = { _ in .fixture() }
        
        sut.login(password: "123456")
        
        wait(for: [expectation1, expectation2], timeout: 0.1)
    }
    
    func test_login_whenThrowsUnauthorized_shouldCallPresentAlert_withCorrectValues() {
        let (doubles, sut) = makeSut(cpf: "12345667809")
        let expectation = expectation(description: "didCallPresentAlert")
        doubles.presenter.presentAlertAction = {
            XCTAssertEqual($0, "Algo deu errado")
            XCTAssertEqual($1, "Suas credenciais estão incorretas.")
            expectation.fulfill()
        }
        doubles.service.authenticateAction = { _ in throw ApiError.unauthorized }
        
        sut.login(password: "123456")
        
        wait(for: [expectation], timeout: 0.1)
    }
    
    func test_login_whenThrowsGenericError_shouldCallPresentAlert_withCorrectValues() {
        let (doubles, sut) = makeSut(cpf: "12345667809")
        let expectation = expectation(description: "didCallPresentAlert")
        doubles.presenter.presentAlertAction = {
            XCTAssertEqual($0, "Algo deu errado")
            XCTAssertEqual($1, "Não foi possível realizar essa operação.")
            expectation.fulfill()
        }
        doubles.service.authenticateAction = { _ in throw ApiError.badRequest }
        
        sut.login(password: "123456")
        
        wait(for: [expectation], timeout: 0.1)
    }
}

extension PasswordValidationInteractorTests {
    class Doubles {
        let presenter = PasswordValidationPresenterMock()
        let service = PasswordValidationServiceMock()
        let repository = RepositoryMock<AccessToken>()
    }
    
    func makeSut(cpf: String) -> (Doubles, PasswordValidationInteractor) {
        let doubles = Doubles()
        let interactor = PasswordValidationInteractor(
            cpf: cpf,
            presenter: doubles.presenter,
            service: doubles.service,
            repository: doubles.repository,
            timeStamp: nil
        )
        return (doubles, interactor)
    }
}
