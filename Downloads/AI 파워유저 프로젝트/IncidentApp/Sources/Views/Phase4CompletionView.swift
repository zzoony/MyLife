import SwiftUI

struct Phase4CompletionView: View {
    @EnvironmentObject var appState: AppState
    @State private var showCheckmark = false
    
    var body: some View {
        VStack(spacing: 30) {
            ZStack {
                Circle()
                    .fill(Color.green.opacity(0.2))
                    .frame(width: 100, height: 100)
                
                Image(systemName: "checkmark.circle.fill")
                    .font(.system(size: 80))
                    .foregroundColor(.green)
                    .scaleEffect(showCheckmark ? 1 : 0.5)
                    .opacity(showCheckmark ? 1 : 0)
                    .animation(.spring(response: 0.5, dampingFraction: 0.6), value: showCheckmark)
            }
            
            Text("장애처리가 완료되었습니다")
                .font(.largeTitle)
                .fontWeight(.bold)
            
            Text("성공적으로 장애가 처리되었습니다.")
                .font(.headline)
                .foregroundColor(.secondary)
            
            VStack(alignment: .leading, spacing: 10) {
                HStack {
                    Image(systemName: "checkmark.square.fill")
                        .foregroundColor(.green)
                    Text("처리 완료된 장애")
                        .font(.subheadline)
                        .bold()
                        .foregroundColor(.green)
                }
                
                ScrollView {
                    Text(appState.currentIncidentData)  // 저장된 데이터 표시
                        .font(.body)
                        .padding()
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .background(Color.green.opacity(0.1))
                        .cornerRadius(8)
                        .overlay(
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(Color.green.opacity(0.3), lineWidth: 1)
                        )
                }
                .frame(maxHeight: 120)
            }
            .frame(maxWidth: .infinity)
            
            Spacer()
            
            Button(action: {
                appState.reset()
            }) {
                HStack {
                    Image(systemName: "plus.circle.fill")
                    Text("새 장애 등록하기")
                        .fontWeight(.semibold)
                }
                .frame(width: 200, height: 44)
            }
            .buttonStyle(.borderedProminent)
            .controlSize(.large)
        }
        .padding(30)
        .frame(width: 500, height: 450)
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                withAnimation {
                    showCheckmark = true
                }
            }
        }
    }
}