import SwiftUI

struct Phase2ReceptionView: View {
    @EnvironmentObject var appState: AppState
    
    var body: some View {
        VStack(spacing: 30) {
            Image(systemName: "person.crop.circle.badge.checkmark")
                .font(.system(size: 60))
                .foregroundColor(.blue)
            
            Text("담당자 장애 접수")
                .font(.largeTitle)
                .fontWeight(.bold)
            
            Text("장애가 정상적으로 등록되었습니다.")
                .font(.headline)
                .foregroundColor(.secondary)
            
            VStack(alignment: .leading, spacing: 10) {
                Text("등록된 장애 내용:")
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .foregroundColor(.secondary)
                
                ScrollView {
                    Text(appState.currentIncidentData)  // 저장된 데이터 표시
                        .font(.body)
                        .padding()
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .background(Color.gray.opacity(0.1))
                        .cornerRadius(8)
                }
                .frame(maxHeight: 150)
            }
            .frame(maxWidth: .infinity)
            
            Button(action: {
                Task {
                    await appState.confirmReception()
                }
            }) {
                HStack {
                    if appState.isLoading {
                        ProgressView()
                            .progressViewStyle(CircularProgressViewStyle())
                            .scaleEffect(0.8)
                    } else {
                        Image(systemName: "checkmark.circle.fill")
                    }
                    Text("담당자 장애 접수 완료")
                        .fontWeight(.semibold)
                }
                .frame(width: 250, height: 44)
            }
            .buttonStyle(.borderedProminent)
            .disabled(appState.isLoading)
        }
        .padding(30)
        .frame(width: 500, height: 450)
    }
}