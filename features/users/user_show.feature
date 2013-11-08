Feature: Show Users
  查看用户列表

    Scenario: 查看用户列表
      Given 我是注册用户
      When 我查看用户列表
      Then 我应该看到我的名字
