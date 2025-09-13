# 独立仓库创建脚本使用说明

## 🎯 功能说明

这是一个**独立选择**的仓库创建脚本，您可以选择：
- **Gitee**：国内平台，访问速度快
- **GitHub**：国际平台，生态丰富

**注意**：每次只能选择一个平台创建仓库，不是同时创建两个。

## 🚀 快速开始

### 第一步：配置信息

编辑 `create_repo.sh`，修改配置：

```bash
# Gitee配置（已配置好）
GITEE_USERNAME="J_XH"
GITEE_TOKEN="4131649cbf28dbfc7e822312e82b671b"

# GitHub配置（需要您配置）
GITHUB_USERNAME="您的GitHub用户名"
GITHUB_TOKEN="您的GitHub访问令牌"
```

### 第二步：安装脚本

```bash
chmod +x create_repo.sh setup_repo_automation.sh
./setup_repo_automation.sh
```

### 第三步：使用脚本

```bash
# 进入项目目录
cd ~/Desktop/my-project

# 选择创建Gitee仓库
create_repo.sh gitee my-project "我的项目"

# 或者选择创建GitHub仓库
create_repo.sh github my-project "My Project"
```

## 📋 使用场景

### 场景1：只使用Gitee
```bash
create_repo.sh gitee project-name "项目描述"
```

### 场景2：只使用GitHub
```bash
create_repo.sh github project-name "Project Description"
```

### 场景3：根据项目类型选择平台
- **国内项目**：选择Gitee（速度快）
- **开源项目**：选择GitHub（生态好）
- **学习项目**：两个都可以

## ✨ 脚本特点

- 🎯 **独立选择**：每次只创建一个平台的仓库
- 🚀 **一键完成**：自动初始化Git、创建README、推送代码
- 🔧 **灵活配置**：可以只配置一个平台使用
- 📝 **自动生成**：自动创建项目说明文档

## ❓ 常见问题

**Q: 可以同时创建两个平台的仓库吗？**
A: 不可以。每次只能选择一个平台。如果需要两个平台，需要分别运行两次命令。

**Q: 只配置一个平台可以吗？**
A: 可以。如果只配置Gitee，就只能创建Gitee仓库；只配置GitHub，就只能创建GitHub仓库。

**Q: 如何获取访问令牌？**
A: 参考 `README_双平台使用说明.md` 中的详细步骤。

## 🔄 平台对比

| 特性 | Gitee | GitHub |
|------|-------|--------|
| 访问速度 | ✅ 国内快 | ⚠️ 可能慢 |
| 中文支持 | ✅ 优秀 | ⚠️ 一般 |
| 社区生态 | ⚠️ 较小 | ✅ 庞大 |
| 私有仓库 | ✅ 免费 | ⚠️ 有限制 |
| 学习资源 | ⚠️ 较少 | ✅ 丰富 |

选择哪个平台，完全根据您的需求决定！
