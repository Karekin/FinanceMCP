#!/bin/bash

# Vercel构建脚本
# 解决权限问题并确保正确构建

set -e

echo "🔧 开始Vercel构建..."

# 确保TypeScript编译器有执行权限
if [ -f "node_modules/.bin/tsc" ]; then
    chmod +x node_modules/.bin/tsc
    echo "✅ TypeScript编译器权限已设置"
fi

# 运行TypeScript编译
echo "📦 编译TypeScript..."
npx tsc --build

# 检查构建输出
if [ ! -f "build/index.js" ]; then
    echo "❌ 构建失败: build/index.js 不存在"
    exit 1
fi

if [ ! -f "build/httpServer.js" ]; then
    echo "❌ 构建失败: build/httpServer.js 不存在"
    exit 1
fi

# 设置执行权限
chmod +x build/index.js
chmod +x build/httpServer.js

echo "✅ 构建完成!"
echo "📁 构建文件:"
ls -la build/

echo "🚀 Vercel构建脚本执行完成"
