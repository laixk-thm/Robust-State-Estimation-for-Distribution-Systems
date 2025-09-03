import numpy as np
import matplotlib.pyplot as plt
from scipy.io import loadmat

# 加载数据
# mat_data = loadmat('case4_mae136_modified.mat')
mat_V_res = loadmat('V_res.mat')
mat_data = loadmat('Sm_Y_k.mat')

# 提取数据
# index = [17, 22, 24, 31, 35, 38, 39, 45, 51,
#          56, 70, 75, 85, 116, 121, 127, 129, 136]
index = [16, 21, 23, 30, 34, 37, 38, 44, 50,
         55, 69, 74, 84, 115, 120, 126, 128, 135]
V_res = mat_V_res['V_res']
# V2_res = mat_data['V2_res']
# Vmat_res = mat_data['Vmat_res']
V2_res = mat_data['V_Fusion']
Vmat_res = mat_data['V_Approx']

# 计算指标
V_index = np.abs(V_res[index, :])
V2_index = V2_res[index, :]
Vmat_index = Vmat_res[index, :]

V2_acc = np.abs(V2_index - V_index) / V_index
Vmat_acc = np.abs(Vmat_index - V_index) / V_index

# 转换为log10
log_V2_acc = np.log10(V2_acc.T)
log_Vmat_acc = np.log10(Vmat_acc.T)

# 创建图形
plt.figure(figsize=(12, 6))

# 绘制箱线图 - 蓝色边框
bp1 = plt.boxplot(
    log_V2_acc,
    positions=np.arange(1, len(index)+1),
    widths=0.3,
    patch_artist=True,
    boxprops=dict(facecolor='none', color='blue', linewidth=1.5),
    whiskerprops=dict(color='blue', linewidth=1.5),
    capprops=dict(color='blue', linewidth=1.5),
    medianprops=dict(color='blue', linewidth=1.5),
    flierprops=dict(marker='None')
)

# 绘制箱线图 - 红色边框（透明填充）
bp2 = plt.boxplot(
    log_Vmat_acc,
    positions=np.arange(1, len(index)+1),
    widths=0.3,
    patch_artist=True,
    boxprops=dict(facecolor='none', color='red', linewidth=1.5),
    whiskerprops=dict(color='red', linewidth=1.5),
    capprops=dict(color='red', linewidth=1.5),
    medianprops=dict(color='red', linewidth=1.5),
    flierprops=dict(marker='None')
)

plt.axhline(y=-1, color='gray', linestyle='--', linewidth=1, alpha=0.7)
plt.axhline(y=-2, color='gray', linestyle='--', linewidth=1, alpha=0.7)
plt.axhline(y=-3, color='gray', linestyle='--', linewidth=1, alpha=0.7)
plt.axhline(y=-4, color='gray', linestyle='--', linewidth=1, alpha=0.7)
plt.axhline(y=-5, color='gray', linestyle='--', linewidth=1, alpha=0.7)

# 设置坐标轴标签
plt.xlabel('DERs Locations Index', fontname='Times New Roman', fontsize=11)
plt.ylabel('Log10-MAE of voltage Magnitude',
           fontname='Times New Roman', fontsize=11)

# 设置x轴刻度
plt.xticks(np.arange(1, len(index)+1), [str(i+1) for i in index])

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
plt.legend([bp1["boxes"][0], bp2["boxes"][0]], [
           'G-Fusion', 'P-Base'], loc='upper right')

plt.tight_layout()
plt.show()
