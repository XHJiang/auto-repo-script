#!/bin/bash

# 新项目自动配置脚本
# 使用方法: ./setup_new_project.sh <项目名称> <GitHub用户名>

# 设置颜色输出
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# 检查参数
if [ $# -lt 2 ]; then
    echo -e "${RED}使用方法: $0 <项目名称> <GitHub用户名>${NC}"
    echo -e "${YELLOW}示例: $0 my-awesome-project xwy${NC}"
    exit 1
fi

PROJECT_NAME=$1
GITHUB_USERNAME=$2
CURRENT_DIR=$(pwd)

echo -e "${BLUE}🚀 开始配置新项目: $PROJECT_NAME${NC}"

# 创建项目目录
if [ ! -d "$PROJECT_NAME" ]; then
    mkdir "$PROJECT_NAME"
    echo -e "${GREEN}✅ 创建项目目录: $PROJECT_NAME${NC}"
else
    echo -e "${YELLOW}⚠️  项目目录已存在: $PROJECT_NAME${NC}"
fi

cd "$PROJECT_NAME"

# 初始化Git仓库
if [ ! -d ".git" ]; then
    git init
    echo -e "${GREEN}✅ 初始化Git仓库${NC}"
else
    echo -e "${YELLOW}⚠️  Git仓库已存在${NC}"
fi

# 创建基础文件
echo "# $PROJECT_NAME" > README.md
echo "" >> README.md
echo "## 项目描述" >> README.md
echo "" >> README.md
echo "这是一个使用自动同步功能的项目。" >> README.md
echo "" >> README.md
echo "## 功能特性" >> README.md
echo "" >> README.md
echo "- 自动保存和提交" >> README.md
echo "- 自动推送到GitHub" >> README.md
echo "- 智能代码格式化" >> README.md

# 创建.gitignore
cat > .gitignore << EOF
# 依赖
node_modules/
__pycache__/
*.pyc
*.pyo
*.pyd
.Python
env/
venv/
.venv/

# 系统文件
.DS_Store
Thumbs.db
*.log

# IDE
.vscode/settings.json
.idea/
*.swp
*.swo

# 构建输出
dist/
build/
*.egg-info/
EOF

echo -e "${GREEN}✅ 创建基础文件${NC}"

# 创建Cursor配置
mkdir -p .vscode

cat > .vscode/settings.json << EOF
{
    "files.autoSave": "afterDelay",
    "files.autoSaveDelay": 1000,
    "git.enableSmartCommit": true,
    "git.confirmSync": false,
    "git.autofetch": true,
    "git.autoStash": true,
    "terminal.integrated.shell.osx": "/bin/zsh",
    "workbench.editor.enablePreview": false,
    "editor.formatOnSave": true,
    "editor.codeActionsOnSave": {
        "source.organizeImports": true
    },
    "git.postCommitCommand": "push",
    "git.showPushSuccessNotification": true,
    "git.showActionButton": {
        "commit": true,
        "publish": true,
        "syncChanges": true
    }
}
EOF

cat > .vscode/tasks.json << EOF
{
    "version": "2.0.0",
    "tasks": [
        {
            "label": "快速提交并推送",
            "type": "shell",
            "command": "git add . && git commit -m '快速提交: \$(date)' && git push origin main",
            "group": "build",
            "presentation": {
                "echo": true,
                "reveal": "always",
                "focus": false,
                "panel": "shared"
            }
        }
    ]
}
EOF

echo -e "${GREEN}✅ 创建Cursor配置${NC}"

# 首次提交
git add .
git commit -m "初始提交: 项目 $PROJECT_NAME 创建完成

- 配置了自动同步功能
- 添加了基础项目文件
- 设置了Cursor开发环境"

echo -e "${GREEN}✅ 完成首次提交${NC}"

# 提示用户添加远程仓库
echo -e "${YELLOW}📝 接下来请手动添加远程仓库:${NC}"
echo -e "${BLUE}git remote add origin https://github.com/$GITHUB_USERNAME/$PROJECT_NAME.git${NC}"
echo -e "${BLUE}git push -u origin main${NC}"
echo ""
echo -e "${GREEN}🎉 项目 $PROJECT_NAME 配置完成！${NC}"
echo -e "${YELLOW}💡 提示: 现在可以使用 Cmd+Shift+G 快速提交并推送${NC}"

cd "$CURRENT_DIR"
