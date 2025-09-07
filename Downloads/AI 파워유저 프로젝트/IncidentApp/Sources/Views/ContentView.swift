import SwiftUI

struct ContentView: View {
    @StateObject private var appState = AppState()
    
    var body: some View {
        VStack(spacing: 0) {
            // API Server Selection Header
            HStack {
                Label("테스트 서버:", systemImage: "server.rack")
                    .font(.system(size: 14, weight: .medium))
                    .foregroundColor(.secondary)
                
                Picker("API Server", selection: $appState.selectedServer) {
                    ForEach(ApiServer.allCases, id: \.self) { server in
                        Text(server.displayName).tag(server)
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
                .frame(width: 200)
                
                Spacer()
                
                Text("현재 서버: \(appState.selectedServer.displayName)")
                    .font(.system(size: 12))
                    .foregroundColor(.secondary)
                    .padding(.horizontal, 8)
                    .padding(.vertical, 4)
                    .background(Color.gray.opacity(0.1))
                    .cornerRadius(4)
            }
            .padding(.horizontal, 20)
            .padding(.vertical, 10)
            .background(Color(NSColor.controlBackgroundColor))
            .overlay(
                Rectangle()
                    .frame(height: 1)
                    .foregroundColor(Color.gray.opacity(0.2)),
                alignment: .bottom
            )
            
            // Main Content
            ZStack {
                switch appState.currentPhase {
                case .phase1Input:
                    Phase1InputView()
                        .transition(.asymmetric(
                            insertion: .move(edge: .trailing),
                            removal: .move(edge: .leading)
                        ))
                case .phase2Reception:
                    Phase2ReceptionView()
                        .transition(.asymmetric(
                            insertion: .move(edge: .trailing),
                            removal: .move(edge: .leading)
                        ))
                case .phase3Processing:
                    Phase3ProcessingView()
                        .transition(.asymmetric(
                            insertion: .move(edge: .trailing),
                            removal: .move(edge: .leading)
                        ))
                case .phase4Completion:
                    Phase4CompletionView()
                        .transition(.asymmetric(
                            insertion: .move(edge: .trailing),
                            removal: .move(edge: .leading)
                        ))
                }
            }
        }
        .animation(.easeInOut(duration: 0.3), value: appState.currentPhase)
        .environmentObject(appState)
        .alert("오류", isPresented: $appState.showError, actions: {
            Button("확인", role: .cancel) { }
        }, message: {
            Text(appState.errorMessage ?? "알 수 없는 오류가 발생했습니다.")
        })
    }
}