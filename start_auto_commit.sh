#!/bin/bash

# 一键启动自动提交脚本
# 提供多种自动提交选项

# 设置颜色输出
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

echo -e "${BLUE}🚀 自动提交启动器${NC}"
echo -e "${YELLOW}请选择自动提交模式：${NC}"
echo ""
echo "1. 文件监控模式（推荐）- 文件变化时立即提交"
echo "2. 定时提交模式 - 每隔指定时间自动提交"
echo "3. 手动模式 - 需要手动调用git commit"
echo ""

read -p "请输入选项 (1-3): " choice

case $choice in
    1)
        echo -e "${GREEN}启动文件监控模式...${NC}"
        ./auto_commit_watcher.sh
        ;;
    2)
        read -p "请输入提交间隔时间（秒，默认60）: " interval
        interval=${interval:-60}
        echo -e "${GREEN}启动定时提交模式（间隔: ${interval}秒）...${NC}"
        ./auto_commit_timer.sh $interval
        ;;
    3)
        echo -e "${YELLOW}手动模式：请使用以下命令提交：${NC}"
        echo -e "${BLUE}git add . && git commit -m '你的提交信息'${NC}"
        echo -e "${BLUE}或者使用: gcp '你的提交信息'${NC}"
        ;;
    *)
        echo -e "${RED}无效选项，退出${NC}"
        exit 1
        ;;
esac
