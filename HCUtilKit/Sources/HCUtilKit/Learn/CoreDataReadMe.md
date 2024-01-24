# 业务指南
BS_开头的实体，表示Business，即业务实体
DS_开头，表示基本的数据结构

##  新增对象
1. 新增对象，假如不保存的话，有几种方式：
（1）保存到main context，但是不保存时，使用 rollback
（2）保存到 childe contenx，不保存时，不适用 child context save即可
（3）

## 通用字段
- version: 数据库版本
- 


# 参考文档
https://developer.apple.com/library/archive/documentation/DataManagement/Conceptual/CloudKitQuickStart/Introduction/Introduction.html#//apple_ref/doc/uid/TP40014987-CH1-SW1
https://github.com/DeveloperErenLiu/CoreDataPDF
https://developer.apple.com/library/archive/navigation/#section=Technologies&topic=CloudKit
https://s0developer0apple0com.icopy.site/


# 开发工具
查看 core data 
https://betamagic.nl/products/coredatalab.html 收费软件
https://github.com/ChristianKienle/Core-Data-Editor 开源软件

# 第三方库
## TMLPersistentContainer
https://github.com/johnfairh/TMLPersistentContainer
version: 5.0.1
Shortest-path multi-step Core Data migrations in Swift

## MagicalRecord
https://github.com/magicalpanda/MagicalRecord

## CoreStore
不支持 cloudkit，很遗憾

## JSQCoreDataKit
A swifter Core Data stack 
https://github.com/jessesquires/JSQCoreDataKit
version: 9.0.3
pod 'JSQCoreDataKit'

## Sync
JSON to Core Data and back https://github.com/3lvis/Sync
pod 'Sync'

## JSON 库
https://github.com/gonzalezreal/Groot
https://github.com/Yalantis/FastEasyMapping


## 查询
https://github.com/KrakenDev/PrediKit
https://github.com/ftchirou/PredicateKit
NSPredicate 的便捷

PredicateKit 库更好用


# 调试

-com.apple.CoreData.ConcurrencyDebug

及时发现由托管对象或上下文线程错误而导致的问题。执行任何可能导致错误的代码时，应用程序会立刻崩溃，帮助在开发阶段清除隐患。启用后，控制台会显示 CoreData: annotation: Core Data multi-threading assertions enabled.

-com.apple.CoreData.CloudKitDebug

CloudKit 调试信息输出级别，从 1 开始，数字越大信息愈详尽

-com.apple.CoreData.SQLDebug

CoreData 发送到 SQLite 的实际 SQL 语句，1——4，数值越大越详细。输出提供的信息在调试性能问题时很有用——特别是它可以告诉你什么时候 Core Data 正在执行大量的小提取（例如当单独填充 fault 时）。

-com.apple.CoreData.MigrationDebug

迁移调试启动参数将使您在控制台中了解迁移数据时的异常情况。

-com.apple.CoreData.Logging.stderr

信息输出开关

设置 -com.apple.CoreData.Logging.stderr 0，所有的同数据库有关日志信息都将不再输出。
