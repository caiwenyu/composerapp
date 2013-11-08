Feature: Sign out
  用户退出

    Scenario: 用户退出
      Given 我已经登录
      When 我选择退出
      Then 我看到退出成功通知
      When 我返回到主页
      Then 我应该没有登录
