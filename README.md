<!-- TOC -->

- [PsAdbScreenCap](#psadbscreencap)
- [소개](#소개)
- [사용법](#사용법)

<!-- /TOC -->

<br>
<br>
<br>

# PsAdbScreenCap
![](https://raw.githubusercontent.com/HyundongHwang/PsAdbScreenCap/master/PsAdbScreenCap-icon.png)

[한국어로 보기](/README-ko.md)

<br>
<br>
<br>

# 소개
adb를 이용하면 `adb shell screencap -p /sdcard/aaa.png` 의 명령으로 안드로이드 스크린캡쳐를 할 수 있는데 <br>
디바이스마다 간혹 퍼미션 문제로 파일저장이 안되서 스크린캡쳐를 할 수 없는 경우가 있다. <br>
https://stackoverflow.com/questions/21086840/adb-shell-screencap-permission-denied <br>

```powershell
PS> adb shell screencap -p /sdcard/aaa.png
Error opening file: /sdcard/aaa.png (Permission denied)
```

그렇지만 파일로 저장을 못할뿐 캡쳐된 이미지버퍼를 오른쪽 파이프로 저장해서 호스트 디바이스에서 파일로 저장할 수 있다. <br>
그렇지만 이렇게 저장된 파일을 바로 열면 깨진 상태다. <br>
아래 2가지 문제를 더 해결해야 한다. <br>
1. 파워쉘의 텍스트 버퍼 인코딩 문제로 cmd.exe에서 스크린캡쳐 파일을 생성해야 한다. <br>
2. 안드로이드와 윈도우의 개행문자 인코딩 차이가 있기 때문에 0x0D, 0x0D, 0x0A 배열을 0x0A 로 수정해줘야 한다. <br>

<br>
이 스크립트는 이 과정들을 해결하여 어떤 기기에서도 화면캡쳐가 가능하게 해준다.

<br>
<br>
<br>

# 사용법

```powershell
PS C:\Users\hhd> adb-screencap -Verbose
자세한 정보 표시: ReadAllBytes ...
자세한 정보 표시: convert ...
자세한 정보 표시: WriteAllBytes ...
C:\Users\hhd\screencapture-171025-005831.png
```

- https://hhdpublish.blob.core.windows.net/pub/Teladinsto/screencapture-171025-010108.png