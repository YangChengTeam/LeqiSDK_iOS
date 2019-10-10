# Ios 支付相关接口

## Index
- [支付通道](#支付通道)
- [IAP订单状态查询](#IAP订单状态查询)
- [订单创建接口](#订单创建接口)

## 支付通道
- 接口名: `ios_pay_init`
- 请求参数: 
```
{
    user_id: 用户ID
}
```
- 返回参数: 
```
{
    code:
    msg:
    data:{
        type: 支付通道: 0:IAP，1:h5
    }
}
```

## IAP订单状态查询
- 接口名: `ios_order_query`
- 请求参数: 
```
{
    receipt: 订单验证要素
    order_sn: 订单号
}
```
- 返回参数: 
```
{
    code: 0|1
    msg:
    data:{
        quantity
        product_id
        transaction_id
        purchase_date
        app_item_id
        bid
        bvrs
    }
}
```

## 订单创建接口
- 接口名: `ios_order`
- 请求参数: 
```
{
    game_id:
    user_id:
    pay_ways: 支付渠道:  iap/alipay/wxpay
    amount: 订单金额
    role: 游戏角色
    server: 游戏服务器
    productname: 商品名称
    attach: 游戏订单号
}
```
- 返回参数
```
{
    code:0|1
    msg:
    data:{
        url: 支付链接
        order_sn: 订单号
    }
}
```