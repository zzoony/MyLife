import { StyleSheet, View, Text, ScrollView, TouchableOpacity } from 'react-native';
import { IconSymbol } from '@/components/ui/icon-symbol';

export default function TabTwoScreen() {
  const lifestyleCategories = [
    { id: 1, title: '건강', icon: 'heart.fill', color: '#FF6B6B', description: '운동과 영양 관리' },
    { id: 2, title: '업무', icon: 'briefcase.fill', color: '#4ECDC4', description: '생산성과 목표 달성' },
    { id: 3, title: '취미', icon: 'paintbrush.fill', color: '#45B7D1', description: '창의적인 활동' },
    { id: 4, title: '학습', icon: 'book.fill', color: '#96CEB4', description: '지속적인 성장' },
    { id: 5, title: '관계', icon: 'person.2.fill', color: '#FFEAA7', description: '소중한 사람들과의 연결' },
    { id: 6, title: '휴식', icon: 'moon.fill', color: '#DDA0DD', description: '마음의 평화와 재충전' },
  ];

  return (
    <View style={styles.container}>
      <View style={styles.header}>
        <Text style={styles.headerTitle}>라이프스타일</Text>
        <Text style={styles.headerSubtitle}>균형잡힌 삶을 위한 여정</Text>
      </View>
      
      <ScrollView style={styles.scrollView} showsVerticalScrollIndicator={false}>
        <View style={styles.categoriesContainer}>
          {lifestyleCategories.map((category) => (
            <TouchableOpacity key={category.id} style={styles.categoryCard} activeOpacity={0.8}>
              <View style={[styles.iconContainer, { backgroundColor: category.color + '20' }]}>
                <IconSymbol 
                  name={category.icon} 
                  size={32} 
                  color={category.color}
                />
              </View>
              <Text style={styles.categoryTitle}>{category.title}</Text>
              <Text style={styles.categoryDescription}>{category.description}</Text>
            </TouchableOpacity>
          ))}
        </View>
        
        <View style={styles.statsContainer}>
          <Text style={styles.statsTitle}>이번 주 활동</Text>
          <View style={styles.statsRow}>
            <View style={styles.statItem}>
              <Text style={styles.statValue}>7</Text>
              <Text style={styles.statLabel}>완료한 목표</Text>
            </View>
            <View style={styles.statDivider} />
            <View style={styles.statItem}>
              <Text style={styles.statValue}>85%</Text>
              <Text style={styles.statLabel}>달성률</Text>
            </View>
            <View style={styles.statDivider} />
            <View style={styles.statItem}>
              <Text style={styles.statValue}>12</Text>
              <Text style={styles.statLabel}>활동 시간</Text>
            </View>
          </View>
        </View>
      </ScrollView>
    </View>
  );
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    backgroundColor: '#f8f9fa',
  },
  header: {
    backgroundColor: '#ffffff',
    paddingTop: 60,
    paddingBottom: 20,
    paddingHorizontal: 20,
    borderBottomWidth: 1,
    borderBottomColor: '#e9ecef',
  },
  headerTitle: {
    fontSize: 32,
    fontWeight: 'bold',
    color: '#2c3e50',
    marginBottom: 5,
  },
  headerSubtitle: {
    fontSize: 16,
    color: '#7f8c8d',
  },
  scrollView: {
    flex: 1,
  },
  categoriesContainer: {
    flexDirection: 'row',
    flexWrap: 'wrap',
    padding: 10,
    justifyContent: 'space-between',
  },
  categoryCard: {
    backgroundColor: '#ffffff',
    borderRadius: 15,
    padding: 20,
    width: '47%',
    marginBottom: 15,
    alignItems: 'center',
    shadowColor: '#000',
    shadowOffset: {
      width: 0,
      height: 2,
    },
    shadowOpacity: 0.05,
    shadowRadius: 5,
    elevation: 3,
  },
  iconContainer: {
    width: 70,
    height: 70,
    borderRadius: 35,
    justifyContent: 'center',
    alignItems: 'center',
    marginBottom: 12,
  },
  categoryTitle: {
    fontSize: 18,
    fontWeight: '600',
    color: '#2c3e50',
    marginBottom: 5,
  },
  categoryDescription: {
    fontSize: 12,
    color: '#95a5a6',
    textAlign: 'center',
  },
  statsContainer: {
    backgroundColor: '#ffffff',
    margin: 20,
    marginTop: 5,
    padding: 20,
    borderRadius: 15,
    shadowColor: '#000',
    shadowOffset: {
      width: 0,
      height: 2,
    },
    shadowOpacity: 0.05,
    shadowRadius: 5,
    elevation: 3,
  },
  statsTitle: {
    fontSize: 18,
    fontWeight: '600',
    color: '#2c3e50',
    marginBottom: 15,
  },
  statsRow: {
    flexDirection: 'row',
    justifyContent: 'space-around',
  },
  statItem: {
    alignItems: 'center',
    flex: 1,
  },
  statValue: {
    fontSize: 24,
    fontWeight: 'bold',
    color: '#3498db',
    marginBottom: 5,
  },
  statLabel: {
    fontSize: 12,
    color: '#95a5a6',
  },
  statDivider: {
    width: 1,
    backgroundColor: '#e9ecef',
    marginVertical: 5,
  },
});
