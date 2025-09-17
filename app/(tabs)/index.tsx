import {
  StyleSheet,
  View,
  Image,
  Dimensions,
  Platform,
  ScrollView,
  SafeAreaView
} from 'react-native';

import { ThemedText } from '@/components/themed-text';
import { ThemedView } from '@/components/themed-view';
import { Button } from '@/components/ui/button';
import { Card } from '@/components/ui/card';
import { BlurView } from '@/components/ui/blur-view';
import { useThemeColor } from '@/hooks/use-theme-color';
import { Spacing, BorderRadius, Typography } from '@/constants/theme';

const { width, height } = Dimensions.get('window');

export default function HomeScreen() {
  const backgroundColor = useThemeColor({}, 'background');
  const accentColor = useThemeColor({}, 'accent');
  const borderColor = useThemeColor({}, 'border');
  const cardBackground = useThemeColor({}, 'card');

  return (
    <SafeAreaView style={[styles.safeArea, { backgroundColor }]}>
      <ScrollView
        contentContainerStyle={styles.scrollContainer}
        showsVerticalScrollIndicator={false}
        bounces={true}
      >
        {/* Hero Section with Gradient Background */}
        <View style={styles.heroSection}>
          {/* Background Gradient */}
          <View style={[styles.backgroundGradient, { backgroundColor: accentColor }]} />

          {/* Hero Content */}
          <View style={styles.heroContent}>
            <ThemedText type="hero" style={styles.heroTitle}>
              MyLife
            </ThemedText>
            <ThemedText type="secondary" style={styles.heroSubtitle}>
              Plan and build your digital life
            </ThemedText>

            {/* CTA Buttons */}
            <View style={styles.ctaContainer}>
              <Button variant="primary" size="large" style={styles.ctaButton}>
                Get Started
              </Button>
              <Button variant="ghost" size="large" style={styles.ctaButton}>
                Learn More
              </Button>
            </View>
          </View>

          {/* Profile Card with Blur Effect */}
          <BlurView intensity="medium" style={styles.profileBlurContainer}>
            <Card variant="bordered" padding="large" style={styles.profileCard}>
              {/* Status Badge */}
              <View style={styles.statusBadge}>
                <View style={[styles.statusDot, { backgroundColor: '#10B981' }]} />
                <ThemedText type="small">Online</ThemedText>
              </View>

              {/* Profile Image */}
              <View style={styles.imageWrapper}>
                <View style={[styles.imageGradientBorder, { backgroundColor: accentColor }]}>
                  <View style={styles.imageContainer}>
                    <Image
                      source={{ uri: 'https://via.placeholder.com/200/5E6AD2/ffffff?text=Profile' }}
                      style={styles.profileImage}
                    />
                    {/* Verified Badge */}
                    <View style={[styles.verifiedBadge, { backgroundColor: accentColor }]}>
                      <ThemedText style={styles.verifiedText}>✓</ThemedText>
                    </View>
                  </View>
                </View>
              </View>

              {/* Profile Info */}
              <View style={styles.profileInfo}>
                <ThemedText type="h2" style={styles.profileName}>
                  김철수
                </ThemedText>
                <ThemedText type="secondary" style={styles.profileTitle}>
                  Senior Developer
                </ThemedText>
                <ThemedText type="caption" style={styles.profileDescription}>
                  Building the future, one line at a time
                </ThemedText>
              </View>
            </Card>
          </BlurView>
        </View>

        {/* Main Content Container */}
        <View style={styles.container}>
          {/* Stats Section */}
          <View style={styles.sectionContainer}>
            <ThemedText type="h3" style={styles.sectionTitle}>
              Statistics
            </ThemedText>
            <View style={styles.statsGrid}>
              <Card variant="default" padding="medium" style={styles.statCard}>
                <ThemedText type="h2" style={[styles.statNumber, { color: accentColor }]}>
                  3+
                </ThemedText>
                <ThemedText type="small">Years</ThemedText>
                <ThemedText type="caption">Experience</ThemedText>
              </Card>
              <Card variant="default" padding="medium" style={styles.statCard}>
                <ThemedText type="h2" style={[styles.statNumber, { color: accentColor }]}>
                  50+
                </ThemedText>
                <ThemedText type="small">Projects</ThemedText>
                <ThemedText type="caption">Completed</ThemedText>
              </Card>
              <Card variant="default" padding="medium" style={styles.statCard}>
                <ThemedText type="h2" style={[styles.statNumber, { color: accentColor }]}>
                  4.9
                </ThemedText>
                <ThemedText type="small">Rating</ThemedText>
                <ThemedText type="caption">Average</ThemedText>
              </Card>
            </View>
          </View>

          {/* Skills Section */}
          <View style={styles.sectionContainer}>
            <ThemedText type="h3" style={styles.sectionTitle}>
              Technical Stack
            </ThemedText>
            <Card variant="bordered" padding="large">
              <View style={styles.skillsContainer}>
                {['React Native', 'TypeScript', 'Node.js', 'GraphQL', 'AWS', 'Docker'].map((skill) => (
                  <View key={skill} style={[styles.skillBadge, { borderColor }]}>
                    <ThemedText type="small">{skill}</ThemedText>
                  </View>
                ))}
              </View>
            </Card>
          </View>

          {/* Features Grid */}
          <View style={styles.sectionContainer}>
            <ThemedText type="h3" style={styles.sectionTitle}>
              Features
            </ThemedText>
            <View style={styles.featureGrid}>
              <Card variant="elevated" padding="medium" style={styles.featureCard}>
                <ThemedText style={styles.featureIcon}>⚡</ThemedText>
                <ThemedText type="body" style={styles.featureTitle}>
                  Lightning Fast
                </ThemedText>
                <ThemedText type="caption" style={styles.featureDescription}>
                  Optimized performance with modern architecture
                </ThemedText>
              </Card>
              <Card variant="elevated" padding="medium" style={styles.featureCard}>
                <ThemedText style={styles.featureIcon}>🛡️</ThemedText>
                <ThemedText type="body" style={styles.featureTitle}>
                  Secure by Default
                </ThemedText>
                <ThemedText type="caption" style={styles.featureDescription}>
                  Enterprise-grade security built in
                </ThemedText>
              </Card>
              <Card variant="elevated" padding="medium" style={styles.featureCard}>
                <ThemedText style={styles.featureIcon}>🎨</ThemedText>
                <ThemedText type="body" style={styles.featureTitle}>
                  Beautiful Design
                </ThemedText>
                <ThemedText type="caption" style={styles.featureDescription}>
                  Minimalist and modern UI/UX
                </ThemedText>
              </Card>
              <Card variant="elevated" padding="medium" style={styles.featureCard}>
                <ThemedText style={styles.featureIcon}>🚀</ThemedText>
                <ThemedText type="body" style={styles.featureTitle}>
                  Scalable
                </ThemedText>
                <ThemedText type="caption" style={styles.featureDescription}>
                  Built to grow with your needs
                </ThemedText>
              </Card>
            </View>
          </View>

          {/* CTA Section */}
          <Card variant="default" padding="large" style={styles.ctaCard}>
            <ThemedText type="h3" style={styles.ctaCardTitle}>
              Ready to get started?
            </ThemedText>
            <ThemedText type="caption" style={styles.ctaCardDescription}>
              Join thousands of developers building amazing products
            </ThemedText>
            <Button variant="primary" size="large" style={styles.ctaCardButton}>
              Start Building
            </Button>
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
  scrollContainer: {
    flexGrow: 1,
  },
  heroSection: {
    position: 'relative',
    minHeight: height * 0.6,
    marginBottom: Spacing.xxl,
  },
  backgroundGradient: {
    position: 'absolute',
    top: 0,
    left: 0,
    right: 0,
    height: height * 0.5,
    opacity: 0.1,
  },
  heroContent: {
    alignItems: 'center',
    paddingTop: Spacing.xxxl,
    paddingHorizontal: Spacing.lg,
  },
  heroTitle: {
    marginBottom: Spacing.sm,
    textAlign: 'center',
  },
  heroSubtitle: {
    marginBottom: Spacing.xl,
    textAlign: 'center',
  },
  ctaContainer: {
    flexDirection: 'row',
    gap: Spacing.md,
    marginBottom: Spacing.xxl,
  },
  ctaButton: {
    minWidth: 120,
  },
  profileBlurContainer: {
    marginHorizontal: Spacing.lg,
    borderRadius: BorderRadius.card,
  },
  profileCard: {
    backgroundColor: 'transparent',
    alignItems: 'center',
  },
  statusBadge: {
    position: 'absolute',
    top: Spacing.md,
    right: Spacing.md,
    flexDirection: 'row',
    alignItems: 'center',
    gap: Spacing.xs,
  },
  statusDot: {
    width: 8,
    height: 8,
    borderRadius: 4,
  },
  imageWrapper: {
    position: 'relative',
    marginBottom: Spacing.lg,
  },
  imageGradientBorder: {
    padding: 3,
    borderRadius: 75,
  },
  imageContainer: {
    position: 'relative',
    borderRadius: 72,
    padding: 4,
  },
  profileImage: {
    width: 120,
    height: 120,
    borderRadius: 60,
  },
  verifiedBadge: {
    position: 'absolute',
    bottom: 5,
    right: 5,
    width: 28,
    height: 28,
    borderRadius: 14,
    justifyContent: 'center',
    alignItems: 'center',
    borderWidth: 3,
    borderColor: '#080909',
  },
  verifiedText: {
    color: '#FFFFFF',
    fontSize: 16,
    fontWeight: 'bold',
  },
  profileInfo: {
    alignItems: 'center',
  },
  profileName: {
    marginBottom: Spacing.xs,
  },
  profileTitle: {
    marginBottom: Spacing.sm,
  },
  profileDescription: {
    textAlign: 'center',
  },
  container: {
    paddingHorizontal: Spacing.lg,
    paddingBottom: Spacing.xxl,
  },
  sectionContainer: {
    marginBottom: Spacing.xl,
  },
  sectionTitle: {
    marginBottom: Spacing.md,
  },
  statsGrid: {
    flexDirection: 'row',
    gap: Spacing.md,
  },
  statCard: {
    flex: 1,
    alignItems: 'center',
  },
  statNumber: {
    marginBottom: Spacing.xs,
  },
  skillsContainer: {
    flexDirection: 'row',
    flexWrap: 'wrap',
    gap: Spacing.sm,
  },
  skillBadge: {
    paddingHorizontal: Spacing.md,
    paddingVertical: Spacing.sm,
    borderRadius: BorderRadius.button,
    borderWidth: 1,
  },
  featureGrid: {
    flexDirection: 'row',
    flexWrap: 'wrap',
    gap: Spacing.md,
  },
  featureCard: {
    width: (width - Spacing.lg * 2 - Spacing.md) / 2,
  },
  featureIcon: {
    fontSize: 32,
    marginBottom: Spacing.sm,
  },
  featureTitle: {
    fontWeight: '600',
    marginBottom: Spacing.xs,
  },
  featureDescription: {
    opacity: 0.8,
  },
  ctaCard: {
    alignItems: 'center',
    marginTop: Spacing.xl,
  },
  ctaCardTitle: {
    marginBottom: Spacing.sm,
    textAlign: 'center',
  },
  ctaCardDescription: {
    marginBottom: Spacing.lg,
    textAlign: 'center',
  },
  ctaCardButton: {
    minWidth: 200,
  },
});