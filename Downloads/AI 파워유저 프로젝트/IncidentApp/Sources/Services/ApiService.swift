import Foundation
import Combine

enum WorkflowType: String {
    case failureClassification = "Failure classification"
    case assignContact = "Assign"
    case successMessage = "Successful message"
}

class ApiService: ObservableObject {
    static let shared = ApiService()
    
    @Published var currentServer: ApiServer = .miso
    
    private var baseURL: String {
        return currentServer.baseURL
    }
    
    private var authToken: String {
        return currentServer.authToken
    }
    
    private init() {}
    
    struct ApiRequest: Codable {
        let inputs: Inputs
        let responseMode: String = "blocking"
        let user: String = "abc-123"
        
        struct Inputs: Codable {
            let inputData: String
            let selectWf: String
            
            enum CodingKeys: String, CodingKey {
                case inputData = "input_data"
                case selectWf = "select_wf"
            }
        }
        
        enum CodingKeys: String, CodingKey {
            case inputs
            case responseMode = "response_mode"
            case user
        }
    }
    
    struct ApiResponse: Decodable {
        let status: String?
        let message: String?
        let data: [String: String]?
    }
    
    enum ApiError: LocalizedError {
        case invalidURL
        case networkError(String)
        case decodingError
        case serverError(String)
        
        var errorDescription: String? {
            switch self {
            case .invalidURL:
                return "잘못된 URL입니다."
            case .networkError(let message):
                return "네트워크 오류: \(message)"
            case .decodingError:
                return "응답 데이터 처리 오류"
            case .serverError(let message):
                return "서버 오류: \(message)"
            }
        }
    }
    
    func callWorkflow(inputData: String, workflowType: WorkflowType) async throws -> ApiResponse {
        // Log the current server being used
        print("🌐 Using Server: \(currentServer.displayName)")
        print("📍 URL: \(baseURL)")
        print("🔑 Token: \(authToken.prefix(20))...")
        
        guard var urlComponents = URLComponents(string: baseURL) else {
            throw ApiError.invalidURL
        }
        
        // Query parameters
        urlComponents.queryItems = [
            URLQueryItem(name: "Authorization", value: authToken),
            URLQueryItem(name: "Content-Type", value: "application/json")
        ]
        
        guard let url = urlComponents.url else {
            throw ApiError.invalidURL
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue(authToken, forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let apiRequest = ApiRequest(
            inputs: ApiRequest.Inputs(
                inputData: inputData,
                selectWf: workflowType.rawValue
            )
        )
        
        do {
            let encoder = JSONEncoder()
            encoder.outputFormatting = .prettyPrinted
            request.httpBody = try encoder.encode(apiRequest)
            
            // 디버깅: 전송할 JSON 데이터 출력
            if let jsonString = String(data: request.httpBody ?? Data(), encoding: .utf8) {
                print("📡 API 요청 JSON:")
                print(jsonString)
                print("---")
            }
            
            let (data, response) = try await URLSession.shared.data(for: request)
            
            if let httpResponse = response as? HTTPURLResponse {
                if httpResponse.statusCode != 200 {
                    throw ApiError.serverError("상태 코드: \(httpResponse.statusCode)")
                }
            }
            
            // Try to decode response, but don't fail if it's not in expected format
            if let responseData = try? JSONDecoder().decode(ApiResponse.self, from: data) {
                return responseData
            } else {
                // Return a default success response if we can't decode
                return ApiResponse(status: "success", message: nil, data: nil)
            }
            
        } catch is DecodingError {
            throw ApiError.decodingError
        } catch let error as ApiError {
            throw error
        } catch {
            throw ApiError.networkError(error.localizedDescription)
        }
    }
}