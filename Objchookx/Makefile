all: ios

ios:
	`xcrun --sdk iphoneos -f clang` \
		-shared	\
		-arch arm64 \
		-framework Foundation \
    	-isysroot `xcrun --sdk iphoneos --show-sdk-path` \
    	-miphoneos-version-min=8.0 \
    	-o out/hook.dylib \
      	src/main.m
	`xcrun --sdk iphoneos -f strip` -Sx out/hook.dylib

macos:
	clang -shared -arch arm64 -framework Foundation -o out/hook.dylib.arm64 src/main.m
	clang -shared -arch x86_64 -framework Foundation -o out/hook.dylib.x86_64 src/main.m
	lipo out/hook.dylib.arm64 out/hook.dylib.x86_64 -create -output out/hook.dylib
	rm out/hook.dylib.*
	strip -Sx out/hook.dylib
