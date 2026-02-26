数据结构
用户角色
User {
  id: string
  username: string
  password: string
  phone: srting // 手机号，注册/登录唯一标识
  role: "merchant" | "admin"
  createdAt: string
}不确定的内容
1. 文档似乎没有提到用户账户注册，暂时没有包含用户角色
2. 加了一个手机号登录，要不要加用户头像？
酒店信息
数据结构
修改部分：补全定位信息、价格关联、操作日志基础字段，完善审核状态逻辑，细化nearby /  facilities / tags 字段
Hotel {
  id: string

//基础信息
  nameCN: string
  nameEN: string
  city: string
  address: string
  star: number
  openDate: string
 // 补全定位信息（贴合大作业「当前地点支持定位」要求）
  location:{
    lng: number; // 经度
    lat: number; // 纬度
   } 
//附加信息
  //展示图路径
  images: string[]
  //各种酒店属性 如亲子,豪华,免费停车场等
  tags: string[]
  //附近
  nearby:{ // 对齐大作业「可选维度-附近景点/交通/商场」
    id: string;
    type: "scenic" | "traffic" | "mall"; // 类型：景点/交通/商场
    name: string[]; // 名称（如东方明珠/浦东机场/国金中心）
    distance: string; // 距离（如500米/1公里）
  }[];
  //设施
  facilities: string[]
  

//房型
  rooms: Room[]

// 审核状态
// 修改未提交/审核中/通过/未通过/下线
  status: "draft" | "pending" | "approved" | "rejected" | "offline"
  rejectReason?: string

// 修改信息
  merchantId: string
  createdAt: string
  updatedAt: string
  submitAt?: string //提交审核时间（status=pending时必填）
}审核流程
	任意状态		  
            ↓（商户修改）
	draft草稿
	    ↓ (商户提交)
	pending审核中
	    |
  ----------------------		  
  ↓ (管理员通过)         ↓ (管理员拒绝)
approved            rejected
  ↓ (管理员下线)         ↓ (商户可修改后重新提交)
offline               
  ↓ (管理员恢复)
approved不确定的内容
1. 审核动作的对象，是所有信息还是可以选取其中一部分进行驳回，目前暂定为前者
2. 是否需要信息修改历史记录（目前没有写，需要的话需要的调整多一点）
3. 商户账号与酒店之间的对应关系，1对1、1对多、多对多等
4. 地址字段目前只是字符串，不知道定位信息是什么样、要不要加
5. nearby字段可能需要进一步细化数据结构
房型
修改：添加房型基础信息床型、房型面积、可入住人数、库存数量、优惠计算规则。新增休会时间范围（支持大作业「节日优惠」场景），新增currentPrice自动计算字段。
Room {
  id: string
  name: string
  bedType: string; // 床型（如1.8m大床/1.2m双床)
  area: number; // 房型面积
  capacity: number; // 入住人数
  //原价
  basePrice: number
  currentPrice: number; //优惠后当前价格
  //优惠
  discount?: {
    type: "percent" | "minus"
    value: number
    startTime?: string; // 优惠开始时间
    endTime?: string; // 优惠结束时间
  }
  stock: number; // 剩余房间数
  isBookable: boolean; // 是否可定
  roomImages: string[]; // 房型展示图
}不确定的内容
1. 是否设置房型剩余数量
2. 优惠信息可能需要结合其他的数据结构一同计算（比如房型专属优惠、酒店整体优惠、系统优惠等），暂时放在room里，设了两个计算方式，可能要分局部乘算、最后加算、最后乘算之类的 
需要的接口（非常不确定，只是做个样子）
添加酒店查询页：
// 获取当前定位城市
  GET    /api/user/location
// 返回： { city:string, lng: number, lat: number}
获取酒店筛选标签（tags/facilities/star）
 GET    /api/user/filter/options
// 返回：{ star: number[], tags: string[], facilities: string[] }1. 酒店列表页
// 获取酒店列表（支持筛选/分页/排序/定位）
GET    /api/user/hotels
// 请求参数（URL Query）：
// city: string - 城市（必传）
// keyword?: string - 关键词（酒店名/地址）
// star?: number - 星级筛选
// tags?: string[] - 标签筛选
// minPrice?: number - 最低价格
// maxPrice?: number - 最高价格
// sort: "price-asc" | "price-desc" | "distance" - 排序（价格升/降/距离）
// page: number - 页码（默认1，配合上滑自动加载）
// size: number - 每页条数（默认10）
// lng/lat?: number - 定位经纬度（距离排序时必传）
// 返回：{ list: Hotel[], total: number, currentPage: number }2. 酒店详情页 
// 获取酒店详情（含房型列表，房型按currentPrice升序返回）
GET    /api/user/hotels/:id
// 返回：Hotel（rooms字段已按currentPrice升序排序，isBookable=true优先）3. 用户
// 酒店列表页（仅返回approved，透传nearby简版数据）
GET    /api/user/hotels?city=上海&keyword=陆家嘴
// 酒店详情页（返回完整nearby数据）
GET    /api/user/hotels/:id4. 管理端登录页
// 注册（可选择角色，手机号唯一）
POST   /api/admin/register
// 请求体：{ username: string, password: string, phone: string, role: "merchant" | "admin" }
// 返回：{ id: string, username: string, role: string, token: string }

// 登录（自动判断角色，返回token）
POST   /api/admin/login
// 请求体：{ phone: string, password: string }
// 返回：{ id: string, username: string, role: string, token: string }5. 商户录入页
// 获取自身酒店列表（透传nearby）
GET    /api/merchant/hotels
// 获取单个酒店（返回完整nearby）
GET    /api/merchant/hotels/:id
// 创建酒店（自动匹配/提交nearby）
POST   /api/merchant/hotels
// 编辑酒店（支持更新nearby）
PUT    /api/merchant/hotels/:id
// 提交审核（透传nearby）
PATCH  /api/merchant/hotels/:id/submit6. 管理员审核页-酒店审核 / 通过 / 拒绝 / 下线 / 恢复
// 获取所有酒店（透传nearby）
GET    /api/admin/hotels?status=pending
// 审核通过/拒绝/下线/恢复（均透传nearby）
PATCH  /api/admin/hotels/:id/approve
PATCH  /api/admin/hotels/:id/reject
PATCH  /api/admin/hotels/:id/offline
PATCH  /api/admin/hotels/:id/restore前段Mock 数据源：创建src/mock/nearbyMock.json
{
  "上海": {
    "scenic": [
      { "id": "sh_s1", "name": "东方明珠", "distance": "1.2公里" },
      { "id": "sh_s2", "name": "上海外滩", "distance": "2.5公里" },
      { "id": "sh_s3", "name": "陆家嘴中心绿地", "distance": "800米" },
      { "id": "sh_s4", "name": "豫园", "distance": "3公里" }
    ],
    "traffic": [
      { "id": "sh_t1", "name": "陆家嘴地铁站", "distance": "500米" },
      { "id": "sh_t2", "name": "上海浦东国际机场", "distance": "30公里" },
      { "id": "sh_t3", "name": "南京东路地铁站", "distance": "2公里" }
    ],
    "mall": [
      { "id": "sh_m1", "name": "上海国金中心", "distance": "600米" },
      { "id": "sh_m2", "name": "万达广场（浦东店）", "distance": "3.8公里" },
      { "id": "sh_m3", "name": "环球港", "distance": "8公里" }
    ]
  },
  "北京": {
    "scenic": [
      { "id": "bj_s1", "name": "天安门广场", "distance": "1.8公里" },
      { "id": "bj_s2", "name": "故宫博物院", "distance": "2.2公里" },
      { "id": "bj_s3", "name": "颐和园", "distance": "10公里" }
    ],
    "traffic": [
      { "id": "bj_t1", "name": "天安门地铁站", "distance": "600米" },
      { "id": "bj_t2", "name": "北京首都机场", "distance": "28公里" },
      { "id": "bj_t3", "name": "北京站", "distance": "3公里" }
    ],
    "mall": [
      { "id": "bj_m1", "name": "王府井百货", "distance": "1公里" },
      { "id": "bj_m2", "name": "西单大悦城", "distance": "3.5公里" }
    ]
  },
  "广州": {
    "scenic": [
      { "id": "gz_s1", "name": "广州塔", "distance": "1公里" },
      { "id": "gz_s2", "name": "长隆野生动物世界", "distance": "15公里" }
    ],
    "traffic": [
      { "id": "gz_t1", "name": "广州塔地铁站", "distance": "300米" },
      { "id": "gz_t2", "name": "广州白云机场", "distance": "25公里" }
    ],
    "mall": [
      { "id": "gz_m1", "name": "正佳广场", "distance": "8公里" },
      { "id": "gz_m2", "name": "天河城", "distance": "7.5公里" }
    ]
  }
  // 可扩展：深圳、杭州、成都等热门城市，各城市3-5条即可
}前端工具函数（商户端关联 nearby）：创建src/utils/nearbyUtil.js
// 引入nearby模拟数据源
import nearbyMock from '../mock/nearbyMock.json';

/**
 * 按城市获取nearby数据
 * @param {string} city - 酒店所在城市（如上海/北京）
 * @param {boolean} isRandom - 是否随机获取（默认true，避免所有酒店nearby一致）
 * @param {number} count - 随机获取的数量（默认3）
 * @returns {array} 结构化的nearby数组
 */
export const getNearbyByCity = (city, isRandom = true, count = 3) => {
  // 无对应城市数据，返回空数组
  if (!nearbyMock[city]) return [];
  // 合并所有类型的nearby数据，补充type字段
  let allNearby = [];
  Object.keys(nearbyMock[city]).forEach(type => {
    nearbyMock[city][type].forEach(item => {
      allNearby.push({ ...item, type });
    });
  });
  // 随机获取指定数量
  if (isRandom) {
    return allNearby.sort(() => 0.5 - Math.random()).slice(0, count);
  }
  // 全量返回
  return allNearby;
};

/**
 * 按类型筛选nearby数据
 * @param {array} nearbyList - 酒店的nearby数组
 * @param {string} type - 筛选类型（scenic/traffic/mall）
 * @returns {array} 筛选后的数组
 */
export const filterNearbyByType = (nearbyList, type) => {
  if (!nearbyList || !type) return [];
  return nearbyList.filter(item => item.type === type);
};Node.js
// 引入后端nearby模拟数据
const nearbyData = require('../mock/nearbyData.json');

// 按城市获取随机nearby数据（与前端工具函数逻辑一致）
exports.getNearbyByCity = (city, count = 3) => {
  if (!nearbyData[city]) return [];
  let allNearby = [];
  Object.keys(nearbyData[city]).forEach(type => {
    nearbyData[city][type].forEach(item => {
      allNearby.push({ ...item, type });
    });
  });
  return allNearby.sort(() => 0.5 - Math.random()).slice(0, count);
};后端接口：基于 Express 框架改造商户端创建 / 编辑酒店接口，自动为酒店匹配 nearby 数据，同时接收商户端手动勾选的 nearby 数据。
const express = require('express');
const router = express.Router();
const { getNearbyByCity } = require('../utils/nearbyHelper');
// 模拟数据库（实际开发可使用MongoDB/MySQL）
let hotelDB = [];
let hotelId = 1;

// 1. 商户创建酒店（自动匹配nearby）
router.post('/api/merchant/hotels', (req, res) => {
  const { city, nameCN, nameEN, star, openDate, address, merchantId } = req.body;
  // 自动按城市匹配3条nearby数据
  const nearby = getNearbyByCity(city, 3);
  // 构造酒店数据
  const newHotel = {
    id: `hotel_${hotelId++}`,
    nameCN,
    nameEN,
    city,
    address,
    star,
    openDate,
    location: { lng: 0, lat: 0 }, // 模拟定位，前端可手动修改
    images: [],
    tags: req.body.tags || [],
    nearby, // 融入nearby数据
    facilities: req.body.facilities || [],
    rooms: req.body.rooms || [],
    status: "draft", // 默认草稿状态
    merchantId,
    createdAt: new Date().toISOString(),
    updatedAt: new Date().toISOString()
  };
  hotelDB.push(newHotel);
  res.json({
    success: true,
    hotel: newHotel
  });
});

// 2. 商户编辑酒店（支持手动更新nearby）
router.put('/api/merchant/hotels/:id', (req, res) => {
  const { id } = req.params;
  const updateData = req.body;
  const hotelIndex = hotelDB.findIndex(item => item.id === id);
  if (hotelIndex === -1) {
    return res.json({ success: false, msg: "酒店不存在" });
  }
  // 若商户手动修改了nearby，则使用新数据；否则保留原有数据
  const updatedHotel = {
    ...hotelDB[hotelIndex],
    ...updateData,
    updatedAt: new Date().toISOString()
  };
  hotelDB[hotelIndex] = updatedHotel;
  res.json({
    success: true,
    hotel: updatedHotel
  });
});

// 3. 其他接口（查询/提交审核/管理员审核）无核心修改，仅需透传nearby字段
// ...（省略原有查询/审核接口代码，只需保证返回数据包含nearby即可）

module.exports = router;商户端前端录入页（nearby 交互实现）：基于React实现核心交互，选择城市后自动拉取 nearby 数据，支持一键选择和手动勾选
import React, { useState, useEffect } from 'react';
import { getNearbyByCity } from '../utils/nearbyUtil';

const HotelAdd = () => {
  // 酒店基础信息状态
  const [formData, setFormData] = useState({
    city: "",
    nameCN: "",
    nameEN: "",
    star: 1,
    openDate: "",
    address: "",
    tags: [],
    facilities: []
  });
  // nearby相关状态
  const [nearbyList, setNearbyList] = useState([]); // 城市对应的所有nearby
  const [selectedNearby, setSelectedNearby] = useState([]); // 商户勾选的nearby

  // 监听城市变化，自动拉取对应nearby数据
  useEffect(() => {
    if (formData.city) {
      // 全量获取城市的nearby数据，供商户勾选
      const data = getNearbyByCity(formData.city, false);
      setNearbyList(data);
      // 默认勾选前3条（一键选择功能）
      setSelectedNearby(data.slice(0, 3));
    } else {
      setNearbyList([]);
      setSelectedNearby([]);
    }
  }, [formData.city]);

  // 勾选/取消nearby
  const handleNearbyCheck = (item) => {
    if (selectedNearby.some(ele => ele.id === item.id)) {
      // 取消勾选
      setSelectedNearby(selectedNearby.filter(ele => ele.id !== item.id));
    } else {
      // 勾选
      setSelectedNearby([...selectedNearby, item]);
    }
  };

  // 提交创建酒店
  const handleSubmit = async () => {
    try {
      const res = await fetch('/api/merchant/hotels', {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({
          ...formData,
          nearby: selectedNearby, // 提交勾选的nearby数据
          merchantId: localStorage.getItem('userId') // 从本地存储获取商户ID
        })
      });
      const data = await res.json();
      if (data.success) {
        alert("酒店创建成功（草稿状态）");
        // 跳转到酒店列表页
        window.location.href = '/merchant/hotels';
      }
    } catch (err) {
      console.error("创建失败：", err);
    }
  };

  // 渲染：按类型分组展示nearby勾选框
  const renderNearbyByType = (type, label) => {
    const list = nearbyList.filter(item => item.type === type);
    if (list.length === 0) return null;
    return (
      <div className="nearby-type">
        <h4>{label}</h4>
        {list.map(item => (
          <label key={item.id}>
            <input
              type="checkbox"
              checked={selectedNearby.some(ele => ele.id === item.id)}
              onChange={() => handleNearbyCheck(item)}
            />
            {item.name} ({item.distance})
          </label>
        ))}
      </div>
    );
  };

  return (
    <div className="hotel-add">
      <h2>酒店信息录入</h2>
      {/* 基础信息表单 */}
      <select
        value={formData.city}
        onChange={(e) => setFormData({...formData, city: e.target.value})}
        placeholder="选择城市"
      >
        <option value="">请选择城市</option>
        <option value="上海">上海</option>
        <option value="北京">北京</option>
        <option value="广州">广州</option>
      </select>
      <input
        type="text"
        placeholder="酒店中文名"
        value={formData.nameCN}
        onChange={(e) => setFormData({...formData, nameCN: e.target.value})}
      />
      {/* 省略其他基础信息输入框（星级/开业时间/地址等） */}

      {/* Nearby选择区域（核心） */}
      <div className="nearby-select">
        <h3>附近信息选择</h3>
        {renderNearbyByType('scenic', '热门景点')}
        {renderNearbyByType('traffic', '交通设施')}
        {renderNearbyByType('mall', '商场购物')}
      </div>

      <button onClick={handleSubmit}>保存为草稿</button>
    </div>
  );
};

export default HotelAdd;用户端详情页（nearby 展示实现）
import React, { useState, useEffect } from 'react';
import { filterNearbyByType } from '../utils/nearbyUtil';
import { Icon } from 'antd-mobile'; // 开源UI组件库，大作业允许使用

const HotelDetail = ({ match }) => {
  const [hotel, setHotel] = useState(null);
  const hotelId = match.params.id;

  // 获取酒店详情
  useEffect(() => {
    fetch(`/api/user/hotels/${hotelId}`)
      .then(res => res.json())
      .then(data => setHotel(data));
  }, [hotelId]);

  if (!hotel) return <div>加载中...</div>;

  // 按类型筛选nearby
  const scenicList = filterNearbyByType(hotel.nearby, 'scenic');
  const trafficList = filterNearbyByType(hotel.nearby, 'traffic');
  const mallList = filterNearbyByType(hotel.nearby, 'mall');

  // 渲染nearby项
  const renderNearbyItem = (list, icon, color) => {
    if (list.length === 0) return null;
    return (
      <div className="nearby-item">
        <Icon type={icon} color={color} size="18" />
        <span className="type-label">{list[0].type === 'scenic' ? '景点' : list[0].type === 'traffic' ? '交通' : '商场'}</span>
        <div className="nearby-content">
          {list.map(item => (
            <span key={item.id}>{item.name} ({item.distance})</span>
          ))}
        </div>
      </div>
    );
  };

  return (
    <div className="hotel-detail">
      {/* 酒店基础信息（名称/星级/地址等，省略） */}
      {/* 附近信息展示（核心） */}
      <div className="hotel-nearby">
        <h3>周边推荐</h3>
        {renderNearbyItem(scenicList, 'scenic-spot', '#FF9A3C')}
        {renderNearbyItem(trafficList, 'subway', '#1677FF')}
        {renderNearbyItem(mallList, 'shopping', '#FF3366')}
      </div>
      {/* 房型列表（省略，按价格升序排序） */}
    </div>
  );
};

export default HotelDetail;