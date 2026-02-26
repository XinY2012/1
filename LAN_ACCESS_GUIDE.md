# 局域网访问配置说明

## 📡 你的 IP 地址

根据检测，你的电脑有以下 IP 地址：

### 主要网络接口：
- **以太网：** `59.79.2.231` （可能是校园网/公网）
- **WLAN（WiFi）：** `169.254.70.52` （局域网）
- **以太网 2：** `169.254.72.250` （局域网）

---

## 🌐 局域网访问步骤

### **场景1：同一 WiFi 下访问（推荐）**

#### 1. 配置 API 地址

编辑文件：`src/config/apiConfig.js`

```javascript
export const API_CONFIG = {
  LOCAL: 'http://localhost:3003/api',

  // 修改这里的 IP 地址为你的 WLAN IP
  LAN: 'http://169.254.70.52:3003/api',

  // 切换到局域网模式
  CURRENT: 'LAN' // 修改这里：'LOCAL' -> 'LAN'
};
```

#### 2. 确保防火墙允许访问

在 Windows 防火墙中允许端口 3003：

```powershell
# 在管理员权限的 PowerShell 中运行
New-NetFirewallRule -DisplayName "Node.js Backend" -Direction Inbound -LocalPort 3003 -Protocol TCP -Action Allow
```

或者手动添加：
1. 打开"Windows Defender 防火墙"
2. 点击"高级设置"
3. 选择"入站规则"
4. 点击"新建规则"
5. 选择"端口"
6. TCP，特定本地端口：3003
7. 允许连接
8. 全部勾选
9. 名称：Node.js Backend

#### 3. 重启服务

**后端：**
```bash
cd server
npm start
```

**前端：**
```bash
npm run dev
```

#### 4. 其他设备访问

在同一 WiFi 下的其他设备（手机/平板/其他电脑）：

**访问前端：**
```
http://169.254.70.52:3000
```

**访问后端 API：**
```
http://169.254.70.52:3003/api
```

---

### **场景2：不同 WiFi / 远程访问**

如果需要在不同 WiFi 下访问，需要使用内网穿透工具。

#### **方案1：使用 ngrok（推荐，免费）**

1. **下载 ngrok**
   - 访问：https://ngrok.com/
   - 注册账号并下载
   - 解压到任意目录

2. **运行 ngrok**
   ```bash
   ngrok http 3003
   ```

3. **获取公网地址**
   会显示类似：
   ```
   Forwarding  https://abc123.ngrok.io -> http://localhost:3003
   ```

4. **配置 API 地址**
   编辑 `src/config/apiConfig.js`：
   ```javascript
   LAN: 'https://abc123.ngrok.io/api',
   ```

5. **分享给其他人**
   把 `https://abc123.ngrok.io` 分享给任何人，他们可以在任何网络访问。

#### **方案2：使用 Cloudflare Tunnel（免费）**

1. **安装 cloudflared**
   ```bash
   # Windows
   # 下载：https://github.com/cloudflare/cloudflared/releases
   ```

2. **运行 tunnel**
   ```bash
   cloudflared tunnel --url http://localhost:3003
   ```

3. **获取公网地址**
   会显示一个公网地址，类似 ngrok。

---

## 🔧 快速配置指南

### **本地开发（同一台电脑）**

```javascript
// src/config/apiConfig.js
CURRENT: 'LOCAL'
```

访问：`http://localhost:3000`

---

### **局域网访问（同一 WiFi）**

```javascript
// src/config/apiConfig.js
LAN: 'http://169.254.70.52:3003/api',
CURRENT: 'LAN'
```

访问：`http://169.254.70.52:3000`

---

### **公网访问（不同 WiFi）**

使用 ngrok 或 Cloudflare Tunnel：

```javascript
// src/config/apiConfig.js
LAN: 'https://abc123.ngrok.io/api', // 替换为你的 ngrok 地址
CURRENT: 'LAN'
```

访问：`https://abc123.ngrok.io`（前端需要也通过 ngrok）

---

## ⚠️ 常见问题

### **1. 无法访问局域网地址**

**原因：**
- 防火墙阻止
- IP 地址错误
- 不在同一 WiFi

**解决：**
- 检查防火墙设置
- 确认 IP 地址正确
- 确保在同一 WiFi

### **2. ngrok 连接失败**

**原因：**
- ngrok 未登录
- 端口被占用

**解决：**
```bash
ngrok config add-authtoken <你的token>
```

### **3. 前端无法连接后端**

**原因：**
- API 地址配置错误
- 后端未启动
- CORS 问题

**解决：**
- 检查 `src/config/apiConfig.js`
- 确保后端正在运行
- 检查浏览器控制台错误

---

## 📋 检查清单

使用局域网访问前，请确认：

- [ ] 后端服务已启动（端口 3003）
- [ ] 前端服务已启动（端口 3000）
- [ ] 防火墙已允许端口 3003
- [ ] 所有设备在同一 WiFi
- [ ] API 配置已切换到 LAN 模式
- [ ] IP 地址正确（169.254.70.52）

---

## 🎯 推荐方案

### **对于你的项目：**

**如果只是演示：**
✅ 使用 **局域网访问**（同一 WiFi）
- 配置简单
- 速度快
- 无需额外工具

**如果需要远程访问：**
✅ 使用 **ngrok**
- 免费
- 配置简单
- 稳定可靠

---

## 📞 技术支持

如有问题，请检查：
1. 后端服务是否正常运行
2. 前端服务是否正常运行
3. IP 地址是否正确
4. 防火墙是否允许
5. 是否在同一 WiFi

---

**祝你使用愉快！** 🎉
