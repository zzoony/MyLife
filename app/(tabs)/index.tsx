import { 
  StyleSheet, 
  View, 
  Text, 
  Image, 
  Dimensions,
  Platform,
  ScrollView,
  SafeAreaView
} from 'react-native';

const { width, height } = Dimensions.get('window');

export default function HomeScreen() {
  return (
    <SafeAreaView style={styles.safeArea}>
      <ScrollView 
        contentContainerStyle={styles.scrollContainer}
        showsVerticalScrollIndicator={false}
        bounces={true}
      >
        {/* Background Gradient Effect */}
        <View style={styles.backgroundGradient} />
        
        {/* Main Container */}
        <View style={styles.container}>
          {/* Profile Card */}
          <View style={styles.profileCard}>
            {/* Header Section with Badge */}
            <View style={styles.headerSection}>
              <View style={styles.statusBadge}>
                <View style={styles.statusDot} />
                <Text style={styles.statusText}>활동 중</Text>
              </View>
            </View>
            
            {/* Profile Image Container */}
            <View style={styles.imageWrapper}>
              <View style={styles.imageGradientBorder}>
                <View style={styles.imageContainer}>
                  <Image
                    source={{ uri: 'https://via.placeholder.com/200/667eea/ffffff?text=Profile' }}
                    style={styles.profileImage}
                  />
                </View>
              </View>
              {/* Verified Badge */}
              <View style={styles.verifiedBadge}>
                <Text style={styles.verifiedText}>✓</Text>
              </View>
            </View>
            
            {/* Profile Name and Title */}
            <View style={styles.profileInfo}>
              <Text style={styles.profileName}>김철수</Text>
              <Text style={styles.profileTitle}>Senior Developer</Text>
              <Text style={styles.profileDescription}>
                꿈을 향해 달려가는 개발자
              </Text>
            </View>
            
            {/* Stats Section */}
            <View style={styles.statsContainer}>
              <View style={styles.statCard}>
                <Text style={styles.statNumber}>3+</Text>
                <Text style={styles.statLabel}>Years</Text>
                <Text style={styles.statDesc}>경력</Text>
              </View>
              <View style={styles.statDivider} />
              <View style={styles.statCard}>
                <Text style={styles.statNumber}>50+</Text>
                <Text style={styles.statLabel}>Projects</Text>
                <Text style={styles.statDesc}>프로젝트</Text>
              </View>
              <View style={styles.statDivider} />
              <View style={styles.statCard}>
                <Text style={styles.statNumber}>4.9</Text>
                <Text style={styles.statLabel}>Rating</Text>
                <Text style={styles.statDesc}>평점</Text>
              </View>
            </View>
            
            {/* Skills Section */}
            <View style={styles.skillsSection}>
              <Text style={styles.sectionTitle}>전문 분야</Text>
              <View style={styles.skillsContainer}>
                <View style={styles.skillBadge}>
                  <Text style={styles.skillText}>React Native</Text>
                </View>
                <View style={styles.skillBadge}>
                  <Text style={styles.skillText}>TypeScript</Text>
                </View>
                <View style={styles.skillBadge}>
                  <Text style={styles.skillText}>Node.js</Text>
                </View>
                <View style={styles.skillBadge}>
                  <Text style={styles.skillText}>UI/UX</Text>
                </View>
              </View>
            </View>
            
            {/* Contact Section */}
            <View style={styles.contactSection}>
              <View style={styles.contactButton}>
                <Text style={styles.contactButtonText}>프로필 편집</Text>
              </View>
            </View>
          </View>
          
          {/* Additional Info Cards */}
          <View style={styles.infoCardsContainer}>
            <View style={styles.miniCard}>
              <Text style={styles.miniCardIcon}>📍</Text>
              <Text style={styles.miniCardTitle}>위치</Text>
              <Text style={styles.miniCardValue}>서울, 대한민국</Text>
            </View>
            <View style={styles.miniCard}>
              <Text style={styles.miniCardIcon}>🎓</Text>
              <Text style={styles.miniCardTitle}>학력</Text>
              <Text style={styles.miniCardValue}>컴퓨터공학</Text>
            </View>
          </View>
        </View>
      </ScrollView>
    </SafeAreaView>
  );
}

const styles = StyleSheet.create({
  safeArea: {
    flex: 1,
    backgroundColor: '#f7f9fc',
  },
  scrollContainer: {
    flexGrow: 1,
  },
  backgroundGradient: {
    position: 'absolute',
    top: 0,
    left: 0,
    right: 0,
    height: height * 0.4,
    backgroundColor: '#667eea',
    opacity: 0.05,
  },
  container: {
    flex: 1,
    paddingHorizontal: 20,
    paddingVertical: 20,
  },
  profileCard: {
    backgroundColor: '#ffffff',
    borderRadius: 24,
    padding: 24,
    marginTop: 10,
    ...Platform.select({
      ios: {
        shadowColor: '#667eea',
        shadowOffset: { width: 0, height: 12 },
        shadowOpacity: 0.15,
        shadowRadius: 24,
      },
      android: {
        elevation: 12,
      },
    }),
  },
  headerSection: {
    flexDirection: 'row',
    justifyContent: 'flex-end',
    marginBottom: -10,
  },
  statusBadge: {
    flexDirection: 'row',
    alignItems: 'center',
    backgroundColor: '#e8f5e9',
    paddingHorizontal: 12,
    paddingVertical: 6,
    borderRadius: 20,
  },
  statusDot: {
    width: 8,
    height: 8,
    borderRadius: 4,
    backgroundColor: '#4caf50',
    marginRight: 6,
  },
  statusText: {
    fontSize: 12,
    color: '#4caf50',
    fontWeight: '600',
  },
  imageWrapper: {
    alignItems: 'center',
    marginVertical: 20,
  },
  imageGradientBorder: {
    padding: 3,
    borderRadius: 80,
    backgroundColor: '#667eea',
  },
  imageContainer: {
    backgroundColor: '#ffffff',
    borderRadius: 77,
    padding: 4,
  },
  profileImage: {
    width: 140,
    height: 140,
    borderRadius: 70,
  },
  verifiedBadge: {
    position: 'absolute',
    bottom: 5,
    right: width / 2 - 85,
    backgroundColor: '#667eea',
    width: 28,
    height: 28,
    borderRadius: 14,
    justifyContent: 'center',
    alignItems: 'center',
    borderWidth: 3,
    borderColor: '#ffffff',
  },
  verifiedText: {
    color: '#ffffff',
    fontSize: 16,
    fontWeight: 'bold',
  },
  profileInfo: {
    alignItems: 'center',
    marginBottom: 32,
  },
  profileName: {
    fontSize: 32,
    fontWeight: Platform.OS === 'ios' ? '700' : 'bold',
    color: '#1a1a2e',
    marginBottom: 4,
    letterSpacing: -0.5,
  },
  profileTitle: {
    fontSize: 18,
    fontWeight: '600',
    color: '#667eea',
    marginBottom: 8,
  },
  profileDescription: {
    fontSize: 15,
    color: '#6b7280',
    textAlign: 'center',
    marginTop: 8,
    lineHeight: 22,
    paddingHorizontal: 20,
  },
  statsContainer: {
    flexDirection: 'row',
    justifyContent: 'space-around',
    backgroundColor: '#f8fafc',
    borderRadius: 16,
    padding: 20,
    marginBottom: 28,
  },
  statCard: {
    alignItems: 'center',
    flex: 1,
  },
  statNumber: {
    fontSize: 24,
    fontWeight: Platform.OS === 'ios' ? '700' : 'bold',
    color: '#667eea',
    marginBottom: 2,
  },
  statLabel: {
    fontSize: 12,
    color: '#1a1a2e',
    fontWeight: '600',
    marginBottom: 2,
  },
  statDesc: {
    fontSize: 11,
    color: '#9ca3af',
  },
  statDivider: {
    width: 1,
    backgroundColor: '#e5e7eb',
    marginVertical: 8,
  },
  skillsSection: {
    marginBottom: 28,
  },
  sectionTitle: {
    fontSize: 16,
    fontWeight: '600',
    color: '#1a1a2e',
    marginBottom: 12,
  },
  skillsContainer: {
    flexDirection: 'row',
    flexWrap: 'wrap',
    gap: 8,
  },
  skillBadge: {
    backgroundColor: '#f3f4f6',
    paddingHorizontal: 16,
    paddingVertical: 8,
    borderRadius: 20,
    marginRight: 8,
    marginBottom: 8,
    borderWidth: 1,
    borderColor: '#e5e7eb',
  },
  skillText: {
    fontSize: 13,
    color: '#4b5563',
    fontWeight: '500',
  },
  contactSection: {
    marginTop: 4,
  },
  contactButton: {
    paddingVertical: 16,
    borderRadius: 14,
    alignItems: 'center',
    backgroundColor: '#667eea',
  },
  contactButtonText: {
    color: '#ffffff',
    fontSize: 16,
    fontWeight: '600',
    letterSpacing: 0.5,
  },
  infoCardsContainer: {
    flexDirection: 'row',
    gap: 12,
    marginTop: 16,
  },
  miniCard: {
    flex: 1,
    backgroundColor: '#ffffff',
    borderRadius: 16,
    padding: 16,
    alignItems: 'center',
    ...Platform.select({
      ios: {
        shadowColor: '#000',
        shadowOffset: { width: 0, height: 4 },
        shadowOpacity: 0.08,
        shadowRadius: 12,
      },
      android: {
        elevation: 4,
      },
    }),
  },
  miniCardIcon: {
    fontSize: 24,
    marginBottom: 8,
  },
  miniCardTitle: {
    fontSize: 12,
    color: '#9ca3af',
    marginBottom: 4,
  },
  miniCardValue: {
    fontSize: 14,
    color: '#1a1a2e',
    fontWeight: '600',
  },
});
