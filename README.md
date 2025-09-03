# Robust-State-Estimation-for-Distribution-Systems

## 论文图表代码说明

本仓库包含论文中图表（Figure和Table）的生成代码，每个子文件夹对应论文中的一个特定图表。

### 文件夹结构

- **base/** - 本论文提出的状态估计方法（V-Fusion）的核心代码
- **FigIII/** - 对应论文中的 Figure III 生成代码
- **FigIV/** - 对应论文中的 Figure IV 生成代码
- **TableIII/** - 对应论文中的 Table III 生成代码
- **TableV/** - 对应论文中的 Table V 生成代码
- **TableVI/** - 对应论文中的 Table VI 生成代码
- **TableVII/** - 对应论文中的 Table VII 生成代码

### 使用说明

每个子文件夹中都包含一个 `main` 文件（或脚本），用于执行该图表的生成代码：

1. 进入特定图表对应的文件夹
2. 运行 `main.m` 文件
3. 程序将生成相应的图表结果

### 注意事项

- 请确保已安装所需的依赖的matpower和cvx

### 最后更新

所有代码最后更新于：2025年9月4日
