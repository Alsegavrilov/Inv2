//
//  Model.swift
//  Inv
//
//  Created by Александр Гаврилов on 23.02.2021.
//

import Foundation

struct GitHubAPIResponse {
    let items: [Repos]
}

extension GitHubAPIResponse: Decodable {
    private enum GitHubAPIResponseCodingKey: String,CodingKey {
        case items
    }
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: GitHubAPIResponseCodingKey.self)
        items = try container.decode([Repos].self, forKey: .items)
    }
}

struct Repos {
    let id: Int
    let name: String?
    let url: String?
    let specification: String?
    let language: String?

}

    extension Repos: Decodable {
        private enum ReposCodingKey: String, CodingKey {
            case id
            case name
            case url = "html_url"
            case specification = "description"
            case language
        }
        init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: ReposCodingKey.self)
            id = try container.decode(Int.self, forKey: .id)
            name = try container.decode(String?.self, forKey: .name)
            url = try container.decode(String?.self, forKey: .url)
            specification = try container.decode(String?.self, forKey: .specification)
            language = try container.decode(String?.self, forKey: .language)
        }
    }

