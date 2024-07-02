# owasp - iOS UnCrackable L2
> https://mas.owasp.org/crackmes/

两篇解决方案都看完了：
- http://www.ryantzj.com/cracking-owasp-mstg-ios-crackme-the-uncrackable.html
- https://0xsysenter.github.io/ios/reversing/arm64/mobile/ipa/frida/instrumentation/crackme/2021/02/08/ios-apps-reverse-engineering-solving-crackmes-part-2.html

## 总结一个更快的解决方案
1. 先修补ipa 让其支持64

```asm
# Fix offset to LC_COMMAND_64
0x1000052d8 -> add x21, x22, 0x20

# Remove unnecessary check for LC_COMMAND==LC_SEGMENT
0x100005304 -> nop

# Fix sizeof(segment_command_64)
0x100005328 -> add x20, x23, 0x48

# Fix sizeof(section_64)
0x100005350 -> add x20, x20, 0x50

# Fix register size for section_64.addr and section_64.size
0x100005360 -> ldp x8, x1, [x20, 0x20]

# Fix register size for segment_command_64.vmaddr:
0x100005364 -> ldr x9, [x23, 0x18]

# Fix register size for baseaddr and section_64.addr
0x100005368 -> add x8, x8, x22

# Fix register size for section_64.addr and segment_command_64.vmaddr
0x10000536c -> sub x8, x8, x9

# Fix register size for CC_MD5's first argument
0x100005370 -> mov x0,x8
```

2. 绕过反调试

此应用有三处反调试，一一绕过：
```js
Interceptor.attach(Module.findExportByName(null, "ptrace"), {
    onEnter: function (args) {
        args[0] = ptr(-1);
    },
});

Interceptor.attach(Module.findExportByName(null, "task_get_exception_ports"), {
    onEnter: function (args) {
        args[1] = ptr(0);
    },
});

Interceptor.attach(Module.findExportByName(null, "sysctl"), {
    onLeave: function (retval) {
        retval.replace(0x00);
    },
});
```

启动程序：`frida -U -f sg.vp.UnCrackable-2 -l patch.js`。

3. 绕过加解密

根据加密函数生成一对key和密文：
- key: 123
- message: hello
- data: q1E0rg3cThvCRL2twsnMVA==

```js
new ObjC.Object(ObjC.classes.AESCrypt["+ encrypt:password:"](ObjC.classes.NSString.stringWithString_
("hello"), ObjC.classes.NSString.stringWithString_("123"))).toString()
```

修改密钥初始化的地方：

```js
Interceptor.attach(ObjC.classes.NSString["+ stringWithCString:encoding:"].implementation, {
    onEnter: function (args) {
        if (args[2].readUtf8String().length == 32) { // 原本为了防篡改的计算macho text的md5
            key = "123"
            args[2].writeUtf8String(key)
        }else{
            data = "q1E0rg3cThvCRL2twsnMVA=="
            args[2].writeUtf8String(data)
        }
    },
});
```

或者直接改decrypt

```js
Interceptor.attach(ObjC.classes.AESCrypt["+ decrypt:password:"].implementation, {
    onEnter: function (args) {
        args[2] = ObjC.classes.NSString.stringWithString_("q1E0rg3cThvCRL2twsnMVA==")
        args[3] = ObjC.classes.NSString.stringWithString_("123")
    },
});
```

![](./imgs/IMG_0006.PNG)