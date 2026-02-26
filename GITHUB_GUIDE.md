# GitHub 提交指南

## 📋 前置要求

### 1. 安装 Git

#### Windows 安装 Git

**方法1：官方网站下载（推荐）**

1. 访问：https://git-scm.com/download/win
2. 下载 Windows 版本（如：Git-2.45.0-64-bit.exe）
3. 运行安装程序
4. 使用默认设置，一路点击"Next"
5. 安装完成后，重启终端

**方法2：使用 winget（Windows 10+）**

```powershell
winget install Git.Git
```

**验证安装：**
```bash
git --version
```

应该显示类似：`git version 2.45.0.windows.1`

---

### 2. 注册 GitHub 账号

1. 访问：https://github.com/
2. 点击右上角"Sign up"
3. 填写注册信息：
   - Username（用户名）
   - Email（邮箱）
   - Password（密码）
4. 完成注册并登录

---

## 🚀 提交步骤

### 步骤1：初始化 Git 仓库

在项目根目录（`jiudian1`）打开终端：

```bash
cd C:\Users\康明楷\Documents\trae_projects\jiudian1
git init
```

看到以下信息表示成功：
```
Initialized empty Git repository in C:/Users/康明楷/Documents/trae_projects/jiudian1/.git/
```

---

### 步骤2：配置 Git 用户信息

```bash
git config user.name "你的名字"
git config user.email "你的邮箱"
```

例如：
```bash
git config user.name "张三"
git config user.email "zhangsan@example.com"
```

---

### 步骤3：添加文件到 Git

```bash
git add .
```

这会添加所有文件到暂存区。

---

### 步骤4：创建初始提交

```bash
git commit -m "Initial commit: 酒店管理系统"
```

看到以下信息表示成功：
```
[main (root-commit) xxxxxxx] Initial commit: 酒店管理系统
 xxx files changed, xxx insertions(+)
```

---

### 步骤5：创建 GitHub 仓库

1. 登录 GitHub：https://github.com/
2. 点击右上角 `+` 号
3. 选择"New repository"
4. 填写仓库信息：
   - Repository name: `jiudian1`（或你喜欢的名字）
   - Description: `酒店管理系统`
   - Public/Private: 选择 Public（公开）或 Private（私有）
5. 点击"Create repository"

---

### 步骤6：连接远程仓库

```bash
# 方式1：使用 HTTPS（推荐）
git remote add origin https://github.com/你的用户名/jiudian1.git

# 方式2：使用 SSH（需要配置 SSH 密钥）
git remote add origin git@github.com:你的用户名/jiudian1.git
```

例如：
```bash
git remote add origin https://github.com/zhangsan/jiudian1.git
```

---

### 步骤7：推送到 GitHub

```bash
git push -u origin main
```

第一次推送时，GitHub 会要求你登录：
- Username: 输入你的 GitHub 用户名
- Password: 输入你的 Personal Access Token（不是登录密码）

**注意：** GitHub 已不再支持密码推送，需要使用 Personal Access Token。

---

## 🔑 创建 Personal Access Token

### 1. 生成 Token

1. 登录 GitHub
2. 点击右上角头像 → "Settings"
3. 左侧菜单选择"Developer settings"
4. 选择"Personal access tokens" → "Tokens (classic)"
5. 点击"Generate new token (classic)"
6. 填写信息：
   - Note: `jiudian1`（或任何描述）
   - Expiration: 选择过期时间（推荐 90 days）
   - Select scopes: 勾选 `repo`（完全控制仓库）
7. 点击"Generate token"
8. **重要：** 复制生成的 token（只显示一次）

### 2. 使用 Token 推送

```bash
git push -u origin main
```

当提示输入密码时，粘贴刚才复制的 token。

---

## 📊 Git 常用命令

### 基础命令
```bash
# 查看状态
git status

# 查看提交历史
git log

# 查看远程仓库
git remote -v
```

### 分支操作
```bash
# 查看分支
git branch

# 创建新分支
git branch feature-xxx

# 切换分支
git checkout feature-xxx

# 合并分支
git merge feature-xxx
```

### 提交和推送
```bash
# 添加所有修改
git add .

# 添加特定文件
git add filename.js

# 提交修改
git commit -m "提交信息"

# 推送到远程
git push

# 拉取远程更新
git pull
```

---

## 🎯 完整示例

### 从零开始到 GitHub

```bash
# 1. 进入项目目录
cd C:\Users\康明楷\Documents\trae_projects\jiudian1

# 2. 初始化 Git
git init

# 3. 配置用户信息
git config user.name "张三"
git config user.email "zhangsan@example.com"

# 4. 添加所有文件
git add .

# 5. 创建初始提交
git commit -m "Initial commit: 酒店管理系统

# 6. 连接远程仓库
git remote add origin https://github.com/zhangsan/jiudian1.git

# 7. 推送到 GitHub
git push -u origin main
```

---

## ⚠️ 常见问题

### 1. Git 命令不存在

**问题：** `git : 无法将"git"项识别为 cmdlet...`
**原因：** Git 未安装或未添加到 PATH
**解决：**
1. 重新安装 Git
2. 重启终端
3. 或使用 Git Bash（Git 安装时附带）

### 2. 推送失败：认证失败

**问题：** `Authentication failed`
**原因：** 用户名或 token 错误
**解决：**
1. 检查 GitHub 用户名是否正确
2. 重新生成 Personal Access Token
3. 确保使用的是 token 而不是密码

### 3. 推送失败：分支错误

**问题：** `error: src refspec master does not match any`
**原因：** 分支名称不匹配
**解决：**
```bash
# 查看当前分支
git branch

# 如果是 master，使用：
git push -u origin master

# 如果是 main，使用：
git push -u origin main
```

### 4. 文件太大

**问题：** `error: RPC failed; HTTP 413 curl 22 The requested URL returned error: 413`
**原因：** 单个文件超过 100MB
**解决：**
1. 添加到 `.gitignore`：
   ```
   node_modules/
   dist/
   *.zip
   ```
2. 清除 Git 缓存：
   ```bash
   git rm -r --cached .
   git add .
   git commit -m "Update .gitignore"
   ```

### 5. 推送超时

**问题：** `fatal: unable to access 'https://github.com/...'`
**原因：** 网络问题
**解决：**
1. 检查网络连接
2. 使用 VPN（如果在国内）
3. 或使用 Gitee（国内更快）

---

## 🌐 使用 Gitee（国内推荐）

如果 GitHub 访问慢，可以使用 Gitee（码云）：

### 1. 注册 Gitee

1. 访问：https://gitee.com/
2. 点击右上角"注册"
3. 填写注册信息
4. 完成注册并登录

### 2. 创建仓库

1. 点击右上角 `+` 号
2. 选择"新建仓库"
3. 填写仓库信息：
   - 仓库名称：`jiudian1`
   - 仓库介绍：`酒店管理系统`
   - 是否公开：选择公开
4. 点击"创建"

### 3. 推送到 Gitee

```bash
# 连接远程仓库
git remote add origin https://gitee.com/你的用户名/jiudian1.git

# 推送到 Gitee
git push -u origin master
```

---

## 📋 提交信息规范

### 好的提交信息
```
feat: 添加用户登录功能
fix: 修复酒店列表显示问题
docs: 更新 README 文档
style: 优化登录页面样式
refactor: 重构 API 接口
test: 添加单元测试
chore: 更新依赖包
```

### 提交信息格式
```
<type>(<scope>): <subject>

<body>

<footer>
```

**type 类型：**
- `feat`: 新功能
- `fix`: 修复 bug
- `docs`: 文档更新
- `style`: 代码格式调整
- `refactor`: 重构
- `test`: 测试
- `chore`: 构建/工具变动

---

## 🎯 推荐工作流程

### 1. 开发新功能
```bash
# 创建新分支
git branch feature/add-payment

# 切换到新分支
git checkout feature/add-payment

# 开发功能...
# 修改代码...

# 提交修改
git add .
git commit -m "feat: 添加支付功能"

# 推送到远程
git push -u origin feature/add-payment
```

### 2. 修复 bug
```bash
# 修复 bug...
# 修改代码...

# 提交修改
git add .
git commit -m "fix: 修复登录失败问题"

# 推送到远程
git push
```

### 3. 合并到主分支
```bash
# 切换到主分支
git checkout main

# 合并功能分支
git merge feature/add-payment

# 推送到远程
git push
```

---

## 📞 技术支持

如有问题，请检查：
1. Git 是否正确安装
2. GitHub 账号是否登录
3. Personal Access Token 是否正确
4. 网络连接是否正常
5. 分支名称是否正确

---

**祝你提交顺利！** 🎉
