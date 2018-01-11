1. 目前配置的NSIS是Unicode版本  所以在控制台看到的中文会是一个？号，不用管它

@rem 如果要调试错误，请使用下面的脚本，这样会打开编译界面（命令行界面中文会显示成?号）
".\NSIS\makensisw.exe" xxx


2. 在skin目录下配置界面

3. nsi文件是配置安装的相关信息 真正的安装逻辑在commonfunc.nsh以及与nsi文件在一起的 nsh文件中

4. 有接口不明白的，请参考示例以及文档描述  

5. 所有的nsis的nsi以及 nsh文件均需要是unicode或者utf-8编码 

6. 对于ShowMsgBox接口，增加了一个参数，用于指定弹出窗口使用的样式文件，例如：
nsNiuniuSkin::ShowMsgBox "notice title" "notice message." 0 "msgBox2.xml"
这样则会使用msgBox2.xml中描述的样式来显示窗口，便于个性化定制提示弹出窗口  

8. 要使用rtf文件作为许可协议文件，将协议文件改成rtf即可（参考nim示例）

9. 旧版本升级到新项目，需要修改原来的install.xml中的Font节点，从上往下依次指定Font的id值，建议从0开始（按原来的序号来，这样可以兼容旧的配置）
10.经常会有朋友反馈安装包有报毒的情况，请按如下方式处理
通过执行setup.exe（不要签名），先生成卸载程序，然后对卸载程序进行签名，再将卸载程序打包进setup.exe。
1）首先，由NSIS生成setup.exe，注意：不要对setup.exe进行签名。
2）执行setup.exe，待安装完成后，到安装目录找到uninst.exe，然后对uninst.exe进行签名。
3）将uninst.exe文件与需要被释放到安装目录下的文件一起打包 (放到FilesToInstall目录下)。
4）注释掉commonfunc.nsh文件中的这句：WriteUninstaller "$INSTDIR\uninst.exe"。
5）重新编译setup.nsi生成setup.exe，并对其进行签名。

10. 为了提升控件的可扩展性，控件2.0版本对接口进行了全面调整，从即日起请使用新版本接口（20171210）：
1) 去掉了SetDirValue、GetDirValue、GetCheckBoxStatus、SetSliderValue、SetSliderRange等函数，调整使用通用的SetControlAttribute以及GetControlAttribute来设置或获取 
2) 去掉了原来的ShowDlgBox接口；调整为先使用nsNiuniuSkin::InitSkinSubPage来初始化，返回子窗口句柄，然后使用nsNiuniuSkin::ShowSkinSubPage方式来实现 
  （这种方式可以最大程度的提升子窗口的可扩展性，UI可以任意定制了，不受控件ID号等任何限制）
3) 对所有的与UI相关的接口，均增加一个句柄参数，以便能够使用一个接口就可控制主窗口以及子窗口的各个属性的设置与获取  
4) 进一步调整了UI控件内部对于固定控件ID的引用，提升脚本的可控制性

参考地址：
http://blog.csdn.net/hellokandy/article/details/52212495