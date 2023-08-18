
@testable import FeatureLoading

final class DataStorageProtocolMock: DataStorageProtocol {
    
    var invokedFetchData = false
    var invokedFetchDataCount = 0
    var stubbedFetchDataResult: [FeatureLoading.DataModel]! = []
    
    func fetchData() -> [FeatureLoading.DataModel] {
        invokedFetchData = true
        invokedFetchDataCount += 1
        return stubbedFetchDataResult
    }
}
