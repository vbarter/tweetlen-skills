<div align="center">

# Tweetlen Skills

**Claude Code 向け Twitter/X データ分析スキル**

[![Version](https://img.shields.io/badge/version-0.1.0-blue.svg)](https://github.com/vbarter/tweetlen-skills)
[![Skills](https://img.shields.io/badge/skills-18-green.svg)](#スキル一覧)
[![License](https://img.shields.io/badge/license-MIT-brightgreen.svg)](LICENSE)

Claude Code を Twitter/X データ分析アシスタントに。
ユーザー検索、ツイート分析、トピックリサーチ、トレンド監視を自然言語で実行できます。

[**English**](README.md) | [**中文**](README.zh.md) | [**日本語**](README.ja.md)

</div>

---

## インストール

```bash
# 1. マーケットプレイスを追加
/plugin marketplace add vbarter/tweetlen-skills

# 2. 必要なプラグインをインストール
/plugin install api-skills@tweetlen-skills
/plugin install analysis-skills@tweetlen-skills
/plugin install research-skills@tweetlen-skills
/plugin install utility-skills@tweetlen-skills

# 3. API Key を設定（対話式）
bash ~/.claude/plugins/tweetlen-skills/setup.sh
```

## API Key の設定

> [!IMPORTANT]
> **このスキルを使用するには Tweetlen API Key が必要です。**
>
> 1. **[api.tweetlen.com](https://api.tweetlen.com)** でアカウントを作成
> 2. ダッシュボードで API Key を発行（形式: `twtl_xxx`）
> 3. 以下のいずれかの方法で Key を設定：

### クイックセットアップ（推奨）

セットアップスクリプトを実行すると、`~/.claude/settings.json` に Key を自動書き込みします：

```bash
bash ~/.claude/plugins/tweetlen-skills/setup.sh
```

> セットアップ後、Claude Code を再起動してください。

### 手動設定

<details open>
<summary><b>方法 1: Claude Code 設定ファイル（推奨）</b></summary>

`~/.claude/settings.json` の `env` フィールドに `TWEETLEN_API_KEY` を追加：

```json
{
  "env": {
    "TWEETLEN_API_KEY": "twtl_your_key_here"
  }
}
```

一度設定すれば全プロジェクトで有効。Bash/curl 呼び出し時に環境変数として自動注入されます。

</details>

<details>
<summary><b>方法 2: プロジェクト単位の設定</b></summary>

プロジェクトルートに `.claude/settings.local.json` を作成（git 管理外）：

```json
{
  "env": {
    "TWEETLEN_API_KEY": "twtl_your_key_here"
  }
}
```

</details>

<details>
<summary><b>方法 3: シェル環境変数</b></summary>

```bash
export TWEETLEN_API_KEY=twtl_your_key_here
```

> 注意: `.zshrc` / `.bashrc` で export する必要があります。

</details>

## クイックスタート

```
あなた: @elonmusk のアカウントを分析して
あなた: 「Claude AI」についてツイッターで何が言われてる？
あなた: @openai と @anthropic を比較して
あなた: 今世界で何がトレンドになってる？
あなた: @naval を調べて
```

Claude Code が自動的に適切なスキルを選択して実行します。

## スキル一覧

### API Skills — エンドポイントラッパー

低レベルの構成要素。各スキルは Twitter/X API の1カテゴリをラップし、パラメータの説明と使用例を提供します。

| スキル | エンドポイント数 | 機能 |
|--------|:---------------:|------|
| `tweetlen-api-user` | 16 | ユーザー情報、フォロワー、フォロー、ツイート、リプライ、メディア、ハイライト |
| `tweetlen-api-tweet` | 7 | ツイート詳細、コメント、リツイート、引用 |
| `tweetlen-api-search` | 4 | 全文検索（v1/v2/v3）、オートコンプリート |
| `tweetlen-api-community` | 10 | コミュニティ検索、トピック、メンバー、モデレーター、ツイート |
| `tweetlen-api-list` | 5 | リスト検索、詳細、メンバー、フォロワー、タイムライン |
| `tweetlen-api-trends` | 2 | 利用可能な地域、地域別トレンドトピック |
| `tweetlen-api-space` | 1 | スペース（音声ルーム）の詳細 |
| `tweetlen-api-jobs` | 3 | 求人検索、詳細、地域候補 |

### Analysis Skills — 分析ワークフロー

複数の API 呼び出しと分析ロジックを組み合わせ、構造化されたレポートを生成します。

| スキル | 機能 |
|--------|------|
| `tweetlen-user-profile` | 総合ユーザー分析：プロフィール + ツイート + フォロワー + エンゲージメント指標 |
| `tweetlen-tweet-analysis` | ツイート詳細分析：コメント + リツイート + 引用 + センチメント |
| `tweetlen-user-comparison` | 2アカウントの並列比較分析 |
| `tweetlen-influence-report` | KOL 影響力評価とティア分類 |

### Research Skills — リサーチワークフロー

トレンドやトピックの分析に特化した多段階リサーチワークフロー。

| スキル | 機能 |
|--------|------|
| `tweetlen-topic-research` | トピックの感情分析：検索 + キーパーソン + コメント分析 |
| `tweetlen-trend-monitor` | 地域別トレンド監視 + トップトレンドの文脈分析 |
| `tweetlen-community-explorer` | コミュニティの深堀り：構造、メンバー、モデレーター、コンテンツ |
| `tweetlen-list-explorer` | リスト探索：メンバー、タイムライン、フォロワー分析 |

### Utility Skills — ユーティリティ

| スキル | 機能 |
|--------|------|
| `tweetlen-user-lookup` | ユーザー名 → rest_id の高速変換 + 基本情報表示 |
| `tweetlen-job-search` | Twitter/X の求人検索（フィルター対応） |

## 使用例

### ユーザー分析

```
あなた: @naval のプロフィールを分析して
あなた: @elonmusk はどんなアカウント？詳しく教えて
あなた: Who is @pmarca?
```

### トピックリサーチ

```
あなた: 「量子コンピュータ」についてツイッターでの反応を調べて
あなた: AI規制について皆どう思ってる？
あなた: What's Twitter saying about "GPT-5"?
```

### トレンド監視

```
あなた: 日本で今何がトレンドになってる？
あなた: アメリカのトレンドを見せて
あなた: 世界のトレンドを教えて
```

### アカウント比較

```
あなた: @openai と @anthropic を比較して
あなた: @Google と @Microsoft の違いを分析して
```

### コミュニティ探索

```
あなた: AI 関連の Twitter コミュニティを探索して
あなた: 「Generative AI」コミュニティの詳細を教えて
```

## アーキテクチャ

```
┌───────────────────────────────────────────────┐
│              Claude Code + Skills              │
├──────────┬──────────┬───────────┬──────────────┤
│ Analysis │ Research │  Utility  │     API      │
│ Skills   │ Skills   │  Skills   │    Skills    │
├──────────┴──────────┴───────────┴──────────────┤
│           Tweetlen API (api.tweetlen.com)       │
│              Authorization: Bearer twtl_xxx     │
├────────────────────────────────────────────────┤
│              Twitter/X プラットフォーム           │
└────────────────────────────────────────────────┘
```

## API リファレンス

| ベース URL | 認証 | メソッド | ページネーション |
|-----------|------|---------|----------------|
| `https://api.tweetlen.com/v2` | `Bearer twtl_xxx` | GET | カーソルベース |

完全な API ドキュメントは **[api.tweetlen.com](https://api.tweetlen.com)** をご覧ください。

## コントリビュート

Issue や Pull Request を歓迎します！

## ライセンス

[MIT](LICENSE)
