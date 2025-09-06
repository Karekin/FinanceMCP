# Vercel 部署指南

## 🚀 快速部署到Vercel

### 方法1: 通过GitHub Actions自动部署（推荐）

1. **Fork本项目** 到你的GitHub账户
2. **在Vercel中创建项目**：
   - 访问 [vercel.com](https://vercel.com)
   - 点击 "New Project"
   - 选择你的GitHub仓库
   - 配置项目设置

3. **获取Vercel配置信息**：
   - Vercel Token: Settings > Tokens > Create Token
   - Org ID: 项目设置中的Organization ID
   - Project ID: 项目设置中的Project ID

4. **配置GitHub Secrets**：
   - 进入GitHub仓库 > Settings > Secrets and variables > Actions
   - 添加以下secrets：
     ```
     VERCEL_TOKEN=你的Vercel令牌
     VERCEL_ORG_ID=你的Vercel组织ID
     VERCEL_PROJECT_ID=你的Vercel项目ID
     ```

5. **推送代码**：
   ```bash
   git push origin main
   ```
   自动触发部署！

### 方法2: 手动部署

1. **安装Vercel CLI**：
   ```bash
   npm i -g vercel
   ```

2. **构建项目**：
   ```bash
   npm run build
   ```

3. **部署到Vercel**：
   ```bash
   vercel --prod
   ```

## 🔧 环境变量配置

在Vercel项目设置中添加以下环境变量：

```
TUSHARE_TOKEN=你的Tushare API令牌
NODE_ENV=production
```

## 📋 部署后验证

1. **检查部署状态** - 在Vercel Dashboard中查看部署状态
2. **测试API端点** - 访问 `https://your-project.vercel.app/health`
3. **测试MCP端点** - 访问 `https://your-project.vercel.app/mcp`

## 🐛 常见问题

### 构建失败
- 检查Node.js版本（需要18+）
- 确保所有依赖都已安装
- 查看构建日志中的具体错误

### 运行时错误
- 检查环境变量是否正确配置
- 确保Tushare Token有效
- 查看Vercel函数日志

### 部署超时
- 检查网络连接
- 确保Vercel Token有效
- 查看GitHub Actions日志

## 📚 相关链接

- [Vercel官方文档](https://vercel.com/docs)
- [Vercel CLI文档](https://vercel.com/docs/cli)
- [GitHub Actions文档](https://docs.github.com/en/actions)
