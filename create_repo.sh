#!/bin/bash

# 独立仓库创建和推送脚本
# 支持 Gitee 和 GitHub（二选一）
# 使用方法: ./create_repo.sh <平台> <项目名称> [描述]
# 平台: gitee 或 github

# 配置信息
GITEE_USERNAME="YOUR_GITEE_USERNAME"
GITEE_TOKEN="YOUR_GITEE_TOKEN"
GITEE_API_URL="https://gitee.com/api/v5/user/repos"

GITHUB_USERNAME="YOUR_GITHUB_USERNAME"  # 请替换为您的GitHub用户名
GITHUB_TOKEN="YOUR_GITHUB_TOKEN"        # 请替换为您的GitHub访问令牌
GITHUB_API_URL="https://api.github.com/user/repos"

# 检查参数
if [ $# -lt 2 ]; then
    echo "使用方法: $0 <平台> <项目名称> [描述]"
    echo ""
    echo "支持的平台:"
    echo "  gitee  - 创建Gitee仓库（国内平台，速度快）"
    echo "  github - 创建GitHub仓库（国际平台，生态丰富）"
    echo ""
    echo "示例:"
    echo "  $0 gitee my-project \"我的项目\""
    echo "  $0 github my-project \"My Project\""
    echo ""
    echo "注意: 每次只能选择一个平台创建仓库"
    exit 1
fi

PLATFORM=$1
PROJECT_NAME=$2
DESCRIPTION=${3:-"这是一个新项目"}

# 验证平台参数
if [ "$PLATFORM" != "gitee" ] && [ "$PLATFORM" != "github" ]; then
    echo "❌ 不支持的平台: $PLATFORM"
    echo "支持的平台: gitee, github"
    exit 1
fi

# 检查配置
if [ "$PLATFORM" = "gitee" ]; then
    if [ "$GITEE_USERNAME" = "YOUR_USERNAME" ] || [ "$GITEE_TOKEN" = "YOUR_TOKEN" ]; then
        echo "❌ 请先配置Gitee信息！"
        echo "请编辑此脚本，修改以下内容："
        echo "  GITEE_USERNAME=\"您的Gitee用户名\""
        echo "  GITEE_TOKEN=\"您的Gitee访问令牌\""
        exit 1
    fi
    USERNAME=$GITEE_USERNAME
    TOKEN=$GITEE_TOKEN
    API_URL=$GITEE_API_URL
    REPO_URL="https://gitee.com/$USERNAME/$PROJECT_NAME"
elif [ "$PLATFORM" = "github" ]; then
    if [ "$GITHUB_USERNAME" = "YOUR_GITHUB_USERNAME" ] || [ "$GITHUB_TOKEN" = "YOUR_GITHUB_TOKEN" ]; then
        echo "❌ 请先配置GitHub信息！"
        echo "请编辑此脚本，修改以下内容："
        echo "  GITHUB_USERNAME=\"您的GitHub用户名\""
        echo "  GITHUB_TOKEN=\"您的GitHub访问令牌\""
        exit 1
    fi
    USERNAME=$GITHUB_USERNAME
    TOKEN=$GITHUB_TOKEN
    API_URL=$GITHUB_API_URL
    REPO_URL="https://github.com/$USERNAME/$PROJECT_NAME"
fi

echo "🚀 开始创建项目: $PROJECT_NAME"
echo "📱 选择平台: $PLATFORM"
echo "📍 将在 $PLATFORM 上创建仓库"

# 检查是否在Git仓库中
if [ ! -d ".git" ]; then
    echo "📦 初始化Git仓库..."
    git init
fi

# 创建README.md（如果不存在）
if [ ! -f "README.md" ]; then
    echo "📝 创建README.md文件..."
    cat > README.md << EOF
# $PROJECT_NAME

$DESCRIPTION

## 开始使用

1. 克隆此仓库
2. 开始开发

## 贡献

欢迎提交Issue和Pull Request！
EOF
fi

# 添加文件到Git
echo "📁 添加文件到Git..."
git add .

# 检查是否有变更
if git diff --staged --quiet; then
    echo "ℹ️  没有新的变更需要提交"
else
    echo "💾 提交变更..."
    git commit -m "Initial commit: 添加项目文件"
fi

# 通过API创建仓库
echo "🌐 在$PLATFORM上创建仓库..."
if [ "$PLATFORM" = "gitee" ]; then
    RESPONSE=$(curl -s -X POST "$API_URL" \
      -H "Content-Type: application/json" \
      -d "{
        \"name\": \"$PROJECT_NAME\",
        \"description\": \"$DESCRIPTION\",
        \"private\": false,
        \"has_issues\": true,
        \"has_wiki\": true,
        \"has_pages\": false,
        \"auto_init\": false
      }" \
      -u "$USERNAME:$TOKEN")
elif [ "$PLATFORM" = "github" ]; then
    RESPONSE=$(curl -s -X POST "$API_URL" \
      -H "Content-Type: application/json" \
      -H "Authorization: token $TOKEN" \
      -d "{
        \"name\": \"$PROJECT_NAME\",
        \"description\": \"$DESCRIPTION\",
        \"private\": false,
        \"has_issues\": true,
        \"has_wiki\": true,
        \"has_pages\": false,
        \"auto_init\": false
      }")
fi

# 检查API响应
if echo "$RESPONSE" | grep -q '"id"'; then
    echo "✅ $PLATFORM仓库创建成功!"
    
    # 添加远程仓库
    echo "🔗 添加远程仓库..."
    git remote remove origin 2>/dev/null || true
    
    if [ "$PLATFORM" = "gitee" ]; then
        git remote add origin "https://$USERNAME:$TOKEN@gitee.com/$USERNAME/$PROJECT_NAME.git"
    elif [ "$PLATFORM" = "github" ]; then
        git remote add origin "https://$USERNAME:$TOKEN@github.com/$USERNAME/$PROJECT_NAME.git"
    fi
    
    # 设置主分支
    git branch -M main
    
    # 推送到远程仓库
    echo "⬆️  推送代码到$PLATFORM..."
    git push -u origin main
    
    echo "🎉 项目创建完成!"
    echo "📍 仓库地址: $REPO_URL"
else
    echo "❌ 创建仓库失败:"
    echo "$RESPONSE"
    exit 1
fi
