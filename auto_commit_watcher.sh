#!/bin/bash

# 文件监控自动提交脚本
# 监控文件变化，自动提交并推送

# 设置颜色输出
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# 检查是否在Git仓库中
if [ ! -d ".git" ]; then
    echo -e "${RED}❌ 当前目录不是Git仓库${NC}"
    exit 1
fi

echo -e "${BLUE}🚀 启动文件监控自动提交...${NC}"
echo -e "${YELLOW}💡 按 Ctrl+C 停止监控${NC}"

# 上次提交时间
LAST_COMMIT_TIME=0
COMMIT_INTERVAL=30  # 30秒内只提交一次

# 文件监控函数
monitor_files() {
    # 使用fswatch监控文件变化（macOS）
    if command -v fswatch &> /dev/null; then
        fswatch -o . | while read; do
            current_time=$(date +%s)
            if [ $((current_time - LAST_COMMIT_TIME)) -ge $COMMIT_INTERVAL ]; then
                auto_commit
                LAST_COMMIT_TIME=$current_time
            fi
        done
    else
        # 如果没有fswatch，使用inotifywait（Linux）或简单的轮询
        echo -e "${YELLOW}⚠️  未找到fswatch，使用轮询模式（每30秒检查一次）${NC}"
        while true; do
            sleep 30
            if [ -n "$(git status --porcelain)" ]; then
                auto_commit
            fi
        done
    fi
}

# 自动提交函数
auto_commit() {
    echo -e "${YELLOW}📝 检测到文件变化，准备自动提交...${NC}"
    
    # 检查是否有未提交的更改
    if git diff --quiet && git diff --cached --quiet; then
        return
    fi
    
    # 添加所有更改
    git add .
    
    # 生成提交信息
    TIMESTAMP=$(date '+%Y-%m-%d %H:%M:%S')
    COMMIT_MSG="自动提交: $TIMESTAMP

- 文件自动保存触发
- 时间: $TIMESTAMP
- 用户: $(whoami)"
    
    # 提交
    git commit -m "$COMMIT_MSG"
    
    if [ $? -eq 0 ]; then
        echo -e "${GREEN}✅ 自动提交成功${NC}"
        
        # 推送到远程仓库
        if git remote | grep -q "github"; then
            git push github main 2>/dev/null || git push github master 2>/dev/null
        fi
        
        if git remote | grep -q "origin"; then
            CURRENT_BRANCH=$(git branch --show-current)
            git push origin $CURRENT_BRANCH 2>/dev/null
        fi
        
        echo -e "${GREEN}🎉 自动同步完成！${NC}"
    else
        echo -e "${RED}❌ 自动提交失败${NC}"
    fi
}

# 启动监控
monitor_files
