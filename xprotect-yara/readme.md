
Apple OSX built in file defense is powered by YARA: `/System/Library/CoreServices/XProtect.bundle/Contents/Resources`
> https://gist.github.com/pedramamini/c586a151a978f971b70412ca4485c491

But now on m1 or a newer version `Xprotect` is here: `/Library/Apple/System/Library/CoreServices/XProtect.bundle/Contents/Resources`， you can run the `$cp /Library/Apple/System/Library/CoreServices/XProtect.bundle/Contents/Resources/XProtect.yara XProtect.yara` command to copy it.

About Xprotect: 
- https://support.apple.com/zh-cn/guide/security/sec469d47bd8/web
- https://iboysoft.com/wiki/xprotect-mac.html