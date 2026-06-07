# Xiaomi Redmi K70 Pro (manet) Device Tree

这是为 **Xiaomi Redmi K70 Pro**（代号 `manet`）定制的设备树（Device Tree），基于 **Android 16** 和 **澎湃OS 3 (HyperOS 3)** 固件版本 `OS3.0.9.0.WNMCNXM_16.0` 构建。

该仓库包含了设备配置文件、硬件适配层、构建脚本等关键部分，用于构建基于 AOSP 的类原生系统（如 LineageOS 22+、AxionOS 等）。

## 设备状态

> **当前状态：🚧 正在适配中**

- **构建状态**：设备树基础结构已就绪，可进行初始构建测试。
- **固件版本**：基于 `manet_images_OS3.0.9.0.WNMCNXM_16.0` (Android 16，HyperOS 3)。
- **维护状态**：个人维护，不定期更新。

## 设备信息

| 项目 | 规格 |
| :--- | :--- |
| **品牌** | 红米 (Redmi) |
| **型号** | Redmi K70 Pro (国行版) |
| **代号** | manet |
| **芯片组** | Qualcomm Snapdragon 8 Gen 3 (SM8650-AB) |
| **GPU** | Adreno 750 |
| **内存** | 12/16/24 GB |
| **存储** | 256/512 GB / 1 TB |
| **屏幕** | 6.67英寸 OLED, 1440 x 3200, 120Hz |
| **后置相机** | 5000万像素主摄 + 3.2倍长焦镜头 |
| **电池** | 5000mAh |
| **操作系统** | 澎湃OS 3 (HyperOS 3) – Android 16 |

## 关键功能

- **内核**：基于小米官方开源内核适配，确保稳定性与性能。
- **供应商**：使用 `proprietary-files.txt` 精确管理厂商闭源驱动。
- **构建**：提供 `setup-makefiles.sh`（或 `extract-files.py`），简化与 ROM 源码的集成过程。

## 如何构建

### 前提条件

- 一个配置完善的 Android 构建环境（推荐 Ubuntu 22.04 或更高）。
- 至少 200GB 可用磁盘空间和稳定的网络。
- 已下载 `manet_images_OS3.0.9.0.WNMCNXM_16.0` Fastboot 固件包。

### 构建步骤

1. **初始化 ROM 源码**（以 LineageOS 22+ 或支持 Android 16 的 ROM 为例）：
    ```bash
    mkdir ~/android/lineage
    cd ~/android/lineage
    repo init -u https://github.com/LineageOS/android.git -b lineage-22.2  # 示例分支，请根据实际选择
    repo sync
    ```

2. **拉取官方内核源码**：
    ```bash
    mkdir -p kernel/xiaomi/manet
    # 替换 <soc> 和链接为实际的小米内核仓库（例如 sm8650）
    git clone -b bsp-manet-u-oss --single-branch https://github.com/MiCode/Xiaomi_Kernel_OpenSource.git kernel/xiaomi/manet
    ```
    > 如果小米尚未公开 manet 内核，请从设备提取 boot.img 并使用预编译内核（需在 BoardConfig.mk 中设置 TARGET_PREBUILT_KERNEL）。

3. **克隆本设备树到正确位置**：
    ```bash
    git clone https://github.com/yuanxing109/android_device_xiaomi_manet device/xiaomi/manet
    ```

4. **获取 Vendor 二进制文件（二选一）**：
    - **方式一：从固件提取（推荐）**  
      首先使用 `dumpyara` 解包 Fastboot ROM，然后运行提取脚本：
      ```bash
      cd device/xiaomi/manet
      ./extract-files.py /path/to/manet_dump/working/
      ```
    - **方式二：从专用 vendor 仓库克隆（如果有）**  
      ```bash
      git clone https://github.com/yuanxing109/proprietary_vendor_xiaomi_manet vendor/xiaomi/manet
      ```

5. **开始编译**：
    ```bash
    source build/envsetup.sh
    breakfast manet
    mka bacon
    ```

> **警告**：目前本项目仍处于早期阶段，使用前请做好数据备份。

## 如何贡献

欢迎任何形式的贡献！如果你感兴趣，可以：

1. 克隆本仓库 (`git clone https://github.com/yuanxing109/android_device_xiaomi_manet`)。
2. 创建你的特性分支 (`git checkout -b feature/AmazingFeature`)。
3. 提交你的更改 (`git commit -m 'Add some AmazingFeature'`)。
4. 将更改推送到分支 (`git push origin feature/AmazingFeature`)。
5. 提交一个 Pull Request。

## 致谢

- **LineageOS**：提供了构建底层的核心框架。
- **AOSP**：Android 开放源代码项目。
- **小米**：提供 HyperOS 3 和内核源码。
- **所有为 Redmi K70 Pro 提供适配思路的开发者**。

## 许可证

本设备树项目采用 Apache License 2.0 许可证发布，详情请参见 `LICENSE` 文件。
