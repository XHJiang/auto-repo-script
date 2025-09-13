#!/bin/bash

# 自动同步脚本 - 每次修改后自动提交并推送到GitHub
# 使用方法：在Cursor中配置自动执行此脚本

# 设置颜色输出
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# 获取当前时间戳
TIMESTAMP=$(date '+%Y-%m-%d %H:%M:%S')

echo -e "${YELLOW}开始自动同步...${NC}"

# 检查是否有未提交的更改
if git diff --quiet && git diff --cached --quiet; then
    echo -e "${YELLOW}没有检测到更改，跳过同步${NC}"
    exit 0
fi

# 添加所有更改
echo -e "${YELLOW}添加更改到暂存区...${NC}"
git add .

# 检查是否有暂存的更改
if git diff --cached --quiet; then
    echo -e "${YELLOW}没有暂存的更改，跳过提交${NC}"
    exit 0
fi

# 提交更改
echo -e "${YELLOW}提交更改...${NC}"
git commit -m "自动同步: $TIMESTAMP

- 由Cursor自动提交
- 时间: $TIMESTAMP
- 用户: $(whoami)
- 主机: $(hostname)"

if [ $? -eq 0 ]; then
    echo -e "${GREEN}✅ 本地提交成功${NC}"
    
    # 推送到GitHub
    echo -e "${YELLOW}推送到GitHub...${NC}"
    git push github main
    
    if [ $? -eq 0 ]; then
        echo -e "${GREEN}✅ GitHub推送成功${NC}"
    else
        echo -e "${RED}❌ GitHub推送失败${NC}"
        exit 1
    fi
    
    # 推送到Gitee（可选）
    echo -e "${YELLOW}推送到Gitee...${NC}"
    git push origin main
    
    if [ $? -eq 0 ]; then
        echo -e "${GREEN}✅ Gitee推送成功${NC}"
    else
        echo -e "${YELLOW}⚠️  Gitee推送失败，但GitHub已成功${NC}"
    fi
    
    echo -e "${GREEN}🎉 自动同步完成！${NC}"
else
    echo -e "${RED}❌ 提交失败${NC}"
    exit 1
fi
