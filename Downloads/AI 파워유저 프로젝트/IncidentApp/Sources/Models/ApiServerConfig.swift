import Foundation

enum ApiServer: String, CaseIterable {
    case miso = "MISO Server"
    case dify = "Dify Server"
    
    var displayName: String {
        return self.rawValue
    }
    
    var baseURL: String {
        switch self {
        case .miso:
            return "https://gateway.ax.gsretail.com/ext/v1/workflows/run"
        case .dify:
            return "http://dify.zipsa.shop/v1/workflows/run"
        }
    }
    
    var authToken: String {
        switch self {
        case .miso:
            return "Bearer app-k8FUR7kRwF239RLgBWH9b5JE"
        case .dify:
            return "Bearer app-CCJsaEYtgGCnY8HDa8qtP8h8"
        }
    }
}