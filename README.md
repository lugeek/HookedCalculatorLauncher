### Hook Calculator.app
1. 创建跳板App，用户目标App的hook及跳转。
![1](https://raw.githubusercontent.com/lugeek/HookedCalculatorLauncher/master/imgs/a1%202020-09-24%2019.32.52.png)

2. 为创建的App添加target，类型位dynamic library，这是存放hook逻辑的dylib核心。
![2](https://raw.githubusercontent.com/lugeek/HookedCalculatorLauncher/master/imgs/a2%202020-09-24%2019.35.32.png)
![3](https://raw.githubusercontent.com/lugeek/HookedCalculatorLauncher/master/imgs/a3%202020-09-24%2019.36.00.png)
![4](https://raw.githubusercontent.com/lugeek/HookedCalculatorLauncher/master/imgs/a4%202020-09-24%2019.36.57.png)

3. 修改Project的Build Phase ，Dependencies添加刚刚的Dynamic Library，Copy Bundle Resources添加Dynamic Library对应的dylib，目的是为了让App通过Bundle访问到dylib这个资源。
![5](https://raw.githubusercontent.com/lugeek/HookedCalculatorLauncher/master/imgs/a5%202020-09-24%2019.37.45.png)

4. 如遇到crash：SYSCALL_SET_PROFILE Could not set sandbox profile data: Operation not permitted (1)，则将App Sandbox 设为NO
![6](https://raw.githubusercontent.com/lugeek/HookedCalculatorLauncher/master/imgs/a6%202020-09-24%2019.47.51.png)

5. 添加UIElement到info.plist中，让跳板app不出现在dock栏。
![7](https://raw.githubusercontent.com/lugeek/HookedCalculatorLauncher/master/imgs/a7%202020-09-24%2019.49.49.png)

6. 打开关于计算器，展示的弹窗已经被hook
![8](https://raw.githubusercontent.com/lugeek/HookedCalculatorLauncher/master/imgs/a8%202020-09-24%2019.48.15.png)

### 注意
在 macOS 10.12之后，默认开启了SIP(System Integrity Protection)，DYLD_INSERT_LIBRARIES这种方式行不通了，需要将SIP关闭之后才可以，关闭方式如下：
1. Restart your computer
2. Boot to recovery partition by holding (Command [⌘] +  R)
3. Open terminal from the menubar
4. Enter this command:`csrutil disable`

### 参考
1. [macOS 逆向之生成动态注入 App](https://blog.nswebfrog.com/2018/02/09/make-injection-app-for-mac/)
2. [Simple code injection using DYLD_INSERT_LIBRARIES](https://blog.timac.org/2012/1218-simple-code-injection-using-dyld_insert_libraries/)
3. [DYLD_INSERT_LIBRARIES DYLIB injection in macOS / OSX](https://theevilbit.github.io/posts/dyld_insert_libraries_dylib_injection_in_macos_osx_deep_dive/)
4. [How to Inject Code into Mach-O Apps. Part I.](https://medium.com/@jon.gabilondo.angulo_7635/how-to-inject-code-into-mach-o-apps-part-i-17ed375f736e)
5. [How to Inject Code into Mach-O Apps. Part II.](https://medium.com/@jon.gabilondo.angulo_7635/how-to-inject-code-into-mach-o-apps-part-ii-ddb13ebc8191)
6. [MacForge](https://github.com/MacEnhance/MacForge)