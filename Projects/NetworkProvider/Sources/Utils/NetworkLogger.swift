//
//  NetworkLogger.swift
//  Network
//
//  Created by 김진웅 on 9/22/25.
//

import Foundation
import Alamofire

struct NetworkLogger: EventMonitor {
    func requestDidResume(_ request: Request) {
        guard let httpRequest = request.request else {
            print("--> 유효하지 않은 요청")
            return
        }
        
        let url = httpRequest.description
        let method = httpRequest.httpMethod ?? "메소드값이 nil입니다."
        let path = httpRequest.url?.path ?? "N/A"
        var log = "-----------------------------------------------------\n"
        log.append("1️⃣[\(method)]\n\(url)\n")
        log.append("-----------------------------------------------------\n")
        log.append("2️⃣API Path: \(path)\n")
        
        if let headers = httpRequest.allHTTPHeaderFields, !headers.isEmpty {
            log.append("header: \(headers)\n")
        }
        
        if let body = httpRequest.httpBody, let bodyString = String(
            bytes: body,
            encoding: String.Encoding.utf8
        ) {
            log.append("body: \(bodyString)\n")
        }
        
        log.append("---------------------- END \(method) ----------------------")
        print(log)
    }
    
    func request<Value>(_ request: DataRequest, didParseResponse response: DataResponse<Value, AFError>) {
        let url = response.request?.url?.absoluteString ?? "nil"
        let path = response.request?.url?.path ?? "N/A"
        let statusCode = response.response?.statusCode ?? 0
        
        switch response.result {
        case .success:
            var log = "---------------- ✅ Response Succeeded ✅ --------------\n"
            log.append("3️⃣[\(statusCode)] \(url)\n")
            log.append("API Path: \(path)\n")
            log.append("Status Code: [\(statusCode)]\n")
            log.append("URL: \(url)\n")
            log.append("response: \(String(describing: response.value))\n")
            log.append("------------------------ END HTTP ------------------------")
            print(log)
            
        case .failure(let error):
            var log = "------------------ ❌ Response Failed ❌ -----------------\n"
            log.append("API Path: \(path)\n")
            log.append("URL: \(url)\n")
            log.append("Status Code: \(statusCode)\n")
            log.append("Error: \(error)\n")
            log.append("Description: \(error.localizedDescription)\n")
            log.append("----------------------- END HTTP -----------------------")
            print(log)
        }
    }
}
