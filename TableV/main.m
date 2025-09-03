% case3 异常准确率绘制

% mae1:非滑动窗口、mae2：滑动窗口

alpha = [4,5,6,7,8];
alpha_136 = [6,8,10,12,14];
num_times = 500;%循环500轮

% % %case85
% recall_85 = [];
% f1_85 = [];
% % case51
% for i = 1:length(alpha)
%     recall_85_alpha = zeros(1,2);
%     f1_85_alpha = zeros(1,2); 
%     for times = 1:num_times
%         [recall_85_tmp,f1_85_tmp] = IEEE_func_case85(alpha(i));
%         recall_85_alpha = recall_85_alpha + recall_85_tmp;
%         f1_85_alpha = f1_85_alpha + f1_85_tmp;
%     end
%     recall_85 = [recall_85;recall_85_alpha./num_times];
%     f1_85 = [f1_85;f1_85_alpha./num_times];
% end

% %case85
recall_136 = [];
f1_136 = [];
% case51
for i = 1:length(alpha_136)
    recall_136_alpha = zeros(1,2);
    f1_136_alpha = zeros(1,2); 
    for times = 1:num_times
        [recall_136_tmp,f1_136_tmp] = IEEE_func_case136ma(alpha_136(i));
        recall_136_alpha = recall_136_alpha + recall_136_tmp;
        f1_136_alpha = f1_136_alpha + f1_136_tmp;
    end
    recall_136 = [recall_136;recall_136_alpha./num_times];
    f1_136 = [f1_136;f1_136_alpha./num_times];
end