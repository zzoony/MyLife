import React from 'react';
import { View, StyleSheet, Platform, type ViewProps } from 'react-native';
import { useThemeColor } from '@/hooks/use-theme-color';
import { BorderRadius, Spacing, Animations } from '@/constants/theme';

export type CardProps = ViewProps & {
  variant?: 'default' | 'bordered' | 'elevated';
  padding?: 'none' | 'small' | 'medium' | 'large';
  rounded?: boolean;
};

export function Card({
  variant = 'default',
  padding = 'medium',
  rounded = true,
  style,
  children,
  ...rest
}: CardProps) {
  const cardBackground = useThemeColor({}, 'card');
  const borderColor = useThemeColor({}, 'border');

  const getCardStyle = () => {
    const baseStyle = {
      ...styles.base,
      backgroundColor: cardBackground,
      borderRadius: rounded ? BorderRadius.card : BorderRadius.md,
      ...paddingStyles[padding],
    };

    switch (variant) {
      case 'bordered':
        return {
          ...baseStyle,
          borderWidth: 1,
          borderColor,
        };
      case 'elevated':
        return {
          ...baseStyle,
          ...Platform.select({
            ios: {
              shadowColor: '#000',
              shadowOffset: { width: 0, height: 2 },
              shadowOpacity: 0.05,
              shadowRadius: 8,
            },
            android: {
              elevation: 2,
            },
            web: {
              boxShadow: '0 2px 8px rgba(0, 0, 0, 0.05)',
            },
            default: {},
          }),
        };
      default:
        return baseStyle;
    }
  };

  return (
    <View style={[getCardStyle(), style]} {...rest}>
      {children}
    </View>
  );
}

const styles = StyleSheet.create({
  base: {
    overflow: 'hidden',
    ...Platform.select({
      web: {
        transition: `all ${Animations.normal}ms ${Animations.easing}`,
      },
      default: {},
    }),
  },
});

const paddingStyles = StyleSheet.create({
  none: {
    padding: 0,
  },
  small: {
    padding: Spacing.md,
  },
  medium: {
    padding: Spacing.lg,
  },
  large: {
    padding: Spacing.xl,
  },
});