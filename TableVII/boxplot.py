import numpy as np
import matplotlib.pyplot as plt
from scipy.io import loadmat

# 加载数据
# mat_V_res = loadmat('V_res.mat')
# mat_G_SW = loadmat('V_G_SW_res.mat')
# mat_G_FO = loadmat('V_G_FO_res.mat')
# mat_G_BO = loadmat('V_G_BO_res.mat')
# mat_G_VO = loadmat('V_G_VO_res.mat')
mat_V = loadmat("mat_V.mat")

# 提取数据
index = [9, 12, 13, 47, 60, 70, 78, 82]  # 更新索引
V_res = mat_V['V_res']
V_G_SW_res = mat_V['V_G_SW_res']
V_G_FO_res = mat_V['V_G_FO_res']
V_G_BO_res = mat_V['V_G_BO_res']
V_G_VO_res = mat_V['V_G_VO_res']

# 计算指标
V_index = np.abs(V_res[index, :])
V_SW_index = V_G_SW_res[index, :]
V_FO_index = V_G_FO_res[index, :]
V_BO_index = V_G_BO_res[index, :]
V_VO_index = V_G_VO_res[index, :]

# 计算相对误差
V_SW_acc = np.abs(V_SW_index - V_index) / V_index
V_FO_acc = np.abs(V_FO_index - V_index) / V_index
V_BO_acc = np.abs(V_BO_index - V_index) / V_index
V_VO_acc = np.abs(V_VO_index - V_index) / V_index

# 转换为log10
log_V_SW_acc = np.log10(V_SW_acc.T)
log_V_FO_acc = np.log10(V_FO_acc.T)
log_V_BO_acc = np.log10(V_BO_acc.T)
log_V_VO_acc = np.log10(V_VO_acc.T)

# 创建图形
plt.figure(figsize=(12, 6))

# 定义颜色和标签
colors = ['blue', 'red', 'green', 'orange']
labels = ['G-SW', 'G-FO', 'G-BO', 'G-VO']

# 绘制四个箱线图
positions = np.arange(1, len(index)+1)
width = 0.2  # 调整宽度以适应四个箱线图

# 第一个箱线图 - 蓝色
bp1 = plt.boxplot(
    log_V_SW_acc,
    positions=positions,
    widths=width,
    patch_artist=True,
    boxprops=dict(facecolor='none', color=colors[0], linewidth=1.5),
    whiskerprops=dict(color=colors[0], linewidth=1.5),
    capprops=dict(color=colors[0], linewidth=1.5),
    medianprops=dict(color=colors[0], linewidth=1.5),
    flierprops=dict(marker='None')
)

# 第二个箱线图 - 红色
bp2 = plt.boxplot(
    log_V_FO_acc,
    positions=positions,
    widths=width,
    patch_artist=True,
    boxprops=dict(facecolor='none', color=colors[1], linewidth=1.5),
    whiskerprops=dict(color=colors[1], linewidth=1.5),
    capprops=dict(color=colors[1], linewidth=1.5),
    medianprops=dict(color=colors[1], linewidth=1.5),
    flierprops=dict(marker='None')
)

# 第三个箱线图 - 绿色
bp3 = plt.boxplot(
    log_V_BO_acc,
    positions=positions,
    widths=width,
    patch_artist=True,
    boxprops=dict(facecolor='none', color=colors[2], linewidth=1.5),
    whiskerprops=dict(color=colors[2], linewidth=1.5),
    capprops=dict(color=colors[2], linewidth=1.5),
    medianprops=dict(color=colors[2], linewidth=1.5),
    flierprops=dict(marker='None')
)

# 第四个箱线图 - 橙色
bp4 = plt.boxplot(
    log_V_VO_acc,
    positions=positions,
    widths=width,
    patch_artist=True,
    boxprops=dict(facecolor='none', color=colors[3], linewidth=1.5),
    whiskerprops=dict(color=colors[3], linewidth=1.5),
    capprops=dict(color=colors[3], linewidth=1.5),
    medianprops=dict(color=colors[3], linewidth=1.5),
    flierprops=dict(marker='None')
)

# 添加水平参考线
for y_val in [-1, -2, -3, -4, -5]:
    plt.axhline(y=y_val, color='gray', linestyle='--', linewidth=1, alpha=0.7)

# 设置坐标轴标签
plt.xlabel('DERs Locations Index', fontname='Times New Roman', fontsize=11)
plt.ylabel('Log10-MAE of voltage Magnitude',
           fontname='Times New Roman', fontsize=11)

# 设置x轴刻度
plt.xticks(positions, [str(i) for i in index])

# 设置图形样式
ax = plt.gca()
ax.set_ylim(-5, -0.5)
ax.grid(False)
ax.tick_params(axis='both', which='major', direction='in', length=6, width=1,
               colors='black', labelsize=10)
ax.spines['top'].set_visible(True)
ax.spines['right'].set_visible(True)
ax.spines['bottom'].set_visible(True)
ax.spines['left'].set_visible(True)
ax.spines[:].set_linewidth(1)
ax.spines[:].set_color('black')

# 设置字体
plt.rcParams['font.family'] = 'Times New Roman'

# 添加图例
plt.legend([bp1["boxes"][0], bp2["boxes"][0], bp3["boxes"][0], bp4["boxes"][0]],
           labels, loc='upper right')

plt.tight_layout()
plt.show()
