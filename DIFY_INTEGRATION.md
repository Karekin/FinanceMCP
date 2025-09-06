# Dify 集成 Finance MCP Server 指南

## 概述

本指南将帮助你在 Dify 中集成 Finance MCP Server，实现金融数据的智能查询和分析。

## 前置条件

- ✅ Finance MCP Server 已部署：`https://finance-mcp-ten.vercel.app`
- ✅ Dify 账户和访问权限
- ✅ 了解 Dify 的基本操作

## 步骤 1: 获取 MCP 服务信息

### 1.1 验证服务状态

```bash
curl https://finance-mcp-ten.vercel.app/
```

**预期响应**:
```json
{
  "name": "Finance MCP Server",
  "version": "1.0.0",
  "description": "A Model Context Protocol server for financial data",
  "endpoints": {
    "health": "/health",
    "mcp": "/mcp",
    "terminate": "/terminate"
  },
  "status": "running"
}
```

### 1.2 获取可用工具列表

```bash
curl -X POST https://finance-mcp-ten.vercel.app/mcp \
  -H "Content-Type: application/json" \
  -d '{"jsonrpc":"2.0","id":1,"method":"tools/list"}'
```

## 步骤 2: 在 Dify 中配置 MCP 连接

### 2.1 登录 Dify 平台

1. 访问 [Dify 官网](https://dify.ai)
2. 登录你的账户

### 2.2 创建新的应用

1. 点击 "创建应用"
2. 选择 "聊天助手" 或 "工作流"
3. 输入应用名称：`Finance Data Assistant`

### 2.3 配置 MCP 工具

#### 方法一：通过工具配置（推荐）

1. 进入应用设置
2. 点击 "工具" 标签
3. 点击 "添加工具"
4. 选择 "自定义工具" 或 "API 工具"

#### 方法二：通过工作流配置

1. 进入工作流编辑器
2. 添加 "HTTP 请求" 节点
3. 配置请求参数

## 步骤 3: 配置具体的金融工具

### 3.1 股票数据查询工具

**工具名称**: `stock_data_query`

**请求配置**:
- **URL**: `https://finance-mcp-ten.vercel.app/mcp`
- **方法**: `POST`
- **Headers**:
  ```json
  {
    "Content-Type": "application/json"
  }
  ```

**请求体模板**:
```json
{
  "jsonrpc": "2.0",
  "id": 1,
  "method": "tools/call",
  "params": {
    "name": "stock_data",
    "arguments": {
      "code": "{{股票代码}}",
      "market_type": "{{市场类型}}",
      "start_date": "{{开始日期}}",
      "end_date": "{{结束日期}}",
      "indicators": "{{技术指标}}"
    }
  }
}
```

**参数说明**:
- `股票代码`: 如 `000001.SZ`（平安银行）、`AAPL`（苹果）
- `市场类型`: `cn`（A股）、`us`（美股）、`hk`（港股）
- `开始日期`: `20240101`
- `结束日期`: `20240131`
- `技术指标`: `ma(10,20) rsi(14) macd(12,26,9)`

### 3.2 财经新闻查询工具

**工具名称**: `finance_news_query`

**请求配置**:
- **URL**: `https://finance-mcp-ten.vercel.app/mcp`
- **方法**: `POST`
- **Headers**: `Content-Type: application/json`

**请求体模板**:
```json
{
  "jsonrpc": "2.0",
  "id": 2,
  "method": "tools/call",
  "params": {
    "name": "finance_news",
    "arguments": {
      "query": "{{搜索关键词}}"
    }
  }
}
```

### 3.3 公司财务数据工具

**工具名称**: `company_financial_data`

**请求体模板**:
```json
{
  "jsonrpc": "2.0",
  "id": 3,
  "method": "tools/call",
  "params": {
    "name": "company_performance",
    "arguments": {
      "ts_code": "{{股票代码}}",
      "data_type": "{{数据类型}}",
      "start_date": "{{开始日期}}",
      "end_date": "{{结束日期}}"
    }
  }
}
```

**数据类型选项**:
- `indicators`: 财务指标
- `balance_basic`: 核心资产负债表
- `income_basic`: 核心利润表
- `cashflow_basic`: 基础现金流

## 步骤 4: 配置提示词模板

### 4.1 基础提示词

```
你是一个专业的金融数据分析助手，可以帮用户查询和分析各种金融数据。

可用的工具包括：
1. 股票数据查询 - 获取股票历史行情和技术指标
2. 财经新闻查询 - 搜索相关财经新闻
3. 公司财务数据 - 获取公司财务报表和指标
4. 宏观经济数据 - 查询利率、GDP、CPI等宏观指标
5. 基金数据 - 查询公募基金和基金经理信息

请根据用户的问题选择合适的工具，并提供详细的分析结果。
```

### 4.2 专业分析提示词

```
作为金融数据分析专家，你需要：

1. **数据获取**: 使用合适的工具获取准确的金融数据
2. **数据分析**: 对获取的数据进行专业分析
3. **趋势判断**: 基于历史数据判断趋势
4. **风险评估**: 提供投资风险评估
5. **建议总结**: 给出专业的投资建议

分析时请注意：
- 数据的时效性和准确性
- 技术指标的综合分析
- 宏观经济环境的影响
- 行业和公司的基本面分析
```

## 步骤 5: 测试集成效果

### 5.1 测试用例

**测试 1: 股票查询**
```
用户: 帮我查询平安银行(000001.SZ)最近一个月的股价走势和技术指标
```

**测试 2: 新闻分析**
```
用户: 搜索关于人工智能在金融领域应用的最新新闻
```

**测试 3: 财务分析**
```
用户: 分析腾讯控股(00700.HK)的财务状况和盈利能力
```

### 5.2 预期响应格式

工具应该返回结构化的数据，包括：
- 原始数据
- 数据解读
- 趋势分析
- 投资建议

## 步骤 6: 高级配置

### 6.1 错误处理

在 Dify 中配置错误处理逻辑：

```json
{
  "error_handling": {
    "retry_count": 3,
    "timeout": 30000,
    "fallback_message": "数据获取失败，请稍后重试"
  }
}
```

### 6.2 数据缓存

配置数据缓存以提高响应速度：

```json
{
  "cache": {
    "enabled": true,
    "ttl": 300,
    "key_template": "finance_data_{{参数}}"
  }
}
```

### 6.3 数据格式化

配置数据格式化输出：

```json
{
  "formatting": {
    "number_format": "comma_separated",
    "date_format": "YYYY-MM-DD",
    "currency_format": "CNY"
  }
}
```

## 步骤 7: 部署和监控

### 7.1 部署检查

1. 验证所有工具配置正确
2. 测试各种查询场景
3. 检查错误处理机制
4. 确认数据格式正确

### 7.2 监控指标

- API 调用成功率
- 响应时间
- 错误率
- 用户满意度

## 常见问题解决

### Q1: 工具调用失败
**解决方案**:
- 检查 URL 是否正确
- 验证请求格式
- 确认参数类型

### Q2: 数据格式错误
**解决方案**:
- 检查 JSON 解析
- 验证数据字段
- 调整格式化配置

### Q3: 响应超时
**解决方案**:
- 增加超时时间
- 优化查询参数
- 添加重试机制

## 最佳实践

1. **参数验证**: 在调用前验证所有必需参数
2. **错误处理**: 实现完善的错误处理机制
3. **数据缓存**: 对频繁查询的数据进行缓存
4. **用户引导**: 提供清晰的参数说明和示例
5. **性能优化**: 合理设置查询时间范围

## 技术支持

如遇到问题，请检查：
1. Finance MCP Server 状态：`https://finance-mcp-ten.vercel.app/health`
2. 工具列表：`https://finance-mcp-ten.vercel.app/mcp`
3. 详细文档：`API_USAGE.md`

---

通过以上步骤，你就可以在 Dify 中成功集成 Finance MCP Server，实现智能的金融数据查询和分析功能。
