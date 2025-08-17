#!/bin/bash
set -e

echo "🚀 Setting up development environment..."

# Ensure we're in the workspace directory
cd /root/workspace

# Update Node.js dependencies if package.json has changed
if [ -f "package.json" ]; then
    echo "📦 Installing Node.js dependencies..."
    npm install
fi

# Setup fish shell configuration
if [ ! -f "/root/.config/fish/conf.d/tex.fish" ]; then
    mkdir -p /root/.config/fish/conf.d
    echo "# TeX and Typst environment setup" > /root/.config/fish/conf.d/tex.fish
    echo "set -gx PATH /usr/local/bin \$PATH" >> /root/.config/fish/conf.d/tex.fish
fi

# Verify Typst installation
if command -v typst &> /dev/null; then
    echo "✅ Typst installed: $(typst --version)"
    # Update Typst font cache
    typst fonts --update &> /dev/null || true
    echo "✅ Typst font cache updated"
else
    echo "⚠️ Typst not found"
fi

# Verify Harano Aji Fonts installation
if fc-list | grep -i "harano" &> /dev/null; then
    echo "✅ Harano Aji Fonts installed"
    echo "   Available fonts:"
    fc-list | grep -i "harano" | head -5 | sed 's/^/   - /'
else
    echo "⚠️ Harano Aji Fonts not found"
fi

echo "✅ Development environment setup complete!"
echo "📝 Typst and TeX/LaTeX environment ready"
echo "🐟 Fish shell configured"
echo "📝 You can now start developing!"