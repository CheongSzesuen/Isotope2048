## 设备适配

- 小米手环 9/10（192×490 胶囊屏）：原始布局，`designWidth: device-width` 下 1:1 像素坐标。
- 红米手表6（432×514 矩形屏）：独立 watch 布局，启动时经 `system.device.getInfo()` 检测（宽 400+ 且高大于宽的矩形屏自动匹配），包括 380×380 棋盘、88×88 大方块、放大字号与重新排布的按钮/分数/关于页。
- 红米手表6 的棋盘网格底图为 `src/common/watch-grid-light.png` / `watch-grid-dark.png`，由 `scripts/gen-watch-grid.ps1` 生成（配色取样自 bg1/bg2 素材）；改动棋盘坐标后需同步重跑该脚本。
- 已在 432×514 设备参数下通过 VM 冒烟验证（布局检测、格子定位、移动合成），真机验收待完成。

## 快速上手

### 1. 开发

```
npm install
npm run start
```

### 2. 构建

```
npm run build
npm run release
```

release 打包需要项目内 `sign/release/` 下的 `private.pem` + `certificate.pem`；当前使用 aiot-toolkit 自带开发证书，供个人侧载安装，上架时请替换为自己的开发者证书。

### 3. 调试

```
npm run watch
```
### 4. 代码规范化配置
代码规范化可以帮助开发者在git commit前进行代码校验、格式化、commit信息校验

使用前提：必须先关联git

macOS or Linux
```
sh husky.sh
```

windows
```
./husky.sh
```


## 了解更多

你可以通过我们的[官方文档](https://iot.mi.com/vela/quickapp)熟悉和了解快应用。
