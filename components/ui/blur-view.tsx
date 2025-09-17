import React from 'react';
import { View, StyleSheet, Platform, type ViewProps } from 'react-native';
import { useThemeColor } from '@/hooks/use-theme-color';

export type BlurViewProps = ViewProps & {
  intensity?: 'light' | 'medium' | 'strong';
};

export function BlurView({
  intensity = 'medium',
  style,
  children,
  ...rest
}: BlurViewProps) {
  const backgroundSecondary = useThemeColor({}, 'backgroundSecondary');

  const getBlurStyle = () => {
    const blurAmount = intensity === 'light' ? 10 : intensity === 'strong' ? 30 : 20;

    return Platform.select({
      web: {
        backgroundColor: backgroundSecondary,
        backdropFilter: `blur(${blurAmount}px)`,
        WebkitBackdropFilter: `blur(${blurAmount}px)`,
      },
      default: {
        // For native, we'll use a semi-transparent background
        // as backdrop-filter is not natively supported
        backgroundColor: backgroundSecondary,
      },
    });
  };

  return (
    <View style={[styles.base, getBlurStyle(), style]} {...rest}>
      {children}
    </View>
  );
}

const styles = StyleSheet.create({
  base: {
    overflow: 'hidden',
  },
});