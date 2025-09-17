# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

This is a React Native Expo app called "MyLife" using Expo Router for file-based navigation and TypeScript. The app uses the new React Native architecture (New Architecture enabled) and React 19 with experimental features like typed routes and React Compiler.

## Development Commands

### Core Development
- `npm install` - Install dependencies
- `npx expo start` - Start the development server
- `npm run android` - Start with Android emulator
- `npm run ios` - Start with iOS simulator
- `npm run web` - Start web version
- `npm run lint` - Run ESLint for code quality

### Project Reset
- `npm run reset-project` - Move starter code to app-example/ and create blank app/ directory

## Architecture and Structure

### Navigation Architecture
- **File-based routing** with Expo Router (expo-router@6.0.6)
- **Root layout**: `app/_layout.tsx` with Stack navigation and theme provider
- **Tab navigation**: `app/(tabs)/_layout.tsx` with Home and Explore tabs
- **Modal support**: `app/modal.tsx` for modal presentations
- **Anchor point**: Set to `(tabs)` in root layout unstable_settings

### Component Organization
- **UI Components**: `components/ui/` for reusable UI elements (IconSymbol, Collapsible)
- **Feature Components**: `components/` for app-specific components (HapticTab, ParallaxScrollView, etc.)
- **Themed Components**: ThemedText and ThemedView for consistent theming

### Theming System
- **Color scheme detection**: Platform-specific hooks in `hooks/use-color-scheme.*`
- **Theme constants**: Centralized in `constants/theme.ts`
- **React Navigation themes**: Integration with DarkTheme/DefaultTheme
- **Automatic UI style**: Supports light/dark mode switching

### Key Features
- **Haptic feedback**: Custom HapticTab component for tab interactions
- **Platform adaptations**: Platform-specific IconSymbol implementations (.ios.tsx)
- **TypeScript strict mode**: Enabled with path aliases (`@/*` maps to root)
- **Modern React**: Uses React 19 with experimental React Compiler

### Configuration Details
- **Expo SDK**: Version ~54.0.8
- **React Native**: Version 0.81.4
- **Path aliases**: `@/*` resolves to project root
- **New Architecture**: Enabled for improved performance
- **Typed routes**: Experimental feature enabled for better type safety
- **Web output**: Static export configured

## Development Notes

The app uses Expo's file-based routing system where:
- `app/(tabs)/index.tsx` is the Home tab
- `app/(tabs)/explore.tsx` is the Explore tab
- Files in `(tabs)` folder are grouped under tab navigation
- Modal screens are defined at app root level

The project is configured with strict TypeScript and uses Expo's recommended ESLint configuration for code quality.