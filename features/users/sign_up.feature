Feature: Sign up
  用户注册

    Background:
      Given 我没有登录

    Scenario: 用户使用有效数据注册
      When 我使用有效的用户数据注册
      Then 我看到登录成功通知
      
    Scenario: 用户使用无效Email地址注册
      When 我使用无效Email地址注册
      Then 我看到Email无效的消息通知

    Scenario: 用户注册没有输入密码
      When 我注册时没有输入密码
      Then 我看到密码空白的消息通知

    Scenario: 用户注册没有输入确认密码
      When 我注册时没有输入确定密码
      Then 我看到两次输入密码不匹配的消息通知

    Scenario: 用户注册没有输入不同的确认密码
      When 我注册时两次输入密码不同
      Then 我看到两次输入密码不匹配的消息通知
