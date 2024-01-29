Interceptor.replace(ObjC.classes.ClassName['- funcName'].implementation, new NativeCallback(function () {
    console.log("hook it!");
    return;
}, 'void', []));

Interceptor.replace(ObjC.classes.ClassName['funcName'].implementation, new NativeCallback(function () {
    return 0;
}, 'bool', []));