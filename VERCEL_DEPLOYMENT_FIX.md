# Vercel部署问题修复指南

## 🔍 问题分析

**原始错误**：
```
sh: line 1: /vercel/path0/node_modules/.bin/tsc: Permission denied
npm error code 126
```

**根本原因**：
- Vercel构建环境中，TypeScript编译器(`tsc`)缺少执行权限
- 这通常发生在使用`npm ci`安装依赖时，某些二进制文件权限设置不正确

## 🛠️ 解决方案

### 1. 修改构建脚本
在`package.json`中添加了专门的Vercel构建命令：

```json
{
  "scripts": {
    "build:vercel": "chmod +x node_modules/.bin/tsc 2>/dev/null || true && npx tsc --build && chmod +x build/index.js build/httpServer.js"
  }
}
```

### 2. 更新Vercel配置
在`vercel.json`中指定构建命令：

```json
{
  "version": 2,
  "buildCommand": "npm run build:vercel",
  "builds": [
    {
      "src": "build/httpServer.js",
      "use": "@vercel/node"
    }
  ]
}
```

### 3. 权限处理策略
- 使用`chmod +x node_modules/.bin/tsc`确保TypeScript编译器有执行权限
- 使用`2>/dev/null || true`忽略权限设置失败的情况
- 构建完成后为输出文件设置执行权限

## 🚀 部署步骤

### 方法1: 通过GitHub Actions（推荐）
1. 推送代码到main分支
2. GitHub Actions会自动触发Vercel部署
3. 查看Actions页面监控部署状态

### 方法2: 手动部署
1. 安装Vercel CLI：
   ```bash
   npm i -g vercel
   ```

2. 登录Vercel：
   ```bash
   vercel login
   ```

3. 部署到生产环境：
   ```bash
   vercel --prod
   ```

## 🔧 环境变量配置

在Vercel项目设置中添加以下环境变量：

```
TUSHARE_TOKEN=你的Tushare API令牌
NODE_ENV=production
```

## 📋 验证部署

部署完成后，访问以下端点验证：

1. **健康检查**：`https://your-project.vercel.app/health`
2. **MCP端点**：`https://your-project.vercel.app/mcp`

## 🐛 常见问题

### 构建仍然失败
- 检查Vercel项目设置中的Node.js版本（建议18.x）
- 确保所有依赖都在`dependencies`中，不在`devDependencies`
- 查看Vercel构建日志获取详细错误信息

### 权限问题持续存在
- 尝试在Vercel项目设置中禁用"Build Command"缓存
- 或者使用`npm install`而不是`npm ci`

### 运行时错误
- 检查环境变量是否正确配置
- 确保Tushare Token有效
- 查看Vercel函数日志

## 📚 相关文档

- [Vercel构建配置](https://vercel.com/docs/build-step)
- [Node.js函数配置](https://vercel.com/docs/functions/serverless-functions/runtimes/node-js)
- [环境变量配置](https://vercel.com/docs/environment-variables)

---

**注意**：如果问题仍然存在，可以尝试删除Vercel项目并重新创建，或者联系Vercel支持团队。
