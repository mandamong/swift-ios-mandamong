import Foundation

public extension NetworkError {

    // MARK: - RequestError
    enum RequestError: Error, LocalizedError {
        case invalidURL(String)
        case networkUnavailable
        case parameterEncodingFailed(underlyingError: Error)
        case multipartEncodingFailed(underlyingError: Error)
        case jsonBodyEncodingFailed(underlyingError: Error)
        
        public var errorDescription: String? {
            switch self {
            case .invalidURL(let url):
                return "유효하지 않은 URL입니다: \(url)"
            case .networkUnavailable:
                return "네트워크 연결이 없습니다."
            case .parameterEncodingFailed(let error):
                return "요청 파라미터 인코딩에 실패했습니다: \(error.localizedDescription)"
            case .multipartEncodingFailed(let error):
                return "멀티파트 데이터 인코딩에 실패했습니다: \(error.localizedDescription)"
            case .jsonBodyEncodingFailed(let error):
                return "JSON 바디 인코딩에 실패했습니다: \(error.localizedDescription)"
            }
        }
    }
}