Feature: Sign in
  用户注册

    Scenario: 非注册用户登录
      Given 我不是注册用户
      When 我用有效信息直接登录
      Then 我看到登录无效通知
        And 我应该没有登录

    Scenario: 用户登录成功
      Given 我是注册用户
        And 我没有登录
      When 我用有效信息直接登录
      Then 我看到登录有效通知
      When 我返回到主页
      Then 我应该已经登录

    Scenario: 用户输入错误Email
      Given 我是注册用户
      And 我没有登录
      When 我用错误的Email登录
      Then 我看到登录无效通知
      And 我应该没有登录
      
    Scenario: 用户输入错误密码
      Given 我是注册用户
      And 我没有登录
      When 我用错误的密码登录
      Then 我看到登录无效通知
      And 我应该没有登录

      