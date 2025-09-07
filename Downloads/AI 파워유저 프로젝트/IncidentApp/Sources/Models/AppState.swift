import Foundation
import SwiftUI
import Combine

enum AppPhase {
    case phase1Input
    case phase2Reception
    case phase3Processing
    case phase4Completion
}

@MainActor
class AppState: ObservableObject {
    @Published var currentPhase: AppPhase = .phase1Input
    @Published var incidentDescription: String = ""
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?
    @Published var showError: Bool = false
    
    // 현재 처리 중인 장애 내용을 별도로 저장 (View에서 읽기 가능)
    @Published var currentIncidentData: String = ""
    
    // API Server selection
    @Published var selectedServer: ApiServer = .miso {
        didSet {
            apiService.currentServer = selectedServer
        }
    }
    
    private let apiService = ApiService.shared
    
    func reset() {
        currentPhase = .phase1Input
        incidentDescription = ""
        currentIncidentData = ""  // 저장된 데이터도 초기화
        isLoading = false
        errorMessage = nil
        showError = false
    }
    
    func registerIncident() async {
        guard !incidentDescription.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else {
            showErrorMessage("장애 내용을 입력해주세요.")
            return
        }
        
        // Phase 1에서 입력받은 데이터를 저장
        currentIncidentData = incidentDescription
        
        isLoading = true
        
        print("📤 Phase 1 - 장애 등록")
        print("   입력 데이터: \(currentIncidentData)")
        print("   워크플로우: Failure classification")
        
        do {
            _ = try await apiService.callWorkflow(
                inputData: currentIncidentData,
                workflowType: .failureClassification
            )
            currentPhase = .phase2Reception
        } catch {
            showErrorMessage(error.localizedDescription)
        }
        
        isLoading = false
    }
    
    func confirmReception() async {
        isLoading = true
        
        print("📤 Phase 2 - 담당자 접수")
        print("   입력 데이터: \(currentIncidentData)")
        print("   워크플로우: Assign")
        
        do {
            _ = try await apiService.callWorkflow(
                inputData: currentIncidentData,  // 저장된 데이터 사용
                workflowType: .assignContact
            )
            currentPhase = .phase3Processing
        } catch {
            showErrorMessage(error.localizedDescription)
        }
        
        isLoading = false
    }
    
    func completeProcessing() async {
        isLoading = true
        
        print("📤 Phase 3 - 처리 완료")
        print("   입력 데이터: \(currentIncidentData)")
        print("   워크플로우: Successful message")
        
        do {
            _ = try await apiService.callWorkflow(
                inputData: currentIncidentData,  // 저장된 데이터 사용
                workflowType: .successMessage
            )
            currentPhase = .phase4Completion
        } catch {
            showErrorMessage(error.localizedDescription)
        }
        
        isLoading = false
    }
    
    private func showErrorMessage(_ message: String) {
        errorMessage = message
        showError = true
    }
}