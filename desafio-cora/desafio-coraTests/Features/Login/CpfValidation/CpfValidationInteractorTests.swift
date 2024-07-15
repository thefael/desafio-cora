@testable import desafio_cora
import XCTest

final class CpfValidationInteractorTests: XCTestCase {
    func test_loadScreen_shouldCall_presentScreen() {
        let (presenter, sut) = makeSut()
        let expectedCallOrder = ["didCallPresentScreen"]
        var receivedCallOrder: [String] = []
        presenter.presentScreenAction = {
            receivedCallOrder.append(expectedCallOrder[0])
        }
        
        sut.loadScreen()
        
        XCTAssertEqual(receivedCallOrder, expectedCallOrder)
    }
    
    func test_validateCpf_whenCpfIsValid_shouldCall_presentPasswordValidationScreen() {
        let (presenter, sut) = makeSut()
        let validCpf = "12345678909"
        sut.cpfToValidate = validCpf
        let expectedCallOrder = ["didCallPresentPasswordValidationScreen"]
        var receivedCallOrder: [String] = []
        var receivedCpf: String?
        presenter.presentPasswordValidationScreenAction = {
            receivedCpf = $0
            receivedCallOrder.append(expectedCallOrder[0])
        }
        
        sut.validateCpf()
        
        XCTAssertEqual(receivedCallOrder, expectedCallOrder)
        XCTAssertEqual(receivedCpf, validCpf)
    }
    
    func test_validateCpf_whenCpfIsNotValid_shouldCall_presentPasswordValidationScreen() {
        let (presenter, sut) = makeSut()
        let invalidCpf = "12312312312"
        sut.cpfToValidate = invalidCpf
        let expectedCallOrder = ["didCallPresentHint"]
        var receivedCallOrder: [String] = []
        presenter.presentHintAction = {
            receivedCallOrder.append(expectedCallOrder[0])
        }
        
        sut.validateCpf()
        
        XCTAssertEqual(receivedCallOrder, expectedCallOrder)
    }
}

extension CpfValidationInteractorTests {
    func makeSut() -> (CpfValidationPresenterMock, CpfValidationInteractor) {
        let presenter = CpfValidationPresenterMock()
        let sut = CpfValidationInteractor(presenter: presenter)
        
        return (presenter, sut)
    }
}
