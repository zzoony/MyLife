import { Platform, StyleSheet, Text, type TextProps } from 'react-native';

import { useThemeColor } from '@/hooks/use-theme-color';
import { Typography, Fonts, Colors } from '@/constants/theme';

export type ThemedTextProps = TextProps & {
  lightColor?: string;
  darkColor?: string;
  type?: 'hero' | 'h1' | 'h2' | 'h3' | 'body' | 'caption' | 'small' | 'link' | 'secondary';
};

export function ThemedText({
  style,
  lightColor,
  darkColor,
  type = 'body',
  ...rest
}: ThemedTextProps) {
  const color = useThemeColor({ light: lightColor, dark: darkColor }, 'text');
  const secondaryColor = useThemeColor({}, 'textSecondary');
  const accentColor = useThemeColor({}, 'accent');

  const isSecondary = type === 'secondary';
  const textColor = type === 'link' ? accentColor : (isSecondary ? secondaryColor : color);

  return (
    <Text
      style={[
        { color: textColor, fontFamily: Fonts?.sans },
        type === 'hero' ? styles.hero : undefined,
        type === 'h1' ? styles.h1 : undefined,
        type === 'h2' ? styles.h2 : undefined,
        type === 'h3' ? styles.h3 : undefined,
        type === 'body' ? styles.body : undefined,
        type === 'caption' ? styles.caption : undefined,
        type === 'small' ? styles.small : undefined,
        type === 'link' ? styles.link : undefined,
        type === 'secondary' ? styles.body : undefined,
        style,
      ]}
      {...rest}
    />
  );
}

const styles = StyleSheet.create({
  hero: {
    ...Typography.hero,
    letterSpacing: -1.5,
  },
  h1: {
    ...Typography.h1,
    letterSpacing: -1,
  },
  h2: {
    ...Typography.h2,
    letterSpacing: -0.5,
  },
  h3: {
    ...Typography.h3,
    letterSpacing: -0.25,
  },
  body: {
    ...Typography.body,
  },
  caption: {
    ...Typography.caption,
    opacity: 0.8,
  },
  small: {
    ...Typography.small,
    opacity: 0.7,
  },
  link: {
    ...Typography.body,
    textDecorationLine: Platform.select({ web: 'underline', default: 'none' }),
  },
});
