# Build a command-line program for ios

## c
`xcrun --sdk iphoneos -f clang` -arch arm64 \
      -isysroot `xcrun --sdk iphoneos --show-sdk-path` \
      -miphoneos-version-min=8.0 \
      -o hello \
      hello.m

`xcrun --sdk iphoneos -f strip` -Sx hello
`xcrun --sdk iphoneos -f codesign` -f -s - --entitlements entitlements.xml hello

## go
GOOS=darwin GOARCH=arm64 go build -trimpath -ldflags "-s -w" -o go-hello gohello/main.go

`xcrun --sdk iphoneos -f codesign` -f -s - --entitlements entitlements.xml go-hello
