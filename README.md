# 自动化仓库管理工具

一个支持Gitee和GitHub的自动化仓库创建和自动提交工具。

## 🚀 快速开始

### 安装脚本
```bash
chmod +x create_repo.sh setup_repo_automation.sh
./setup_repo_automation.sh
```

### 使用脚本
```bash
# 创建Gitee仓库
create_repo.sh gitee my-project "我的项目"

# 创建GitHub仓库
create_repo.sh github my-project "My Project"
```

## 🆕 自动提交功能

### 完全自动化提交（推荐）
```bash
# 启动文件监控模式 - 文件变化时立即自动提交
./start_auto_commit.sh
# 选择选项1（文件监控模式）

# 或者直接启动文件监控
./auto_commit_watcher.sh
```

### 定时自动提交
```bash
# 每60秒自动检查并提交
./auto_commit_timer.sh 60

# 每30秒自动检查并提交
./auto_commit_timer.sh 30
```

### 手动快速提交
```bash
# 快速提交并推送
gcp "你的提交信息"

# 或者使用传统方式
git add . && git commit -m "你的提交信息" && git push
```

## 📋 功能特点

### 仓库创建功能
- 🎯 **独立选择**：每次只选择一个平台（Gitee 或 GitHub）
- 🚀 **一键完成**：自动初始化Git、创建README、推送代码
- 🔧 **灵活配置**：可以只配置一个平台使用
- 📝 **自动生成**：自动创建项目说明文档

### 自动提交功能
- 🤖 **完全自动化**：文件变化时自动提交，无需手动操作
- ⏰ **定时提交**：可设置任意时间间隔自动检查并提交
- 🔄 **自动推送**：提交后自动推送到GitHub和Gitee
- 🛡️ **智能防重复**：避免频繁提交相同内容
- 📊 **详细日志**：显示每次自动操作的结果
- 🎛️ **多种模式**：文件监控、定时提交、手动提交

## 🛠️ 自动化脚本说明

| 脚本文件 | 功能描述 | 使用场景 |
|---------|---------|---------|
| `auto_commit_watcher.sh` | 文件监控自动提交 | 开发时实时自动保存 |
| `auto_commit_timer.sh` | 定时自动提交 | 长时间工作定期保存 |
| `start_auto_commit.sh` | 一键启动器 | 交互式选择模式 |
| `setup_new_project.sh` | 新项目初始化 | 创建带自动提交功能的新项目 |

## 📖 详细说明

查看 `README_使用说明.md` 获取完整的使用指南。

## 贡献

欢迎提交Issue和Pull Request！
