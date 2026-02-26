# 项目打包和部署指南

## 📦 打包步骤

### 方案1：直接分享源码（推荐）

#### 1. 准备项目文件

确保以下文件和目录完整：

```
jiudian1/
├── package.json              # 前端依赖
├── package-lock.json
├── vite.config.js
├── index.html
├── .gitignore
├── README.md
├── USER_GUIDE.md
├── TEST_REPORT.md
├── LAN_ACCESS_GUIDE.md
├── DEPLOYMENT.md            # 本文件
├── src/
│   ├── main.jsx
│   ├── App.jsx
│   ├── api.js
│   ├── config/
│   │   ├── amapConfig.js
│   │   └── apiConfig.js
│   ├── mock/
│   │   ├── hotelMock.js
│   │   ├── nearbyMock.json
│   │   └── userMock.js
│   ├── pages/
│   │   ├── Home.jsx
│   │   ├── HotelList.jsx
│   │   ├── HotelDetail.jsx
│   │   ├── HotelAdd.jsx
│   │   ├── Login.jsx
│   │   └── MerchantHotelList.jsx
│   └── utils/
│       └── nearbyUtil.js
└── server/
    ├── package.json          # 后端依赖
    ├── package-lock.json
    ├── server.js
    ├── README.md
    ├── data/
    │   ├── users.js
    │   └── hotels.js
    ├── routes/
    │   ├── users.js
    │   ├── hotels.js
    │   └── admin.js
    └── utils/
        └── nearbyHelper.js
```

#### 2. 创建压缩包

**Windows:**
```powershell
# 在项目根目录执行
Compress-Archive -Path . -DestinationPath jiudian1.zip -Force
```

**或使用文件管理器：**
1. 选中所有文件和文件夹
2. 右键 → 发送到 → 压缩(zipped)文件夹
3. 重命名为 `jiudian1.zip`

#### 3. 分享给其他人

将 `jiudian1.zip` 发送给其他人。

---

### 方案2：使用 Git（推荐给开发者）

#### 1. 初始化 Git 仓库

```bash
git init
git add .
git commit -m "Initial commit: 酒店管理系统"
```

#### 2. 推送到 GitHub/Gitee

```bash
# GitHub
git remote add origin https://github.com/你的用户名/jiudian1.git
git push -u origin main

# Gitee（国内更快）
git remote add origin https://gitee.com/你的用户名/jiudian1.git
git push -u origin master
```

#### 3. 其他人克隆项目

```bash
git clone https://github.com/你的用户名/jiudian1.git
cd jiudian1
```

---

## 🚀 其他人如何运行项目

### 前置要求

1. **安装 Node.js**
   - 下载：https://nodejs.org/
   - 推荐版本：18.x 或 20.x
   - 安装后验证：`node --version`

2. **安装 npm**
   - Node.js 安装时会自动安装 npm
   - 验证：`npm --version`

---

### 运行步骤

#### 1. 解压项目

```bash
# 解压到任意目录
unzip jiudian1.zip
cd jiudian1
```

#### 2. 安装前端依赖

```bash
npm install
```

#### 3. 安装后端依赖

```bash
cd server
npm install
cd ..
```

#### 4. 启动后端服务

**打开终端1：**
```bash
cd server
npm start
```

看到以下信息表示成功：
```
后端服务运行在 http://0.0.0.0:3003
局域网访问地址：http://<你的电脑IP>:3003
```

#### 5. 启动前端服务

**打开终端2：**
```bash
npm run dev
```

看到以下信息表示成功：
```
VITE v5.0.0  ready in xxx ms

➜  Local:   http://localhost:3000/
➜  Network: http://192.168.x.x:3000/
```

#### 6. 访问项目

在浏览器中打开：
```
http://localhost:3000
```

---

## 📋 快速启动脚本（可选）

### Windows 批处理脚本

创建文件 `start.bat`：

```batch
@echo off
echo ========================================
echo 酒店管理系统 - 快速启动
echo ========================================

echo.
echo [1] 启动后端服务
echo [2] 启动前端服务
echo [3] 同时启动前后端
echo [4] 退出
echo.

set /p choice=请选择操作 (1-4):

if "%choice%"=="1" goto start_backend
if "%choice%"=="2" goto start_frontend
if "%choice%"=="3" goto start_all
if "%choice%"=="4" goto end

:start_backend
echo.
echo 正在启动后端服务...
cd server
start cmd /k "npm start"
cd ..
echo 后端服务已启动！
goto end

:start_frontend
echo.
echo 正在启动前端服务...
start cmd /k "npm run dev"
echo 前端服务已启动！
goto end

:start_all
echo.
echo 正在同时启动前后端服务...
cd server
start cmd /k "npm start"
cd ..
timeout /t 2 >nul
start cmd /k "npm run dev"
echo 前后端服务已启动！
goto end

:end
pause
```

### PowerShell 脚本

创建文件 `start.ps1`：

```powershell
Write-Host "========================================" -ForegroundColor Cyan
Write-Host "酒店管理系统 - 快速启动" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

Write-Host "[1] 启动后端服务" -ForegroundColor Yellow
Write-Host "[2] 启动前端服务" -ForegroundColor Yellow
Write-Host "[3] 同时启动前后端" -ForegroundColor Yellow
Write-Host "[4] 退出" -ForegroundColor Yellow
Write-Host ""

$choice = Read-Host "请选择操作 (1-4)"

switch ($choice) {
    "1" {
        Write-Host ""
        Write-Host "正在启动后端服务..." -ForegroundColor Green
        cd server
        Start-Process cmd -ArgumentList "/k npm start"
        cd ..
        Write-Host "后端服务已启动！" -ForegroundColor Green
    }
    "2" {
        Write-Host ""
        Write-Host "正在启动前端服务..." -ForegroundColor Green
        Start-Process cmd -ArgumentList "/k npm run dev"
        Write-Host "前端服务已启动！" -ForegroundColor Green
    }
    "3" {
        Write-Host ""
        Write-Host "正在同时启动前后端服务..." -ForegroundColor Green
        cd server
        Start-Process cmd -ArgumentList "/k npm start"
        cd ..
        Start-Sleep -Seconds 2
        Start-Process cmd -ArgumentList "/k npm run dev"
        Write-Host "前后端服务已启动！" -ForegroundColor Green
    }
    "4" {
        exit
    }
    default {
        Write-Host "无效的选择！" -ForegroundColor Red
    }
}

Read-Host "按回车键退出"
```

---

## 📝 创建 README 文件

创建文件 `README.md`（如果还没有）：

```markdown
# 酒店管理系统

基于 React + Node.js 的酒店管理系统，支持酒店管理、预订、审核等功能。

## 技术栈

- 前端：React 18 + Vite
- 后端：Node.js + Express
- 数据存储：内存存储（可扩展为 MongoDB）

## 快速开始

### 1. 安装依赖

```bash
# 安装前端依赖
npm install

# 安装后端依赖
cd server
npm install
cd ..
```

### 2. 启动服务

**启动后端：**
```bash
cd server
npm start
```

**启动前端：**
```bash
npm run dev
```

### 3. 访问项目

在浏览器中打开：http://localhost:3000

## 测试账号

- 商户：merchant / 123456
- 管理员：admin / 123456

## 功能特性

- 用户认证（登录/注册）
- 酒店管理（创建/编辑/查询）
- 管理员审核（通过/拒绝/下线/恢复）
- 附近信息管理
- 房型管理
- 响应式设计（支持移动端）

## 详细文档

- [使用说明](USER_GUIDE.md)
- [测试报告](TEST_REPORT.md)
- [局域网访问](LAN_ACCESS_GUIDE.md)
- [部署指南](DEPLOYMENT.md)

## 开发者

- 前端：React + Vite
- 后端：Node.js + Express
- API：RESTful

## 许可证

MIT
```

---

## 🌐 在线部署（可选）

### 部署到 Vercel（前端）

1. **安装 Vercel CLI**
   ```bash
   npm install -g vercel
   ```

2. **部署前端**
   ```bash
   vercel
   ```

3. **获取部署地址**
   Vercel 会提供一个公网地址

### 部署到 Render（后端）

1. **创建 Render 账号**
   - 访问：https://render.com/
   - 注册账号

2. **创建 Web Service**
   - 选择 "Web Service"
   - 连接 GitHub 仓库
   - 配置：
     - Root Directory: `server`
     - Build Command: `npm install`
     - Start Command: `npm start`

3. **获取部署地址**
   Render 会提供一个公网地址

---

## 📦 分享方式总结

| 方式 | 适用场景 | 难度 |
|------|---------|------|
| 压缩包分享 | 快速分享给非开发者 | ⭐ 简单 |
| Git 仓库 | 分享给开发者 | ⭐⭐ 中等 |
| 在线部署 | 公网访问 | ⭐⭐⭐ 复杂 |

---

## ⚠️ 注意事项

### 1. 依赖安装
- 确保已安装 Node.js（推荐 18.x 或 20.x）
- 安装时可能需要管理员权限
- 如果安装失败，尝试清除缓存：
  ```bash
  npm cache clean --force
  ```

### 2. 端口占用
- 如果端口 3000 被占用，修改 `vite.config.js`
- 如果端口 3003 被占用，修改 `server/server.js`

### 3. 网络问题
- 确保防火墙允许端口 3000 和 3003
- 局域网访问需要配置防火墙

### 4. 数据持久化
- 当前使用内存存储，重启后数据会重置
- 生产环境建议使用 MongoDB 或 MySQL

---

## 🎯 推荐方案

### **对于非开发者：**
✅ 使用 **压缩包分享**
- 简单直接
- 无需 Git
- 适合快速演示

### **对于开发者：**
✅ 使用 **Git 仓库**
- 版本管理
- 易于协作
- 适合持续开发

### **对于公网访问：**
✅ 使用 **在线部署**
- Vercel（前端）
- Render（后端）
- 适合生产环境

---

## 📞 技术支持

如有问题，请检查：
1. Node.js 版本是否正确
2. 依赖是否安装成功
3. 端口是否被占用
4. 防火墙是否允许
5. 查看终端错误信息

---

**祝你部署顺利！** 🎉
