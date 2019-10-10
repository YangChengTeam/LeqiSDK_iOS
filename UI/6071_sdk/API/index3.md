该文档为SDK第三版(v3)接口文档。仅仅对v3相对v2的差异做记录，不记录表示与v2一致。

# Index

- [手机号快速注册与登录](#手机号快速注册与登录)
- [用户名注册](#用户名注册)
- [用户名登录](#用户名登录)


## 更新说明
- 新增返回字段new_sdk_reg，用以标示用户是否属于新版本注册用户。
- 新增返回字段fix_name，用以对用户游戏角色丢失的情况做处理。

## 手机号快速注册与登录
- 接口名: index3/mobile_regORlogin
    
- 请求参数: 
```
{
    ts: 时间戳
    g: 游戏id
    a: 渠道信息(json)
    d: 设备类型：1为PC，2为安卓，3为苹果
    i: 手机串号
    sv: 系统版本
    code: 短信吗
    f: 推广人id
    is_quick: 是否快速注册
    version: sdk版本号
}
```
- 返回参数: 
```
{
    code: 
    msg:
    data: {
        user_id: 用户ID
        name: 用户名
        mobile: 用户手机
        pwd: 密码
        last_login_time: 上传登录时间
        reg_time: 注册时间
        mk: 
        is_vali_mobile: 手机号是否已验证: 0: 未验证；1: 已验证
        sign: 签名
        game_notice: {
            body: 游戏公告
        }
        agent_id: 用户所属渠道
        
        new_sdk_reg: 是否通过新SDK注册；0:否；1: 是
        fix_name: 矫正名，如果改值不为空，则把改值作为用户民返回给CP，用来处理用户角色丢失的情况
        cp_notice: CP是以用户名还是ID为唯一标记，0: 用户名；1：用户ID。该值为0，表示CP属于有问题CP
    }
}
```

## 用户名注册
- 接口名称: index3/reg
- 请求参数: 
```
{
    ts: 时间戳
    g: 游戏id
    a: 渠道信息(json)
    d: 设备类型: 1为PC，2为安卓，3为苹果
    i: 手机串号
    sv: 系统版本
    n: 用户名，快速注册时不用填
    p: 密码，快速注册时不用填
    f: 推广人id
    is_quick: 是否快速注册
}
```
- 返回参数: 
```
{
    code: 
    msg:
    data: {
        user_id: 用户ID
        name: 用户名
        mobile: 用户手机
        pwd: 密码
        last_login_time: 上传登录时间
        reg_time: 注册时间
        mk: 
        is_vali_mobile: 手机号是否已验证: 0: 未验证；1: 已验证
        sign: 签名
        game_notice: {
            body: 游戏公告
        }
        agent_id: 用户所属渠道
        
        new_sdk_reg: 是否通过新SDK注册；0:否；1: 是
        fix_name: 矫正名，如果改值不为空，则把改值作为用户民返回给CP，用来处理用户角色丢失的情况
        cp_notice: CP是以用户名还是ID为唯一标记，0: 用户名；1：用户ID。该值为0，表示CP属于有问题CP
    }
}
```

## 用户名登录
- 接口名称: index3/login
- 请求参数: 
```
{
    ts: 时间戳
    g: 游戏id
    a: 渠道信息(json)
    d: 设备类型: 1为PC，2为安卓，3为苹果
    i: 手机串号
    sv: 系统版本
    n: 用户名,快速注册时不用填
    p: 密码,快速注册时不用填
    version: sdk版本号
}
```
- 返回参数: 
```
{
    code: 
    msg:
    data: {
        user_id: 用户ID
        name: 用户名
        mobile: 用户手机
        pwd: 密码
        last_login_time: 上传登录时间
        reg_time: 注册时间
        mk: 
        is_vali_mobile: 手机号是否已验证: 0: 未验证；1: 已验证
        sign: 签名
        game_notice: {
            body: 游戏公告
        }
        agent_id: 用户所属渠道
        
        new_sdk_reg: 是否通过新SDK注册；0:否；1: 是
        fix_name: 矫正名，如果改值不为空，则把改值作为用户民返回给CP，用来处理用户角色丢失的情况
        cp_notice: CP是以用户名还是ID为唯一标记，0: 用户名；1：用户ID。该值为0，表示CP属于有问题CP
    }
}
```