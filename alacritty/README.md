# Alacritty Configuration

Modern Alacritty terminal configuration with theme management integration.

## Features

- **Omarchy Theme Integration**: Automatically imports themes from `~/.config/omarchy/current/theme/alacritty.toml`
- **Tokyo Night Fallback**: Built-in Tokyo Night color scheme when Omarchy is not available
- **Clean Appearance**: No window decorations for minimal look
- **Optimized Font**: JetBrainsMono Nerd Font with appropriate sizing
- **Keyboard Bindings**: F11 for fullscreen toggle

## Configuration Details

- **Font Size**: 9pt (optimized for readability)
- **Window Padding**: 14px horizontal/vertical
- **Decorations**: None (no title bar)
- **Theme Management**: Uses Omarchy for consistent theming across applications

## Theme System

The configuration uses a two-tier approach:

1. **Primary**: Import from Omarchy theme management system
2. **Fallback**: Built-in Tokyo Night theme if Omarchy is unavailable

This ensures the terminal always has proper colors even if the theme management system is not installed.

## Installation

When stowed, this creates:
- `~/.config/alacritty/alacritty.toml`

## Compatibility

- Requires Alacritty 0.13+ (TOML format)
- Compatible with and without Omarchy theme system
- Works on Linux with JetBrainsMono Nerd Font installed