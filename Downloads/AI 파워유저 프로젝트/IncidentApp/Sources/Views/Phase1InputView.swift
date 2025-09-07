import SwiftUI

struct Phase1InputView: View {
    @EnvironmentObject var appState: AppState
    
    var body: some View {
        VStack(spacing: 20) {
            Text("장애 내용 등록")
                .font(.largeTitle)
                .fontWeight(.bold)
            
            Text("발생한 장애 내용을 상세히 입력해주세요")
                .font(.subheadline)
                .foregroundColor(.secondary)
            
            ZStack(alignment: .topLeading) {
                MacTextEditor(text: $appState.incidentDescription,
                            font: .systemFont(ofSize: 14))
                    .frame(minHeight: 200, maxHeight: 300)
                    .overlay(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(Color.gray.opacity(0.3), lineWidth: 1)
                    )
                
                if appState.incidentDescription.isEmpty {
                    Text("장애 내용을 입력하세요...")
                        .foregroundColor(.gray.opacity(0.5))
                        .padding(.horizontal, 12)
                        .padding(.vertical, 12)
                        .allowsHitTesting(false)
                }
            }
            .frame(height: 250)
            
            Button(action: {
                Task {
                    await appState.registerIncident()
                }
            }) {
                HStack {
                    if appState.isLoading {
                        ProgressView()
                            .progressViewStyle(CircularProgressViewStyle())
                            .scaleEffect(0.8)
                    } else {
                        Image(systemName: "paperplane.fill")
                    }
                    Text("등록")
                        .fontWeight(.semibold)
                }
                .frame(width: 200, height: 44)
            }
            .buttonStyle(.borderedProminent)
            .disabled(appState.isLoading || appState.incidentDescription.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)
        }
        .padding(30)
        .frame(width: 500, height: 450)
    }
}