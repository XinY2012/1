# 酒店管理系统

基于 React + Node.js 的前后端分离酒店管理系统，支持酒店管理、预订、审核等完整功能。

## 技术栈

- 前端：React 18 + Vite
- 后端：Node.js + Express
- 数据存储：内存存储（可扩展为 MongoDB）

## 功能特性

- 用户认证（登录/注册）
- 酒店管理（创建/编辑/查询）
- 管理员审核（通过/拒绝/下线/恢复）
- 附近信息管理（景点/交通/商场）
- 房型管理（价格/面积/容量）
- 响应式设计（支持移动端和网页端）

## 快速开始

### 🚀 最简单的启动方式（推荐）

1. **解压 `jiudian1.zip` 到任意位置**
2. **进入解压后的 `jiudian1` 文件夹**
3. **双击 `start.bat` 文件**
4. **首次运行选择 `[1] 安装所有依赖`**
5. **之后选择 `[3] 同时启动前后端`**
6. **在浏览器打开 `http://localhost:3000`**

### 前置要求

1. 安装 Node.js（推荐 18.x 或 20.x）
   - 下载：https://nodejs.org/
   - 验证：`node --version`

2. 安装 npm（Node.js 安装时会自动安装）
   - 验证：`npm --version`

### 安装依赖

**方法1：使用快速启动脚本（推荐）**

1. 解压 `jiudian1.zip` 到任意位置（桌面、D盘等）
2. 进入解压后的 `jiudian1` 文件夹
3. 双击 `start.bat` 文件
4. 选择 `[1] 安装所有依赖`（首次运行）

**方法2：手动安装**

1. 进入解压后的 `jiudian1` 文件夹
2. 在文件夹中打开终端：
   - Windows：在文件夹空白处按住 Shift + 右键 → 选择"在此处打开 PowerShell 窗口"
   - 或在文件夹地址栏输入 `cmd` 或 `powershell` 并回车
3. 安装前端依赖：
   ```bash
   npm install
   ```
4. 安装后端依赖：
   ```bash
   cd server
   npm install
   cd ..
   ```

### 启动服务

**方式1：使用快速启动脚本（推荐）**

1. 双击 `start.bat` 文件
2. 选择 `[3] 同时启动前后端`

**方式2：手动启动**

打开两个终端窗口：

**终端1（启动后端）：**
1. 进入 `jiudian1/server` 文件夹
2. 运行：
   ```bash
   npm start
   ```

**终端2（启动前端）：**
1. 进入 `jiudian1` 文件夹
2. 运行：
   ```bash
   npm run dev
   ```

### 访问项目

在浏览器中打开：
```
http://localhost:3000
```

## 测试账号

### 商户账号
- 用户名：`merchant`
- 密码：`123456`
- 权限：上传、编辑酒店信息

### 管理员账号
- 用户名：`admin`
- 密码：`123456`
- 权限：审核、发布酒店信息

## 项目结构

```
jiudian1/
├── package.json              # 前端依赖
├── vite.config.js           # Vite 配置
├── index.html              # HTML 模板
├── start.bat               # 快速启动脚本（Windows）
├── README.md               # 项目说明
├── USER_GUIDE.md           # 使用说明
├── TEST_REPORT.md          # 测试报告
├── LAN_ACCESS_GUIDE.md     # 局域网访问指南
├── DEPLOYMENT.md          # 部署指南
├── src/
│   ├── main.jsx           # 入口文件
│   ├── App.jsx           # 主应用组件
│   ├── api.js            # API 接口
│   ├── config/
│   │   ├── amapConfig.js    # 高德地图配置
│   │   └── apiConfig.js    # API 配置
│   ├── mock/             # Mock 数据
│   │   ├── hotelMock.js
│   │   ├── nearbyMock.json
│   │   └── userMock.js
│   ├── pages/            # 页面组件
│   │   ├── Home.jsx
│   │   ├── HotelList.jsx
│   │   ├── HotelDetail.jsx
│   │   ├── HotelAdd.jsx
│   │   ├── Login.jsx
│   │   └── MerchantHotelList.jsx
│   └── utils/            # 工具函数
│       └── nearbyUtil.js
└── server/               # 后端服务
    ├── package.json       # 后端依赖
    ├── server.js         # 服务器入口
    ├── README.md         # 后端文档
    ├── data/            # 数据存储
    │   ├── users.js
    │   └── hotels.js
    ├── routes/          # API 路由
    │   ├── users.js
    │   ├── hotels.js
    │   └── admin.js
    └── utils/           # 工具函数
        └── nearbyHelper.js
```

## API 接口

### 基础信息
- 后端地址：http://localhost:3003
- API 前缀：/api
- 数据格式：JSON

### 用户认证
- `POST /api/user/login` - 用户登录
- `POST /api/admin/register` - 管理员注册
- `POST /api/admin/login` - 管理员登录

### 酒店管理
- `GET /api/user/location` - 获取定位
- `GET /api/user/filter/options` - 获取筛选选项
- `GET /api/user/hotels` - 获取酒店列表
- `GET /api/user/hotels/:id` - 获取酒店详情
- `GET /api/merchant/hotels` - 获取商户酒店
- `GET /api/merchant/hotels/:id` - 获取酒店详情
- `POST /api/merchant/hotels` - 创建酒店
- `PUT /api/merchant/hotels/:id` - 更新酒店
- `PATCH /api/merchant/hotels/:id/submit` - 提交审核

### 管理员审核
- `GET /api/admin/hotels` - 获取所有酒店
- `PATCH /api/admin/hotels/:id/approve` - 审核通过
- `PATCH /api/admin/hotels/:id/reject` - 审核拒绝
- `PATCH /api/admin/hotels/:id/offline` - 下线酒店
- `PATCH /api/admin/hotels/:id/restore` - 恢复酒店

## 酒店状态说明

- `draft` - 草稿状态
- `pending` - 审核中
- `approved` - 已发布
- `rejected` - 未通过
- `offline` - 已下线

## 附近信息类型

- `scenic` - 景点
- `traffic` - 交通
- `mall` - 商场

## 房型优惠类型

- `percent` - 折扣（如：8表示8折）
- `amount` - 立减（如：100表示减100元）

## 📦 给其他人的安装说明

如果你收到了 `jiudian1.zip` 压缩包，按照以下步骤操作：

### 第一步：解压文件
1. 右键点击 `jiudian1.zip`
2. 选择"全部提取"
3. 选择解压位置（桌面、D盘等都可以）
4. 点击"提取"

### 第二步：检查 Node.js
打开终端，输入：
```bash
node --version
```
- 如果显示版本号（如 v18.x 或 v20.x），说明已安装 ✅
- 如果提示错误，请访问 https://nodejs.org/ 下载安装

### 第三步：安装依赖
1. 进入解压后的 `jiudian1` 文件夹
2. 在文件夹中打开终端：
   - Windows：在文件夹空白处按住 Shift + 右键 → 选择"在此处打开 PowerShell 窗口"
   - 或在文件夹地址栏输入 `cmd` 或 `powershell` 并回车
3. 运行以下命令：
   ```bash
   npm install
   cd server
   npm install
   cd ..
   ```

### 第四步：启动项目
**方法1：双击 start.bat（最简单）**
- 直接双击 `start.bat` 文件
- 选择 `[3] 同时启动前后端`

**方法2：手动启动**
- 打开两个终端窗口
- 终端1：进入 `server` 文件夹，运行 `npm start`
- 终端2：在根目录运行 `npm run dev`

### 第五步：访问项目
在浏览器打开：http://localhost:3000

### 测试账号
- **商户账号**：`merchant` / `123456`
- **管理员账号**：`admin` / `123456`

---

## 详细文档

- [使用说明](USER_GUIDE.md) - 详细的功能使用说明
- [测试报告](TEST_REPORT.md) - 完整的测试报告
- [局域网访问](LAN_ACCESS_GUIDE.md) - 局域网和公网访问指南
- [部署指南](DEPLOYMENT.md) - 打包和部署详细指南

## 常见问题

### 1. 端口被占用
**问题：** `EADDRINUSE: address already in use`
**解决：** 修改 `vite.config.js` 或 `server/server.js` 中的端口号

### 2. 依赖安装失败
**问题：** npm install 失败
**解决：** 
```bash
npm cache clean --force
npm install
```

### 3. 无法连接后端
**问题：** 前端无法连接后端
**解决：** 
- 检查后端是否启动
- 检查 `src/config/apiConfig.js` 中的 API 地址

### 4. 数据不显示
**问题：** 列表为空
**解决：** 
- 检查后端数据是否正确
- 检查 API 调用是否成功

## 开发者

- 前端：React + Vite
- 后端：Node.js + Express
- API：RESTful

## 许可证

MIT

## 更新日志

### v1.0.0 (2026-02-26)
- 完成前后端分离架构
- 实现用户认证功能
- 实现酒店管理功能
- 实现管理员审核功能
- 实现附近信息管理
- 实现房型管理
- 完成所有 API 接口
- 添加局域网访问支持
- 添加快速启动脚本

## 贡献

欢迎提交 Issue 和 Pull Request！

## 联系方式

如有问题，请查看详细文档或提交 Issue。

---

**祝你使用愉快！** 🎉
