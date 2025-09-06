# Finance MCP Server API 使用指南

## 服务信息

- **服务地址**: `https://finance-mcp-ten.vercel.app`
- **服务状态**: ✅ 正常运行
- **协议**: JSON-RPC 2.0 over HTTP

## 可用端点

| 端点 | 方法 | 描述 |
|------|------|------|
| `/` | GET | 服务信息 |
| `/health` | GET | 健康检查 |
| `/mcp` | POST | MCP 协议接口 |
| `/terminate` | GET/POST | 终止会话 |

## 快速开始

### 1. 检查服务状态

```bash
curl https://finance-mcp-ten.vercel.app/
```

**响应**:
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

### 2. 健康检查

```bash
curl https://finance-mcp-ten.vercel.app/health
```

**响应**:
```json
{
  "status": "healthy",
  "transport": "streamable-http",
  "activeSessions": 0
}
```

### 3. 获取可用工具列表

```bash
curl -X POST https://finance-mcp-ten.vercel.app/mcp \
  -H "Content-Type: application/json" \
  -d '{"jsonrpc":"2.0","id":1,"method":"tools/list"}'
```

## 工具调用示例

### 1. 获取当前时间

```bash
curl -X POST https://finance-mcp-ten.vercel.app/mcp \
  -H "Content-Type: application/json" \
  -d '{
    "jsonrpc": "2.0",
    "id": 1,
    "method": "tools/call",
    "params": {
      "name": "current_timestamp",
      "arguments": {
        "format": "readable"
      }
    }
  }'
```

### 2. 获取股票数据

```bash
curl -X POST https://finance-mcp-ten.vercel.app/mcp \
  -H "Content-Type: application/json" \
  -d '{
    "jsonrpc": "2.0",
    "id": 2,
    "method": "tools/call",
    "params": {
      "name": "stock_data",
      "arguments": {
        "code": "000001.SZ",
        "market_type": "cn",
        "start_date": "20240101",
        "end_date": "20240131",
        "indicators": "ma(10,20) rsi(14)"
      }
    }
  }'
```

### 3. 获取财经新闻

```bash
curl -X POST https://finance-mcp-ten.vercel.app/mcp \
  -H "Content-Type: application/json" \
  -d '{
    "jsonrpc": "2.0",
    "id": 3,
    "method": "tools/call",
    "params": {
      "name": "finance_news",
      "arguments": {
        "query": "美联储 加息"
      }
    }
  }'
```

### 4. 获取公司财务数据

```bash
curl -X POST https://finance-mcp-ten.vercel.app/mcp \
  -H "Content-Type: application/json" \
  -d '{
    "jsonrpc": "2.0",
    "id": 4,
    "method": "tools/call",
    "params": {
      "name": "company_performance",
      "arguments": {
        "ts_code": "000001.SZ",
        "data_type": "indicators",
        "start_date": "20230101",
        "end_date": "20231231"
      }
    }
  }'
```

## 可用工具列表

### 基础工具
- **current_timestamp**: 获取当前东八区时间
- **finance_news**: 获取财经新闻
- **hot_news_7x24**: 获取7x24热点新闻

### 股票数据
- **stock_data**: 获取股票历史行情数据（A股、美股、港股、外汇、期货等）
- **index_data**: 获取股票指数数据
- **company_performance**: 获取A股公司综合表现数据
- **company_performance_hk**: 获取港股公司财务数据
- **company_performance_us**: 获取美股公司财务数据

### 基金数据
- **fund_data**: 获取公募基金数据
- **fund_manager_by_name**: 根据姓名查询基金经理信息

### 宏观数据
- **macro_econ**: 获取宏观经济数据（利率、GDP、CPI等）

### 交易数据
- **block_trade**: 获取大宗交易数据
- **money_flow**: 获取资金流向数据
- **margin_trade**: 获取融资融券数据
- **dragon_tiger_inst**: 获取龙虎榜机构成交明细

### 其他
- **convertible_bond**: 获取可转债数据
- **csi_index_constituents**: 获取中证指数成分股数据

## 错误处理

所有错误都会返回标准的 JSON-RPC 错误响应：

```json
{
  "jsonrpc": "2.0",
  "error": {
    "code": -32000,
    "message": "错误描述"
  },
  "id": 1
}
```

## 注意事项

1. **请求格式**: 所有请求必须使用 `Content-Type: application/json`
2. **参数格式**: 日期参数使用 `YYYYMMDD` 格式
3. **股票代码**: 
   - A股: `000001.SZ` (深圳), `600000.SH` (上海)
   - 港股: `00700.HK`
   - 美股: `AAPL`, `TSLA`
4. **数据限制**: 某些接口有数据量限制，建议指定时间范围

## 技术支持

如有问题，请检查：
1. 服务状态: `GET /health`
2. 工具列表: `POST /mcp` with `method: "tools/list"`
3. 参数格式是否正确
4. 网络连接是否正常
