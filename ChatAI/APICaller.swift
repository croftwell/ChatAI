//
//  APICaller.swift
//  ChatAI
//
//  Created by Ali on 13.12.2022.
//

import OpenAISwift
import Foundation

final class APICaller {
    
    
    static let shared = APICaller()
    
    @frozen enum Constants {
        static let key = "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"
    }
    
    
    private var client: OpenAISwift?
    
    private init() {}
    
    public func setup(){
        self.client = OpenAISwift(authToken: Constants.key )
    }
    
    
    public func getResponse(input: String, completion: @escaping(Result< String, Error>) -> Void) {
        
        client?.sendCompletion(with: input, model: .codex(.davinci), completionHandler: {result in
            switch result {
            case .success(let model):
                print(String(describing: model.choices))
                let output = model.choices.first?.text ?? ""
                completion(.success(output))
            case.failure(let error):
                completion(.failure(error))
        }
        })
    }
}


