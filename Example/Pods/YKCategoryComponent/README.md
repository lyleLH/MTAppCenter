# YKCategoryComponent

## 项目介绍
基本介绍
- 将所有App项目中会用到的分类（category）抽取整理出来，方便管理和降低代码冗余。

- 所有的`category`命名规则是前缀`yk_` + **小驼峰** ，在实际使用中记住这一点会更方便自动补全。

- 所有的分类方法 **都带有注释**或者方法名自解释，如有发现不知道具体含义的方法，欢迎提出，我会做进一步注释。在自动补全时根据提示的注释和方法名进行选择。

文件组织的方式主要是分为三大类
- Foundation 框架的扩展
- UIKit的扩展 （TODO）
- 第三方库的扩展 （TODO）

特别说明

对`NSArray`的操作和`NSDictionary`的操作，各位可以了解一下，用来更安全使用`OC`集合对象。


## 安装和使用
 
```ruby
pod 'YKCategoryComponent'
```
## 在已有项目中替换原有的方法
暂时没有比较方便的办法。

建议接入的时候，将现有App项目中的Category目录下的分类文件现删除一个，删除之后，工程会报错 找不到头文件和找不到方法 。

再从本库中去寻找对应的方法，将原来使用的方法进行替换。
以上步骤循环往复.

最好是原Category目录下的文件全部删除，也就是百分百依赖本组件。

小心操作。
### 特别说明
该组件未能覆盖到的分类和方法，请告知我，我第一时间会将你需要的文件和方法加入到组件中，进行升级。





## 文档库
直接查看头文件注释
或者`clone`本项目在本地查看`apiDoc`目录下的`index`文件


![](http://ww1.sinaimg.cn/mw690/6de36fdcgy1gmezmw5s8lj21bc0n6jvm.jpg)
![](http://ww1.sinaimg.cn/mw690/6de36fdcgy1gmezq1cv97j21sw1vigtq.jpg)
## Author

Tom.Liu, tomliu@yeahka.com


