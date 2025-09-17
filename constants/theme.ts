/**
 * Linear-inspired design system for MyLife app
 * Based on Linear.app's modern, minimalist dark theme
 */

import { Platform } from 'react-native';

// Linear's signature colors
const linearPurple = '#5E6AD2';
const linearBlue = '#4C9AFF';
const linearAccent = '#F7F8F8';

export const Colors = {
  // We'll primarily use dark mode following Linear's design
  light: {
    text: '#080909',
    textSecondary: '#6B7280',
    background: '#FFFFFF',
    backgroundSecondary: '#F9FAFB',
    card: '#FFFFFF',
    border: 'rgba(0, 0, 0, 0.08)',
    tint: linearPurple,
    icon: '#6B7280',
    tabIconDefault: '#6B7280',
    tabIconSelected: linearPurple,
    accent: linearPurple,
    accentLight: 'rgba(94, 106, 210, 0.1)',
  },
  dark: {
    text: '#F7F8F8',
    textSecondary: '#8A8F98',
    background: '#080909',
    backgroundSecondary: 'rgba(10, 10, 10, 0.8)',
    card: '#141516',
    border: 'rgba(255, 255, 255, 0.08)',
    tint: linearAccent,
    icon: '#8A8F98',
    tabIconDefault: '#8A8F98',
    tabIconSelected: linearAccent,
    accent: linearPurple,
    accentLight: 'rgba(94, 106, 210, 0.15)',
  },
};

// Linear-inspired spacing system
export const Spacing = {
  xs: 4,
  sm: 8,
  md: 16,
  lg: 24,
  xl: 32,
  xxl: 48,
  xxxl: 64,
};

// Linear-inspired border radius values
export const BorderRadius = {
  sm: 4,
  md: 8,
  lg: 12,
  xl: 16,
  xxl: 24,
  card: 30,
  button: 8,
};

// Linear-inspired typography sizes
export const Typography = {
  hero: {
    fontSize: Platform.select({ web: 64, default: 48 }),
    lineHeight: Platform.select({ web: 68, default: 52 }),
    fontWeight: '600' as const,
  },
  h1: {
    fontSize: Platform.select({ web: 48, default: 36 }),
    lineHeight: Platform.select({ web: 52, default: 40 }),
    fontWeight: '600' as const,
  },
  h2: {
    fontSize: Platform.select({ web: 36, default: 28 }),
    lineHeight: Platform.select({ web: 40, default: 32 }),
    fontWeight: '600' as const,
  },
  h3: {
    fontSize: Platform.select({ web: 24, default: 20 }),
    lineHeight: Platform.select({ web: 28, default: 24 }),
    fontWeight: '500' as const,
  },
  body: {
    fontSize: 16,
    lineHeight: 24,
    fontWeight: '400' as const,
  },
  caption: {
    fontSize: 14,
    lineHeight: 20,
    fontWeight: '400' as const,
  },
  small: {
    fontSize: 13,
    lineHeight: 18,
    fontWeight: '400' as const,
  },
};

// Animation durations (ms)
export const Animations = {
  fast: 100,
  normal: 200,
  slow: 300,
  verySlow: 500,
  easing: 'cubic-bezier(0.25, 0.46, 0.45, 0.94)',
};

export const Fonts = Platform.select({
  ios: {
    /** Linear-style font stack for iOS */
    sans: 'SF Pro Display',
    /** Fallback to system font */
    serif: 'ui-serif',
    /** iOS rounded variant */
    rounded: 'SF Pro Rounded',
    /** Monospaced for code */
    mono: 'SF Mono',
  },
  default: {
    sans: 'System',
    serif: 'serif',
    rounded: 'System',
    mono: 'monospace',
  },
  web: {
    // Linear's exact font stack
    sans: "Inter, 'SF Pro Display', -apple-system, system-ui, 'Segoe UI', Roboto, Oxygen, Ubuntu, Cantarell, 'Open Sans', 'Helvetica Neue', sans-serif",
    serif: "Georgia, 'Times New Roman', serif",
    rounded: "'SF Pro Rounded', Inter, -apple-system, system-ui, sans-serif",
    mono: "SFMono-Regular, 'SF Mono', Menlo, Monaco, Consolas, 'Liberation Mono', 'Courier New', monospace",
  },
});
