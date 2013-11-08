Feature: Edit User
  用户帐户管理

    Scenario: 用户登录管理帐户
      Given 我已经登录
      When 我更改我的帐户信息
      Then 我看更改成功的消息通知
