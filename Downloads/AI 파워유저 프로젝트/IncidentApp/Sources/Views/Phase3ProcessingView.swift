import SwiftUI

struct Phase3ProcessingView: View {
    @EnvironmentObject var appState: AppState
    @State private var animationAmount = 1.0
    
    var body: some View {
        VStack(spacing: 30) {
            ZStack {
                Circle()
                    .stroke(lineWidth: 3)
                    .scale(animationAmount)
                    .opacity(2 - animationAmount)
                    .animation(
                        Animation.easeOut(duration: 1)
                            .repeatForever(autoreverses: false),
                        value: animationAmount
                    )
                    .foregroundColor(.orange)
                    .frame(width: 60, height: 60)
                
                Image(systemName: "wrench.and.screwdriver.fill")
                    .font(.system(size: 60))
                    .foregroundColor(.orange)
            }
            
            Text("장애 처리 진행 중")
                .font(.largeTitle)
                .fontWeight(.bold)
            
            Text("담당자가 장애를 처리하고 있습니다.")
                .font(.headline)
                .foregroundColor(.secondary)
            
            VStack(alignment: .leading, spacing: 10) {
                Text("처리 중인 장애:")
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
                    await appState.completeProcessing()
                }
            }) {
                HStack {
                    if appState.isLoading {
                        ProgressView()
                            .progressViewStyle(CircularProgressViewStyle())
                            .scaleEffect(0.8)
                    } else {
                        Image(systemName: "checkmark.seal.fill")
                    }
                    Text("장애 처리 완료")
                        .fontWeight(.semibold)
                }
                .frame(width: 200, height: 44)
            }
            .buttonStyle(.borderedProminent)
            .controlSize(.large)
            .disabled(appState.isLoading)
        }
        .padding(30)
        .frame(width: 500, height: 450)
        .onAppear {
            animationAmount = 2
        }
    }
}