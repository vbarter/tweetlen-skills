# Tweetlen Skills for Claude Code

> 基于 Tweetlen API 的 Twitter/X 数据分析技能集

> **⚠️ 前置条件：申请并配置 API Key**
>
> 使用本 Skills 前，你需要：
>
> **第一步：申请 Key**
> 1. 访问 [api.tweetlen.com](https://api.tweetlen.com) 注册账号
> 2. 在控制台创建 API Key（格式：`twtl_xxx`）
>
> **第二步：配置 Key**（任选一种）
>
> 推荐：写入 Claude Code 配置（一次配置，永久生效）：
> ```bash
> # 编辑 ~/.claude/settings.json
> {
>   "env": {
>     "TWEETLEN_API_KEY": "twtl_your_key_here"
>   }
> }
> ```
>
> 或：设置环境变量：
> ```bash
> export TWEETLEN_API_KEY=twtl_your_key_here
> ```
>
> 或：写入项目级配置（`.claude/settings.local.json`，不会被 git 提交）：
> ```json
> {
>   "env": {
>     "TWEETLEN_API_KEY": "twtl_your_key_here"
>   }
> }
> ```
>
> 所有 Skills 均通过 Tweetlen API 获取 Twitter/X 数据。

## 功能特性

Tweetlen Skills 分为 4 个插件组：

- **api-skills** - Twitter/X API 端点封装，覆盖用户、推文、搜索、社区、列表、趋势、Space 和招聘
- **analysis-skills** - 多步骤分析工作流，包括用户画像、推文分析、用户对比和影响力报告
- **research-skills** - 话题研究、趋势监控、社区和列表探索工作流
- **utility-skills** - 快速用户查询和职位搜索工具

## 安装

```bash
# 1. 添加 marketplace
/plugin marketplace add vbarter/tweetlen-skills

# 2. 安装需要的插件
/plugin install api-skills@tweetlen-skills
/plugin install analysis-skills@tweetlen-skills
/plugin install research-skills@tweetlen-skills
/plugin install utility-skills@tweetlen-skills
```

## 技能一览

| 技能 | 插件 | 描述 |
|------|------|------|
| `tweetlen-api-user` | api-skills | 获取用户资料、粉丝、关注列表和媒体 |
| `tweetlen-api-tweet` | api-skills | 获取推文详情、回复、引用、转发和点赞 |
| `tweetlen-api-search` | api-skills | 搜索推文、用户和内容 |
| `tweetlen-api-community` | api-skills | 浏览社区详情、成员和时间线 |
| `tweetlen-api-list` | api-skills | 浏览列表详情、成员和时间线 |
| `tweetlen-api-trends` | api-skills | 获取各地区热门趋势 |
| `tweetlen-api-space` | api-skills | 获取 Twitter Space 详情 |
| `tweetlen-api-jobs` | api-skills | 搜索和查看职位列表 |
| `tweetlen-user-profile` | analysis-skills | 生成全面的用户画像分析报告 |
| `tweetlen-tweet-analysis` | analysis-skills | 分析推文互动和内容模式 |
| `tweetlen-user-comparison` | analysis-skills | 多账号横向对比分析 |
| `tweetlen-influence-report` | analysis-skills | 生成 KOL 影响力和传播力报告 |
| `tweetlen-topic-research` | research-skills | 跨推文、用户和社区的话题研究 |
| `tweetlen-trend-monitor` | research-skills | 监控和分析热门趋势 |
| `tweetlen-community-explorer` | research-skills | 深入探索社区结构和活跃度 |
| `tweetlen-list-explorer` | research-skills | 探索精选列表及其成员 |
| `tweetlen-user-lookup` | utility-skills | 快速用户信息查询 |
| `tweetlen-job-search` | utility-skills | 搜索 Twitter 职位信息 |

## 使用示例

**分析用户画像：**

```
/tweetlen-user-profile @elonmusk
```

**研究某个话题：**

```
/tweetlen-topic-research "人工智能" --lang zh
```

**对比两个账号：**

```
/tweetlen-user-comparison @openai @anthropic
```

## API 文档

完整的 API 文档和密钥获取，请访问 [api.tweetlen.com](https://api.tweetlen.com)。

## 许可证

MIT
