# Index2 Api

## Index
- [初始化](#初始化)
- [更新运营商通道](#更新运营商通道)
- [手机登录](#手机登录)
- [注册](#注册)
- [发送验证码](#发送验证码)
- [SDK模块列表](#SDK模块列表)
- [注册短信码](#注册短信码)
- [绑定手机短信码](#绑定手机短信码)
- [用户资料](#用户资料)
- [支付初始化](#支付初始化)
- [更新个人资料](#更新个人资料)
- [游戏币](#游戏币)
- [登录](#登录)
- [修改密码](#修改密码)
- [活动列表](#活动列表)
- [活动详情](#活动详情)
- [取消支付](#取消支付)
- [创建订单](#创建订单)
- [订单状态查询](#订单状态查询)
- [订单列表](#订单列表)
- [游戏礼包](#游戏礼包)
- [礼包列表](#礼包列表)
- [商品列表](#商品列表)
- [SDK返利](#SDK返利)
- [继续支付](#继续支付)
- [继续支付wx](#继续支付wx)
- [实名认证](#实名认证)

## 公共参数
```
{
    a: 渠道ID
    i: 设备串号
    ts: 时间戳
    g: 游戏ID
    version: SDK版本
    d: 设备类型: 1为PC，2为安卓，3为苹果
    sv: 系统版本
}
```

### 初始化
- 接口名: `init`
- 请求参数: 
```
{
    mt: 运营商类型:0为移动，1为联通，2为电信
    [user_id]: 用户ID
}
```
- 返回参数
```
{
    code: 1,
    data: {
        login_logo: 登录logo
        launch_img: 启动画面
        tel: 客服电话
        qq: 客服QQ
        qq_qun: 玩家交流群
        payway: [
            {
                a: 支付方式ID
                b: 支付名
                c: 支付说明
            }
            ...
        ], 充值方式
        debug: 
        bug_url: bug提交地址
        mt_code: 运营商类型
        mqr_num_limit: 手机一键注册最多请求次数
        mqr_delay: 每次请求延时时间，单位: 毫秒
        template: {
            id: 1,
            title: 蓝色,
            head_color: f2ffffff,
            bg_color: f2f1f1f1,
            btn_color: ff19b0f5,
            notice_color: fff1f1f1,
            font_color: ff555555,
            module_color: fffafafa,
            reg_img: http://pic.6071.com/Upload/Picture/2016-11-28/583ba6eb31430.jpg,
            play_img: http://pic.6071.com/Upload/Picture/2016-11-28/583ba6eb31290.jpg,
            change_img: http://pic.6071.com/Upload/Picture/2016-11-29/583ce6583bcab.jpg,
            img: http://pic.6071.com/Upload/Picture/2016-11-25/5837e09777ac6.jpg,
            sort: 50,
            status: 0
        }
        floatico_info: {
            float_drag: http://pic.6071.com/Upload/Picture/2017-12-15/5a3361abd0e5c.png,
            float_holder: http://pic.6071.com/Upload/Picture/2017-12-15/5a3361abd0fa9.png,
            float_holder2: http://pic.6071.com/Upload/Picture/2017-12-15/5a3361abd10e5.png
        },
        is_mqr: 是否开启手机一键快速注册
        version_upd: {
            is_upd:
            down_url: 
        },
        is_speed_up: 是否加速（忽略）
        is_auto_click: 自动点击（忽略）
        box_info: {
            box_down_url: 盒子下载地址
            box_package_name: 盒子包名
        },
        logout: {
            img: 退出广告图
            type: 点击类型
            type_value: 值
            package_name: 包名
        },
        weixin: 渠道微信
        vertical: 横竖屏
        share_content: 分享内容
        agent_id: 渠道ID
        domain: 域名
        game_kefu_qq: 客服QQ群
        sms_mobile_list: 
    },
    msg: 初始化信息成功
}
```

### 更新运营商通道
- 接口名: `upd_mtCodes`
- 请求参数
```
{
    mt_code: 运营商号码
    mt: 运营商类型:0为移动，1为联通，2为电信
}
```
- 返回参数
```
{
    code:
    msg:
    data:
}
```

### 手机登录
- 接口名: `mobile_regORlogin`
- 请求参数
```
{
    code: 短信吗
    f: 推广人id
    is_quick: 是否快速注册
}
```
- 返回参数
```
{
    code:
    msg:
    data: {
        name: 用户名
        mobile: 手机号
        pwd: 
        last_login_time: 最后登录时间
        reg_time: 注册时间
        mk: 随机串
        user_id: 用户ID
        is_vali_mobile: 手机是否验证
        sign: 签名
        game_notice: {
            id: 公告ID
            body: 公告内容
        }
        agent_id: 所属渠道
    }
}
```

### 注册
- 接口名: `reg`
- 请求参数
```
{
    n: 用户名:快速注册时不用填
    p: 密码:快速注册时不用填
    f: 推广人id
    is_quick: 是否快速注册
}
```
- 返回参数
```
{
    code:
    msg:
    data: {
        name: 用户名
        mobile: 手机号
        pwd: 
        last_login_time: 最后登录时间
        reg_time: 注册时间
        mk: 随机串
        user_id: 用户ID
        is_vali_mobile: 手机是否验证
        sign: 签名
        game_notice: {
            id: 公告ID
            body: 公告内容
        }
        agent_id: 所属渠道
    }
}
```

### 发送验证码
- 接口名: `send_code`
- 请求参数
```
{
    m: 手机号
}
```
- 返回参数
```
{
    code:
    msg:
    data: 
}
```

### SDK模块列表
- 接口名: `module_list`
- 请求参数
```
{
    page: 页码
    user_id: 用户ID
}
```
- 返回参数
```
{
    code:
    msg:
    data: {
        list: [
            {
                id: ID号
                title: 名称
                ico: 图标
                type: 类型
                type_val: 类型值
                sort: 排序
                status: 状态
                num: 消息数
            },
            ...
        ],
        page_count: 总页数
    }
}
```

### 注册短信码
- 接口名: `mobile_reg_sendCode`
- 请求参数
```
{
    m: 手机号
}
```
- 返回参数
```
{
    code:
    msg:
    data:
}
```

### 绑定手机短信码
- 接口名: `bind_mobile_send_code`
- 请求参数
```
{
    m: 手机号
    n: 用户名
}
```
- 返回参数
```
{
    code:
    msg:
    data:
}
```

### 用户资料
- 接口名: `get_user_info`
- 请求参数
```
{
    user_id: 用户ID
}
```
- 返回参数
```
{
    code:
    msg:
    data: {
        user_id: 用户ID
        name: 用户名
        mobile: 手机
        nick_name: 昵称
        face: 头像
        sex: 性别
        birth: 生日
        area_id: 地区
        email: 邮箱
        qq: qq
        money: 平台币
        vip_level: VIP等级
        game_money: 游戏币
        is_vali_mobile: 手机验证状态
        kefu_qq: 客服QQ
        share_content: 分享内容
        game_return: 是否开启游戏返利
    },
}
```

### 支付初始化
- 接口名: `pay_init`
- 请求参数
```
{
    user_id: 用户ID
}
```
- 返回参数
```
{
    code:
    msg:
    data: {
        user_id: 用户ID
        money: 平台币
        game_money: 游戏币
        coupon_list: [
            goods_uc_start_time: 有效期
            goods_uc_end_time: 有效期
            limit_money: 最低充值金额
        ],
        coupon_count: 优惠券数量
    },
}
```

### 更新个人资料
- 接口名: `upd_user_info`
- 请求参数
```
{
    user_id: 用户ID
    nick_name: 昵称
    sex: 性别
    birth: 生日
    email: 邮箱
    qq: qq
    face: 头像
}
```
- 返回参数
```
{
    code:
    msg:
    data:
}
```

### 游戏币
- 接口名: `game_money_list`
- 请求参数
```
{
    user_id: 用户ID
}
```
- 返回参数
```
{
    code:
    msg:
    data: [
        {
            game_id: 游戏ID
            name: 游戏名
            ico: 游戏图标
            money: 游戏币
        }
        ...
    ]
}
```

### 登录
- 接口名: `login`
- 请求参数
```
{
    n: 用户名
    p: 密码
}
```
- 返回参数
```
{
    code:
    msg:
    data: {
        name: 用户名
        mobile: 手机号
        pwd: 
        last_login_time: 最后登录时间
        reg_time: 注册时间
        mk: 随机串
        user_id: 用户ID
        is_vali_mobile: 手机是否验证
        sign: 签名
        game_notice: {
            id: 公告ID
            body: 公告内容
        }
        agent_id: 所属渠道
    }
}
```

### 修改密码
- 接口名: `upd_pwd`
- 请求参数
```
{
    n: 用户名
    old_pwd: 旧密码
    new_pwd: 新密码
}
```
- 返回参数
```
{
    code:
    msg:
    data: {
        point_action_msg: 行为消息
        res: 结果
    }
}
```

### 活动列表
- 接口名: `activity_list`
- 请求参数
```
{
    user_id: 用户ID
}
```
- 返回参数
```
{
    code:
    msg:
    data: [
        {
            id
            title: 活动名称
            img: 图片
            start_time: 开始时间
            end_time: 结束时间
            body: 活动内容
            game_id: 游戏编号
            agent_id: 渠道编号
            agent_pid: 上级渠道编号
            status: 状态（0: 正常，1: 下架）
            flag: 标记（推荐: comm、热门: hot等）
            sort: 排序
            add_time: 添加时间
            type: 动作类型0: sdk自己的页面,1: sdk自己的浏览器页面,2: 启动盒子,3: 外部浏览器页面,4: 外部插件
            type_value: 动作值
        }
    ]
}
```

### 活动详情
- 接口名: `activity_detail`
- 请求参数
```
{
    user_id: 用户ID
}
```
- 返回参数
```
{
    code:
    msg:
    data: {
        id
        title: 活动名称
        img: 图片
        start_time: 开始时间
        end_time: 结束时间
        body: 活动内容
        game_id: 游戏编号
        agent_id: 渠道编号
        agent_pid: 上级渠道编号
        status: 状态（0: 正常，1: 下架）
        flag: 标记（推荐: comm、热门: hot等）
        sort: 排序
        add_time: 添加时间
        type: 动作类型0: sdk自己的页面,1: sdk自己的浏览器页面,2: 启动盒子,3: 外部浏览器页面,4: 外部插件
        type_value: 动作值
    }
}
```

### 取消支付
- 接口名: `cancel_pay`
- 请求参数
```
{
    orderid: 订单号
}
```
- 返回参数
```
{
    code:
    msg:
    data:
}
```

### 创建订单
- 接口名: `pay`
- 请求参数
```
{
    user_id: 用户编号
    is_game_pay: 0: 平台币充值，1: 游戏充值
    pay_ways: 充值方式，多个用|号隔开
    amount: 订单金额
    good_type_name: 商品类型名称。如: first_pay_card(首充卡)
    goods_id: 商品编号
    card_id: 卡编号
    role: 游戏角色
    server: 游戏区服
    productname: 商品名称
    attach: 游戏订单号
    md5signstr: 
}
```
- 返回参数
```
{
    code:
    msg:
    data:{
        rmb_money: 付款金额
        order_sn: 订单号
        
        // 微信支付参数
        rsmd5
        starttime
        
        // 支付宝支付参数
        params: {
            partnerid: 商户号
            email: 邮箱
            privatekey: 公钥
        }
    }
}
```

### 订单状态查询
- 接口名: `orders_chk`
- 请求参数
```
{
    order_sn: 订单号
}
```
- 返回参数
```
{
    code:
    msg:
    data:{
        point_action_msg: 行为消息
    }
}
```

### 订单列表
- 接口名: `order_list`
- 请求参数
```
{
    user_id: 用户ID
    page: 页码
    start_time: 开始时间
    end_time: 结束时间
    is_all_game: 是否查询所有游戏
    order_status: 订单状态
}
```
- 返回参数
```
{
    code:
    msg:
    data:[
        {
            order_sn: 订单号
            status: 订单状态
            status_msg: 状态消息
            desp: 订单说明
            money: 订单金额
            rmb_money: 付款金额
            finish_time: 支付时间
            pay_way_title: 支付方式
        }
        ...
    ]
}
```

### 游戏礼包
- 接口名: `gift_index`
- 请求参数
```
{
    page: 页码
}
```
- 返回参数
```
{
    code:
    msg:
    data:[
        {
            game_id: 游戏ID
            game_name: 游戏名
            last_gift_name: 礼包名称
            ico: 游戏图标
            num: 礼包数量
        }
        ...
    ]
}
```

### 礼包列表
- 接口名: `gift_list`
- 请求参数
```
{
    page: 页码
}
```
- 返回参数
```
{
    code:
    msg:
    data:[
        {
            id: 礼包ID
            name: 礼包名称
            content: 礼包内容
            change_note: 兑换方式
            desp: 礼包说明
            img: 礼包图片
            is_pay: 是否需要积分兑换
            start_time: 开始时间
            end_time: 结束时间
            total_num: 礼包总数
            remain_num: 剩余数量
            goods_id: 商品ID
            goods_type_id: 商品类别ID
            access_date: 到期日期
        }
        ...
    ]
}
```

### 商品列表
- 接口名: `goods_list`
- 请求参数
```
{
    goods_type_id: 商品分类ID
    page: 页码
}
```
- 返回参数
```
{
    code:
    msg:
    data:[
        {
            id: 商品ID
            name: 商品名称
            type_id: 分类编号
            type_val: 分类对应的值（如分类为礼包，则为礼包的id，如分类为游戏币，则为游戏币的数量，如分类为游戏币，则为游戏币的数量）
            game_id: 游戏id
            img: 商品图片
            desp: 商品描述
            price: 商品价格
            stock: 总库存
            curr_stock: 剩余库存
            max_buy_num: 最大可买数量（0: 不限制）
            is_comm: 是否推荐（0: 否，1: 是）
            uc_start_time: 使用条件: 有效期开始时间，0: 没有限制
            uc_end_time: 使用条件: 有效期结束时间，0: 没有限制
            uc_money: 使用条件: 金额必须大于该值才可以使用，0: 没有限制
            sort: 排序
            status: 状态（0: 下架，1: 上架）
            type_name: 分类名称
            game_id: 游戏ID
            game_name: 游戏名称
        }
        ...
    ]
}
```

### SDK返利
- 接口名: `pay_opt`
- 请求参数
```
{
    user_id: 用户ID
}
```
- 返回参数
```
{
    code:
    msg:
    data:[
        {

        }
        ...
    ]
}
```

### 继续支付
- 接口名: `continue_pay`
- 请求参数
```
{
    orderid: 订单号
}
```
- 返回参数
```
{
    code:
    msg:
    data:{
        user_id: 用户ID
        is_game_pay: 游戏充值
        pay_ways: 支付方式
        amount: 订单金额
        good_type_name: 商品分类名称
        goods_id: 商品ID
        card_id: 优惠券ID
        role: 游戏结束
        server: 游戏区服
        productname: 订单标题
        attach: 游戏订单号
        rmb_money: 付款金额
        order_sn: 订单号
        
        // 支付宝付款参数
        params: {
            partnerid: 商户号
            email: 邮箱
            privatekey: 公钥
        }
        
        // 微信付款参数
        rsmd5: 
        starttime: 
    }
}
```

### 继续支付wx
- 接口名: `continue_pay_wx`
- 请求参数
```
{
    orderid: 订单号
}
```
- 返回参数
```
{
    code:
    msg:
    data:{
        rmb_money: 付款金额
        order_sn: 订单号
        
        // 支付宝付款参数
        params: {
            partnerid: 商户号
            email: 邮箱
            privatekey: 公钥
        }
        
        // 微信付款参数
        rsmd5: 
        starttime: 
    }
}
```

### 实名认证
- 接口名: `real_auth`
- 请求参数
```
{
    user_id: 用户ID
    real_name: 真实姓名
    card_num: 身份证号
    [mobile]: 手机
    [bank_card]: 银行卡号
    [type]: 认证方式
}
```
- 返回参数
```
{
    code:
    msg:
    data:
}
```