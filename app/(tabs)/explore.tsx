import { StyleSheet, View, ScrollView, TouchableOpacity, SafeAreaView, Platform } from 'react-native';
import { ThemedText } from '@/components/themed-text';
import { Card } from '@/components/ui/card';
import { BlurView } from '@/components/ui/blur-view';
import { useThemeColor } from '@/hooks/use-theme-color';
import { Spacing, BorderRadius } from '@/constants/theme';

export default function TabTwoScreen() {
  const backgroundColor = useThemeColor({}, 'background');
  const accentColor = useThemeColor({}, 'accent');
  const borderColor = useThemeColor({}, 'border');
  const cardBackground = useThemeColor({}, 'card');
  const textSecondary = useThemeColor({}, 'textSecondary');

  const lifestyleCategories = [
    { id: 1, title: '건강', emoji: '❤️', color: '#EF4444', description: '운동과 영양 관리' },
    { id: 2, title: '업무', emoji: '💼', color: '#10B981', description: '생산성과 목표 달성' },
    { id: 3, title: '취미', emoji: '🎨', color: '#3B82F6', description: '창의적인 활동' },
    { id: 4, title: '학습', emoji: '📚', color: '#8B5CF6', description: '지속적인 성장' },
    { id: 5, title: '관계', emoji: '👥', color: '#F59E0B', description: '소중한 연결' },
    { id: 6, title: '휴식', emoji: '🌙', color: '#EC4899', description: '마음의 평화' },
  ];

  const weeklyStats = [
    { label: '완료한 목표', value: '7', unit: '' },
    { label: '달성률', value: '85', unit: '%' },
    { label: '활동 시간', value: '12', unit: 'h' },
  ];

  return (
    <SafeAreaView style={[styles.safeArea, { backgroundColor }]}>
      <ScrollView style={styles.scrollView} showsVerticalScrollIndicator={false}>
        {/* Header Section with Blur */}
        <BlurView intensity="light" style={styles.headerBlur}>
          <View style={styles.header}>
            <ThemedText type="h1" style={styles.headerTitle}>
              라이프스타일
            </ThemedText>
            <ThemedText type="secondary" style={styles.headerSubtitle}>
              균형잡힌 삶을 위한 여정
            </ThemedText>
          </View>
        </BlurView>

        {/* Categories Grid */}
        <View style={styles.categoriesSection}>
          <ThemedText type="h3" style={styles.sectionTitle}>
            카테고리
          </ThemedText>
          <View style={styles.categoriesGrid}>
            {lifestyleCategories.map((category) => (
              <TouchableOpacity
                key={category.id}
                activeOpacity={0.7}
                style={styles.categoryWrapper}
              >
                <Card variant="elevated" padding="medium" style={styles.categoryCard}>
                  <View style={[styles.iconContainer, { backgroundColor: category.color + '15' }]}>
                    <ThemedText style={[styles.categoryEmoji, { color: category.color }]}>
                      {category.emoji}
                    </ThemedText>
                  </View>
                  <ThemedText type="body" style={styles.categoryTitle}>
                    {category.title}
                  </ThemedText>
                  <ThemedText type="caption" style={styles.categoryDescription}>
                    {category.description}
                  </ThemedText>
                </Card>
              </TouchableOpacity>
            ))}
          </View>
        </View>

        {/* Weekly Stats */}
        <View style={styles.statsSection}>
          <ThemedText type="h3" style={styles.sectionTitle}>
            이번 주 활동
          </ThemedText>
          <Card variant="bordered" padding="large">
            <View style={styles.statsGrid}>
              {weeklyStats.map((stat, index) => (
                <View key={index} style={styles.statItem}>
                  <View style={styles.statValueContainer}>
                    <ThemedText type="h1" style={[styles.statValue, { color: accentColor }]}>
                      {stat.value}
                    </ThemedText>
                    {stat.unit && (
                      <ThemedText type="h3" style={[styles.statUnit, { color: accentColor }]}>
                        {stat.unit}
                      </ThemedText>
                    )}
                  </View>
                  <ThemedText type="caption">{stat.label}</ThemedText>
                </View>
              ))}
            </View>
          </Card>
        </View>

        {/* Progress Section */}
        <View style={styles.progressSection}>
          <ThemedText type="h3" style={styles.sectionTitle}>
            진행 상황
          </ThemedText>
          <Card variant="default" padding="large">
            <View style={styles.progressItem}>
              <View style={styles.progressHeader}>
                <ThemedText type="body">주간 목표</ThemedText>
                <ThemedText type="caption">85%</ThemedText>
              </View>
              <View style={styles.progressBarContainer}>
                <View style={[styles.progressBar, { width: '85%', backgroundColor: accentColor }]} />
              </View>
            </View>
            <View style={styles.progressItem}>
              <View style={styles.progressHeader}>
                <ThemedText type="body">월간 성장</ThemedText>
                <ThemedText type="caption">72%</ThemedText>
              </View>
              <View style={styles.progressBarContainer}>
                <View style={[styles.progressBar, { width: '72%', backgroundColor: '#10B981' }]} />
              </View>
            </View>
            <View style={styles.progressItem}>
              <View style={styles.progressHeader}>
                <ThemedText type="body">연간 달성</ThemedText>
                <ThemedText type="caption">60%</ThemedText>
              </View>
              <View style={styles.progressBarContainer}>
                <View style={[styles.progressBar, { width: '60%', backgroundColor: '#F59E0B' }]} />
              </View>
            </View>
          </Card>
        </View>

        {/* Recent Activities */}
        <View style={styles.activitiesSection}>
          <ThemedText type="h3" style={styles.sectionTitle}>
            최근 활동
          </ThemedText>
          <Card variant="bordered" padding="none">
            {['아침 운동 완료', '독서 30분', '명상 세션', '프로젝트 마일스톤 달성'].map((activity, index) => (
              <View key={index} style={[
                styles.activityItem,
                index !== 3 && { borderBottomWidth: 1, borderBottomColor: borderColor }
              ]}>
                <View style={styles.activityDot} />
                <ThemedText type="body" style={styles.activityText}>
                  {activity}
                </ThemedText>
                <ThemedText type="caption">2시간 전</ThemedText>
              </View>
            ))}
          </Card>
        </View>
      </ScrollView>
    </SafeAreaView>
  );
}

const styles = StyleSheet.create({
  safeArea: {
    flex: 1,
  },
  scrollView: {
    flex: 1,
  },
  headerBlur: {
    marginBottom: Spacing.lg,
  },
  header: {
    paddingTop: Platform.OS === 'ios' ? Spacing.md : Spacing.xxl,
    paddingBottom: Spacing.lg,
    paddingHorizontal: Spacing.lg,
  },
  headerTitle: {
    marginBottom: Spacing.xs,
  },
  headerSubtitle: {
    opacity: 0.8,
  },
  sectionTitle: {
    marginBottom: Spacing.md,
    paddingHorizontal: Spacing.lg,
  },
  categoriesSection: {
    marginBottom: Spacing.xl,
  },
  categoriesGrid: {
    flexDirection: 'row',
    flexWrap: 'wrap',
    paddingHorizontal: Spacing.md,
    gap: Spacing.md,
  },
  categoryWrapper: {
    width: '47%',
  },
  categoryCard: {
    alignItems: 'center',
    minHeight: 140,
  },
  iconContainer: {
    width: 56,
    height: 56,
    borderRadius: BorderRadius.xl,
    justifyContent: 'center',
    alignItems: 'center',
    marginBottom: Spacing.sm,
  },
  categoryTitle: {
    fontWeight: '600',
    marginBottom: Spacing.xs,
  },
  categoryDescription: {
    textAlign: 'center',
    opacity: 0.7,
  },
  categoryEmoji: {
    fontSize: 32,
  },
  statsSection: {
    marginBottom: Spacing.xl,
  },
  statsGrid: {
    flexDirection: 'row',
    justifyContent: 'space-around',
  },
  statItem: {
    alignItems: 'center',
    flex: 1,
  },
  statValueContainer: {
    flexDirection: 'row',
    alignItems: 'baseline',
    marginBottom: Spacing.xs,
  },
  statValue: {
    fontWeight: '700',
  },
  statUnit: {
    marginLeft: 2,
    opacity: 0.8,
  },
  progressSection: {
    marginBottom: Spacing.xl,
  },
  progressItem: {
    marginBottom: Spacing.lg,
  },
  progressHeader: {
    flexDirection: 'row',
    justifyContent: 'space-between',
    marginBottom: Spacing.sm,
  },
  progressBarContainer: {
    height: 8,
    backgroundColor: 'rgba(255, 255, 255, 0.1)',
    borderRadius: BorderRadius.sm,
    overflow: 'hidden',
  },
  progressBar: {
    height: '100%',
    borderRadius: BorderRadius.sm,
  },
  activitiesSection: {
    marginBottom: Spacing.xxl,
  },
  activityItem: {
    flexDirection: 'row',
    alignItems: 'center',
    padding: Spacing.md,
  },
  activityDot: {
    width: 8,
    height: 8,
    borderRadius: 4,
    backgroundColor: '#10B981',
    marginRight: Spacing.md,
  },
  activityText: {
    flex: 1,
  },
});