
% ---------------plot------------------
% 定义线上点的x坐标
x = 0.1:0.1:1;
% 分别定义不同线条上点的y坐标
log_mae85 = 0.1*log(mae85);
log_mae136 = 0.1*log(mae136);
samp1 = log_mae85(:,1);
samp2 = log_mae85(:,2);
samp3 = log_mae85(:,3);
samp4 = log_mae136(:,1);
samp5 = log_mae136(:,2);
samp6 = log_mae136(:,3);

% 绘制颜色
C3 = [0.89,0.09,0.05];
C6 = [0.89,0.09,0.05];
C1 = [0.996, 0.701, 0.298];
C4 = [0.996, 0.701, 0.298];
C2 = [0.24,0.35,0.67];
C5 = [0.24,0.35,0.67];

% 线条绘制
Line1 = line(x,samp1);
Line2 = line(x,samp2);
Line3 = line(x,samp3);
Line4 = line(x,samp4);
Line5 = line(x,samp5);
Line6 = line(x,samp6);

% 定义线型、标记符号、线宽和颜色
set(Line1, 'LineStyle', '--','Marker', 'o','LineWidth', 1,  'Color', C1)
set(Line2, 'LineStyle', '--','Marker', 'o','LineWidth', 1,  'Color', C2)
set(Line3, 'LineStyle', '--','Marker', 'o','LineWidth', 1,  'Color', C3)
set(Line4, 'LineStyle', '--','Marker', 'v','LineWidth', 1,  'Color', C4)
set(Line5, 'LineStyle', '--','Marker', 'v','LineWidth', 1,  'Color', C5)
set(Line6, 'LineStyle', '--','Marker', 'v','LineWidth', 1,  'Color', C6)
set(gca, 'Box', 'off', ...                                % 边框
         'XGrid', 'off', 'YGrid', 'on', ...               % 网格
         'TickDir', 'out', 'TickLength', [.01 .01], ...   % 刻度
         'XMinorTick', 'off', 'YMinorTick', 'off', ...    % 小刻度
         'XColor', [.1 .1 .1],  'YColor', [.1 .1 .1],...  % 坐标轴颜色
         'XTick', 0:0.1:1, ...                          % X刻度位置、间隔 (11个)
         'YTick', -0.6:0.1:-0.1, ...                    % Y刻度位置、间隔 (6个: -0.6, -0.5, ..., -0.1)
         'Xlim' , [0 1.1], ...
         'Ylim' , [-0.6 -0.1], ...                       % 坐标轴范围
         'Xticklabel', 0:10:100, ...                    % X坐标轴刻度标签 (11个)
         'Yticklabel', {'-0.6', '-0.5', '-0.4', '-0.3', '-0.2', '-0.1'}) % Y坐标轴刻度标签 (6个)
% X、Y轴标签及Legend
hXLabel = xlabel('Percent of Total Bus');
hYLabel = ylabel('0.1 \times log10-Voltage Magnitude Error (p.u.)');
hLegend = legend([Line1,Line2,Line3,Line4,Line5,Line6], ...
                 'G-Fusion-case85', 'G-Volt-case85','G-Base-case85','G-Fusion-case136ma','G-Volt-case136ma','G-Base-case136ma', ...
                 'Location', 'northwest');
% 刻度标签字体和字号
set(gca, 'FontName', 'Times New Roman', 'FontSize', 9)
% X、Y轴标签及Legend的字体字号 
set([hXLabel, hYLabel,hLegend], 'FontName',  'Times New Roman')
set([hXLabel, hYLabel,hLegend], 'FontSize', 10)
% 背景颜色
set(gca,'Color',[1 1 1])


