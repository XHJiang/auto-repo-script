#!/bin/bash

# 设置独立仓库自动化脚本
# 支持 Gitee 和 GitHub（二选一）
# 这个脚本会将create_repo.sh安装到您的系统中

echo "🔧 设置独立仓库自动化工具..."

# 创建bin目录（如果不存在）
mkdir -p ~/bin

# 复制脚本到bin目录
cp create_repo.sh ~/bin/create_repo.sh
chmod +x ~/bin/create_repo.sh

# 检查PATH是否包含~/bin
if [[ ":$PATH:" != *":$HOME/bin:"* ]]; then
    echo "📝 添加~/bin到PATH..."
    echo 'export PATH="$HOME/bin:$PATH"' >> ~/.zshrc
    echo "✅ 已添加到~/.zshrc，请运行 'source ~/.zshrc' 或重新打开终端"
fi

echo "🎉 设置完成!"
echo ""
echo "使用方法:"
echo "  1. 进入您的项目目录"
echo "  2. 运行: create_repo.sh <平台> <项目名称> [描述]"
echo ""
echo "支持的平台:"
echo "  gitee  - 创建Gitee仓库（国内平台，速度快）"
echo "  github - 创建GitHub仓库（国际平台，生态丰富）"
echo ""
echo "示例:"
echo "  cd ~/Desktop/my-project"
echo "  create_repo.sh gitee my-project \"我的项目\""
echo "  create_repo.sh github my-project \"My Project\""
echo ""
echo "⚠️  注意:"
echo "  - 每次只能选择一个平台创建仓库"
echo "  - 请先配置脚本中的用户名和访问令牌"
