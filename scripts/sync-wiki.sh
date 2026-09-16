#!/bin/sh
# 将手册正文同步到 GitHub Wiki。
#
# 用法：scripts/sync-wiki.sh [wiki-remote]
#   默认 remote 为 git@github.com:omeyang/Maat.wiki.git
#
# 行为：
#   1. 克隆 Wiki 仓库到临时目录
#   2. 用 README.md 生成 Home.md，用索引表生成 _Sidebar.md
#   3. 复制所有编号章节，把仓库内相对链接改写为 Wiki 页面链接
#   4. 有变更时提交并推送

set -eu

REMOTE=${1:-git@github.com:omeyang/Maat.wiki.git}
REPO_URL=https://github.com/omeyang/Maat
ROOT=$(cd "$(dirname "$0")/.." && pwd)
WORK=$(mktemp -d)
trap 'rm -rf "$WORK"' EXIT

cd "$ROOT"
git clone -q "$REMOTE" "$WORK/wiki"

# 章节列表：根目录下以数字开头的 Markdown 文件
CHAPTERS=$(ls [0-9]*.md)

# 生成 sed 脚本：./NN-xxx.md -> NN-xxx，README -> Home，CONTRIBUTING -> 仓库地址
SED="$WORK/links.sed"
: > "$SED"
for f in $CHAPTERS; do
    page=${f%.md}
    printf 's#](\\./%s#](%s#g\n' "$f" "$page" >> "$SED"
    printf 's#](%s#](%s#g\n' "$f" "$page" >> "$SED"
done
printf 's#](\\./README\\.md)#](Home)#g\n' >> "$SED"
printf 's#](\\./CONTRIBUTING\\.md)#](%s/blob/main/CONTRIBUTING.md)#g\n' "$REPO_URL" >> "$SED"
printf 's#](\\./LICENSE)#](%s/blob/main/LICENSE)#g\n' "$REPO_URL" >> "$SED"

# 清理旧页面，保证删除的章节不会残留
find "$WORK/wiki" -maxdepth 1 -name '*.md' -type f -exec rm -f {} +

for f in $CHAPTERS; do
    sed -f "$SED" "$f" > "$WORK/wiki/$f"
done

sed -f "$SED" README.md > "$WORK/wiki/Home.md"

# 侧边栏：从 README 索引表提取「编号 | [标题](链接)」
{
    printf '**[Maat](Home)**\n\n'
    grep -E '^\| [0-9]+[A-Z]? \| \[' README.md \
        | sed -E 's#^\| ([0-9]+[A-Z]?) \| \[([^]]+)\]\(\./([^)]+)\.md\).*#- \1 [\2](\3)#'
    printf '\n---\n\n- [贡献指南](%s/blob/main/CONTRIBUTING.md)\n- [GitHub 仓库](%s)\n' "$REPO_URL" "$REPO_URL"
} > "$WORK/wiki/_Sidebar.md"

printf '本页由 [Maat](%s) 仓库的 `scripts/sync-wiki.sh` 自动生成，请勿直接编辑。\n' "$REPO_URL" \
    > "$WORK/wiki/_Footer.md"

cd "$WORK/wiki"
git add -A
if git diff --cached --quiet; then
    echo "wiki: 无变更"
    exit 0
fi
SRC=$(cd "$ROOT" && git rev-parse --short HEAD)
git commit -q -m "sync: mirror handbook at $SRC"
git push -q origin HEAD
echo "wiki: 已推送，源 commit $SRC"
