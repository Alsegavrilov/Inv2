//
//  Network.swift
//  Inv
//
//  Created by Александр Гаврилов on 23.02.2021.
//

import Foundation
import Alamofire

class Network {
    private let url = "https://api.github.com/search/repositories"
    
    func getRepoSearch(title: String, complitionHandler:@escaping (_ items: [Repos]?) -> ()) {
        
        let parameters : [String: String] = ["q": title]
        
        AF.request(url, parameters: parameters).validate().responseDecodable(of: GitHubAPIResponse.self) { response in
            switch response.result {
            case .failure(let error):
                print("error occured \(error)")

            case .success(let successResponse):
                print(successResponse)
                complitionHandler(response.value?.items)
                }

        }
    }
}
