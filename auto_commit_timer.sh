#!/bin/bash

# 定时自动提交脚本
# 每隔指定时间自动检查并提交更改

# 设置颜色输出
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# 默认间隔时间（秒）
INTERVAL=${1:-60}

# 检查是否在Git仓库中
if [ ! -d ".git" ]; then
    echo -e "${RED}❌ 当前目录不是Git仓库${NC}"
    exit 1
fi

echo -e "${BLUE}🚀 启动定时自动提交（间隔: ${INTERVAL}秒）...${NC}"
echo -e "${YELLOW}💡 按 Ctrl+C 停止监控${NC}"

# 自动提交函数
auto_commit() {
    # 检查是否有未提交的更改
    if git diff --quiet && git diff --cached --quiet; then
        return
    fi
    
    echo -e "${YELLOW}📝 检测到更改，准备自动提交...${NC}"
    
    # 添加所有更改
    git add .
    
    # 生成提交信息
    TIMESTAMP=$(date '+%Y-%m-%d %H:%M:%S')
    COMMIT_MSG="定时自动提交: $TIMESTAMP

- 定时器触发
- 时间: $TIMESTAMP
- 用户: $(whoami)"
    
    # 提交
    git commit -m "$COMMIT_MSG"
    
    if [ $? -eq 0 ]; then
        echo -e "${GREEN}✅ 自动提交成功${NC}"
        
        # 推送到远程仓库
        if git remote | grep -q "github"; then
            git push github main 2>/dev/null || git push github master 2>/dev/null
            echo -e "${GREEN}📤 已推送到GitHub${NC}"
        fi
        
        if git remote | grep -q "origin"; then
            CURRENT_BRANCH=$(git branch --show-current)
            git push origin $CURRENT_BRANCH 2>/dev/null
            echo -e "${GREEN}📤 已推送到origin${NC}"
        fi
        
        echo -e "${GREEN}🎉 自动同步完成！${NC}"
    else
        echo -e "${RED}❌ 自动提交失败${NC}"
    fi
}

# 主循环
while true; do
    auto_commit
    sleep $INTERVAL
done
