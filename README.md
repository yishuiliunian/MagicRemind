# MagicRemind

[![CI Status](http://img.shields.io/travis/stonedong/MagicRemind.svg?style=flat)](https://travis-ci.org/stonedong/MagicRemind)
[![Version](https://img.shields.io/cocoapods/v/MagicRemind.svg?style=flat)](http://cocoapods.org/pods/MagicRemind)
[![License](https://img.shields.io/cocoapods/l/MagicRemind.svg?style=flat)](http://cocoapods.org/pods/MagicRemind)
[![Platform](https://img.shields.io/cocoapods/p/MagicRemind.svg?style=flat)](http://cocoapods.org/pods/MagicRemind)

>MagicRemind，极大简化提醒功能开发

## Usage

To run the example project, clone the repo, and run `pod install` from the Example directory first.


## Installation

MagicRemind is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "MagicRemind"
```

## Features
### 目前功能

1. 支持badge样式的提醒
2. 支持提醒存储和恢复，在app重启后能够恢复提醒
3. 支持自动点灭，用户点击后，自动置灭提醒

## TO DO

1. 支持简单布局的提醒样式，让提醒样式更加多样化

## Usage


###（1） 对UI元素扩展提醒功能
Just one line code

```
    MRExtendViewRemindLogic(aView, @"aRemindIdentifier");
```

### （2）设置提醒数据


```
    [[MRStorage shareStorage] updateRemind:@"aRemindIdentifier" text:@"2"];
```

## Author

stonedong, yishuiliunian@gmail.com


## Design
做过Badge之类的功能的同学，大概都有段不是很美好的回忆。多处维护的提醒逻辑，点击消除的逻辑，存储逻辑。。。。巴拉巴拉。关键的是，任何需要有提醒的地方上述逻辑都得新建一个类重放一边上述工作。于是，有了MagicRemind，简化提醒功能编码。努力做到***一行代码实现提醒功能***。

###整体架构

### 基础规则

1. 每个UI元素与提醒信息为一对一关系。每个提醒信息有唯一标识，并且唯一绑定一个UI元素。
2. 每个提醒信息的展示与否只存储在与之对应的模型中，通过更改模型来更改展示信息，不直接修改UI元素。
3. 单个提醒本身不关心提醒间的依赖关系，比如A位置的提醒被用户点击而灭掉之后要出发B位置的提醒灭掉之类的信息。
4. 复杂的提醒逻辑，比如依赖关系，连带关系等，通过功能扩展实现，不在底层提供。


基于上述基础规则，整体分成三个层次

1. 数据存储层负责提醒数据的维护和存储，并包含了提醒的核心数据结构（逻辑模型与展示模型）
2. 桥接层，做为展示层和逻辑层中间的协调者，负责两者之间的交互。之所以没有叫这一层业务逻辑层，是因为提醒的逻辑绝大多数是与展示层糅合在一起。而该层次单纯的只是，桥接界面与数据。同时提供基础的依赖注入能力。
3. 展示层，展示提醒，提醒点击消灭逻辑。

![](http://ww4.sinaimg.cn/large/7df22103jw1f2u4zoec19j20cx0a63yv.jpg)

提醒的样式与展示与否信息通过核心数据模型```MRItem```存储

```
@interface MRItem : NSObject <NSCoding>
@property (nonatomic, assign) BOOL neeedUpdate;
@property (nonatomic, strong) NSString* identifier;
@property (nonatomic, assign, readonly) BOOL show;
@property (nonatomic, strong) NSArray* layoutItems;
@end
```

通过identifier可以定位一个提醒数据和与提醒绑定的UI元素（如果已经创建并展示在界面的话）


###核心技术（isa_swzzing与切面范式）
在UI上添加提醒的时候，最繁重的工作在于要在非常的多的UI元素上添加功能，而这些UI元素属于不同的类，有的是UIView有的是UIButton，有的是UITableViewCell...我们很难提供统一的基类来处理这个事情。同时我们希望这些类的实例上面有我们的提醒处理逻辑。该场景是切面范式的典型应用场景。我们以UI元素的布局和展示位置注入点（layoutsubviews），进行编制。具体使用到了Runtime的isa_swizzing技术以及类的动态生成。

![](http://ww4.sinaimg.cn/large/7df22103jw1f2u5kwvejoj20i70c2q3e.jpg)

我们举个例子，加入一个UI元素的instance目前是UIView类。如上图所示在未处理之前，instance的isa指针指向一个UIView。但是经过处理之后instance的isa指针指向了，我们在运行时创建的类UIView_exteandlass。该类继承在原始的类UIView，这是为了保证该instance原有的业务逻辑不受影响。通过继承我们全量保留了原有类中的业务逻辑。

同时我们通过method_swizzing技术奖类DZLogic1和红点业务逻辑的类，注入到了新生成的类UIView_extandlas中。

并且将instance的isa指针修改到我们心生成的类。这样instance就有了红点的功能。简单封装一下我们就能提供接口，让调用者来使用注入红点逻辑的功能；

```
FOUNDATION_EXTERN id MRExtendViewRemindLogic(UIView* view, NSString* identifier);
FOUNDATION_EXTERN void MRExtendTabarItemRemindLogic(UITabBarItem* item , NSString* identifier);
FOUNDATION_EXTERN MRInjectionView* MRExternNavigationBarItemRemindLogic(UIBarButtonItem* item, NSString* identifier);
```

## License

MagicRemind is available under the MIT license. See the LICENSE file for more info.
