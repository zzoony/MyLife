import React from 'react';
import {
  TouchableOpacity,
  StyleSheet,
  ActivityIndicator,
  Platform,
  type TouchableOpacityProps,
} from 'react-native';
import { ThemedText } from '../themed-text';
import { useThemeColor } from '@/hooks/use-theme-color';
import { BorderRadius, Spacing, Animations } from '@/constants/theme';

export type ButtonProps = TouchableOpacityProps & {
  variant?: 'primary' | 'secondary' | 'ghost' | 'danger';
  size?: 'small' | 'medium' | 'large';
  isLoading?: boolean;
  children: React.ReactNode;
};

export function Button({
  variant = 'primary',
  size = 'medium',
  isLoading = false,
  children,
  disabled,
  style,
  ...rest
}: ButtonProps) {
  const backgroundColor = useThemeColor({}, 'accent');
  const cardBackground = useThemeColor({}, 'card');
  const borderColor = useThemeColor({}, 'border');
  const textColor = useThemeColor({}, 'text');
  const dangerColor = '#EF4444';

  const getButtonStyle = () => {
    const baseStyle = {
      ...styles.base,
      ...sizeStyles[size],
    };

    switch (variant) {
      case 'primary':
        return {
          ...baseStyle,
          backgroundColor,
        };
      case 'secondary':
        return {
          ...baseStyle,
          backgroundColor: cardBackground,
          borderWidth: 1,
          borderColor,
        };
      case 'ghost':
        return {
          ...baseStyle,
          backgroundColor: 'transparent',
        };
      case 'danger':
        return {
          ...baseStyle,
          backgroundColor: dangerColor,
        };
      default:
        return baseStyle;
    }
  };

  const getTextColor = () => {
    switch (variant) {
      case 'primary':
      case 'danger':
        return '#FFFFFF';
      case 'secondary':
      case 'ghost':
        return textColor;
      default:
        return textColor;
    }
  };

  const getTextSize = () => {
    switch (size) {
      case 'small':
        return 'small';
      case 'large':
        return 'h3';
      default:
        return 'body';
    }
  };

  return (
    <TouchableOpacity
      style={[
        getButtonStyle(),
        disabled && styles.disabled,
        style,
      ]}
      disabled={disabled || isLoading}
      activeOpacity={0.7}
      {...rest}
    >
      {isLoading ? (
        <ActivityIndicator color={getTextColor()} size="small" />
      ) : (
        <ThemedText
          type={getTextSize() as any}
          style={[styles.text, { color: getTextColor() }]}
        >
          {children}
        </ThemedText>
      )}
    </TouchableOpacity>
  );
}

const styles = StyleSheet.create({
  base: {
    borderRadius: BorderRadius.button,
    alignItems: 'center',
    justifyContent: 'center',
    flexDirection: 'row',
    ...Platform.select({
      web: {
        cursor: 'pointer',
        transition: `all ${Animations.normal}ms ${Animations.easing}`,
      },
      default: {},
    }),
  },
  text: {
    fontWeight: '500',
    textAlign: 'center',
  },
  disabled: {
    opacity: 0.5,
  },
});

const sizeStyles = StyleSheet.create({
  small: {
    paddingHorizontal: Spacing.md,
    paddingVertical: Spacing.sm,
    minHeight: 32,
  },
  medium: {
    paddingHorizontal: Spacing.lg,
    paddingVertical: Spacing.sm + 4,
    minHeight: 40,
  },
  large: {
    paddingHorizontal: Spacing.xl,
    paddingVertical: Spacing.md,
    minHeight: 48,
  },
});