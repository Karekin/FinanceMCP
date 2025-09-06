# Dify 快速集成指南

## 🚀 5分钟快速开始

### 1. 验证服务状态
```bash
curl https://finance-mcp-ten.vercel.app/health
```

### 2. 在 Dify 中创建工具

#### 步骤 1: 登录 Dify
访问 [dify.ai](https://dify.ai) 并登录

#### 步骤 2: 创建应用
- 点击 "创建应用"
- 选择 "聊天助手"
- 应用名称：`金融数据助手`

#### 步骤 3: 添加工具
进入应用设置 → 工具 → 添加工具 → 自定义工具

### 3. 配置核心工具

#### 工具 1: 股票数据查询

**基本信息**:
- 工具名称: `股票数据查询`
- 工具描述: `获取股票历史行情和技术指标数据`

**API 配置**:
- URL: `https://finance-mcp-ten.vercel.app/mcp`
- 方法: `POST`
- Headers: `Content-Type: application/json`

**请求体**:
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

**参数配置**:
- `股票代码`: 文本输入，示例：`000001.SZ`
- `市场类型`: 下拉选择，选项：`cn`(A股)、`us`(美股)、`hk`(港股)
- `开始日期`: 文本输入，格式：`20240101`
- `结束日期`: 文本输入，格式：`20240131`
- `技术指标`: 文本输入，示例：`ma(10,20) rsi(14)`

#### 工具 2: 财经新闻查询

**API 配置**:
- URL: `https://finance-mcp-ten.vercel.app/mcp`
- 方法: `POST`
- Headers: `Content-Type: application/json`

**请求体**:
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

**参数配置**:
- `搜索关键词`: 文本输入，示例：`人工智能 金融`

#### 工具 3: 公司财务数据

**API 配置**:
- URL: `https://finance-mcp-ten.vercel.app/mcp`
- 方法: `POST`
- Headers: `Content-Type: application/json`

**请求体**:
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

**参数配置**:
- `股票代码`: 文本输入，示例：`000001.SZ`
- `数据类型`: 下拉选择，选项：`indicators`(财务指标)、`balance_basic`(资产负债表)、`income_basic`(利润表)
- `开始日期`: 文本输入，格式：`20230101`
- `结束日期`: 文本输入，格式：`20231231`

### 4. 配置提示词

```
你是一个专业的金融数据分析助手。你可以帮助用户：

1. 查询股票历史行情和技术指标
2. 搜索相关财经新闻
3. 分析公司财务数据
4. 提供投资建议

请根据用户的问题选择合适的工具，并提供详细的分析结果。
```

### 5. 测试对话

**测试用例 1**:
```
用户: 帮我查询平安银行(000001.SZ)最近一个月的股价走势
```

**测试用例 2**:
```
用户: 搜索关于人工智能的最新财经新闻
```

**测试用例 3**:
```
用户: 分析腾讯控股(00700.HK)的财务状况
```

## 🔧 高级配置

### 错误处理
在工具配置中添加错误处理：
```json
{
  "error_handling": {
    "retry_count": 3,
    "timeout": 30000
  }
}
```

### 数据格式化
配置输出格式：
```json
{
  "response_format": {
    "type": "json",
    "template": "基于获取的数据，我为您分析如下：\n\n{{数据内容}}\n\n分析结论：{{分析结果}}"
  }
}
```

## 📋 完整工具列表

你的 MCP 服务支持以下工具：

| 工具名称 | 功能描述 | 主要参数 |
|---------|---------|---------|
| `stock_data` | 股票数据查询 | code, market_type, start_date, end_date |
| `finance_news` | 财经新闻搜索 | query |
| `company_performance` | 公司财务数据 | ts_code, data_type, start_date, end_date |
| `macro_econ` | 宏观经济数据 | indicator, start_date, end_date |
| `fund_data` | 基金数据查询 | ts_code, data_type |
| `index_data` | 指数数据查询 | code, start_date, end_date |
| `money_flow` | 资金流向数据 | ts_code, start_date, end_date |
| `block_trade` | 大宗交易数据 | code, start_date, end_date |
| `current_timestamp` | 当前时间 | format |

## 🚨 注意事项

1. **日期格式**: 所有日期参数使用 `YYYYMMDD` 格式
2. **股票代码**: 
   - A股: `000001.SZ` (深圳), `600000.SH` (上海)
   - 港股: `00700.HK`
   - 美股: `AAPL`, `TSLA`
3. **技术指标**: 使用空格分隔多个指标，如 `ma(10,20) rsi(14)`
4. **请求频率**: 建议控制请求频率，避免过于频繁的调用

## 🆘 故障排除

### 常见问题

**Q: 工具调用返回错误**
- 检查 URL 是否正确
- 验证参数格式
- 确认服务状态

**Q: 数据格式异常**
- 检查 JSON 解析
- 验证字段名称
- 调整格式化配置

**Q: 响应超时**
- 增加超时时间
- 优化查询参数
- 检查网络连接

### 调试方法

1. 检查服务状态：
```bash
curl https://finance-mcp-ten.vercel.app/health
```

2. 测试工具调用：
```bash
curl -X POST https://finance-mcp-ten.vercel.app/mcp \
  -H "Content-Type: application/json" \
  -d '{"jsonrpc":"2.0","id":1,"method":"tools/list"}'
```

3. 查看详细日志：
访问 Dify 应用设置中的日志页面

---

按照以上步骤，你就可以在 5 分钟内完成 Dify 与 Finance MCP Server 的集成！
