//
//  CryptoServiceSpy.swift
//  CryptoListTests
//
//  Created by abdul ahad  on 14/02/22.
//

@testable import CryptoList

class CryptoServiceSpy: CryptoLoader {
    
    private(set) var loadCryptoCount = 0
    private let result: Result<[Coin], Error>
    
    init(result: [Coin] = []){
        self.result = .success(result)
    }
    
    init(result: Error){
        self.result = .failure(result)
    }
    
    func load(completion: @escaping (Result<[Coin], Error>) -> Void) {
        loadCryptoCount += 1
        completion(result)
    }
    
}
