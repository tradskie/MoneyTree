//
//  API.swift
//  MoneyTree
//
//  Created by Jack Xiong Lim on 8/4/22.
//

import Foundation
import Alamofire
import RxAlamofire
import RxSwift
import SwiftyJSON

class API: APISuperClass {
    
    public static func request<T: Decodable>(sessionManager: Session = Session.default,
                                             _ method: HTTPMethod,
                                             _ urlString: String,
                                             headers: HTTPHeaders? = nil,
                                             parameters: [String: Any]? = nil,
                                             shouldShowLog: Bool = false) -> Single<T> {
        guard let url = URL(string: urlString) else {
            return Single.error(HTTPRequestError.invalidURL)
        }
        return sessionManager.rx
            .request(method,
                     url,
                     parameters: parameters,
                     encoding: method == .get ? URLEncoding.default : JSONEncoding.default,
                     headers: headers)
            .responseJSON()
            .do(onNext: { (dataResponse) in
                try httpErrorHandler(dataResponse: dataResponse)
            })
            .map { (dataResponse) -> T in
                guard let data = dataResponse.data else { throw HTTPRequestError.dataNotFound }
                var json: JSON!
                do {
                    json = try JSON(data: data)
                } catch {
                    json = JSON([String: Any]())
                }
                if shouldShowLog {
                    print(json ?? "")
                }
                if let jsonArray = json.array {
                    let modifiedJson: JSON = JSON(["data": jsonArray])
                    let modifiedJsonData = try modifiedJson.rawData(options: .prettyPrinted)
                    let payload = try JSONDecoder().decode(T.self, from: modifiedJsonData)
                    return payload
                } else {
                    let payload = try JSONDecoder().decode(T.self, from: data)
                    return payload
                }
                
            }
            .observe(on: MainScheduler.instance)
            .asSingle()
    }
    
    private static func httpErrorHandler(dataResponse: DataResponse<Any, AFError>) throws {
        guard let code = dataResponse.response?.statusCode, 200..<300 ~= code else {
            let statusCode = dataResponse.response?.statusCode ?? 0
            throw ApiError.requestFailed(statusCode)
            
        }
        
    }
    
}
