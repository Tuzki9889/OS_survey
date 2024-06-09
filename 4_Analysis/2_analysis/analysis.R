################### 中国人口学描述性统计 ###################

##### 前置工作

# 安装并加载必要的包
if (!requireNamespace("pacman", quietly = TRUE)) install.packages("pacman")
library(pacman)
p_load(ggplot2, dplyr, tidyr, likert, forcats, reshape2, papaja)

# 设置文件路径
input_cleaned_data <- "survey_of_open_science/3_RawData/2_clean_data/cleaned_survey_data.csv"
input_descriptive_stats <- "survey_of_open_science/3_RawData/2_clean_data/descriptive_statistics.csv"
output_figure_path <- "survey_of_open_science/3_RawData/2_clean_data/figure/"

# 加载数据
cleaned_data <- read.csv(input_cleaned_data)
descriptive_stats <- read.csv(input_descriptive_stats)

##### 中国人口学描述性统计

# 统计职业发展阶段（Q30）
career_stage_summary <- cleaned_data %>%
  group_by(Q30) %>%
  summarise(count = n()) %>%
  mutate(percentage = count / sum(count) * 100)

# 统计学科领域（Q33）
discipline_summary <- cleaned_data %>%
  group_by(Q33) %>%
  summarise(count = n()) %>%
  mutate(percentage = count / sum(count) * 100)

# 打印统计结果
print(career_stage_summary)
print(discipline_summary)

# 创建职业发展阶段环形图
career_stage_plot <- ggplot(career_stage_summary, aes(x = "", y = count, fill = Q30)) +
  geom_bar(width = 1, stat = "identity") +
  coord_polar(theta = "y") +
  theme_minimal() +
  labs(title = "中国样本职业发展阶段分布",
       fill = "职业发展阶段") +
  theme(axis.title.x = element_blank(),
        axis.title.y = element_blank(),
        panel.grid = element_blank(),
        axis.text.x = element_blank(),
        axis.ticks = element_blank()) +
  geom_text(aes(label = paste0(round(percentage, 1), "%")), 
            position = position_stack(vjust = 0.5))

# 创建学科领域环形图
discipline_plot <- ggplot(discipline_summary, aes(x = "", y = count, fill = Q33)) +
  geom_bar(width = 1, stat = "identity") +
  coord_polar(theta = "y") +
  theme_minimal() +
  labs(title = "中国样本学科领域分布",
       fill = "学科领域") +
  theme(axis.title.x = element_blank(),
        axis.title.y = element_blank(),
        panel.grid = element_blank(),
        axis.text.x = element_blank(),
        axis.ticks = element_blank()) +
  geom_text(aes(label = paste0(round(percentage, 1), "%")),
            position = position_stack(vjust = 0.5), 
            size = 3, color = "white") +
  theme(legend.position = "bottom") +
  guides(fill = guide_legend(nrow = 2, byrow = TRUE))

# 保存职业发展阶段环形图
ggsave(paste0(output_figure_path, "中国样本生涯分布.png"), plot = career_stage_plot, width = 8, height = 6, dpi = 300)

# 保存学科领域环形图
ggsave(paste0(output_figure_path, "中国样本学科分布.png"), plot = discipline_plot, width = 8, height = 6, dpi = 300)

# 创建数据框
efficiency_data <- data.frame(
  category = c("有效问卷", "无效问卷"),
  count = c(199, 610 - 199)
)

# 计算百分比
efficiency_data <- efficiency_data %>%
  mutate(percentage = count / sum(count) * 100)

# 打印数据框
print(efficiency_data)

# 创建条形图
efficiency_bar_plot <- ggplot(efficiency_data, aes(x = category, y = count, fill = category)) +
  geom_bar(stat = "identity") +
  theme_minimal() +
  labs(title = "中国数据问卷有效率",
       x = "问卷类别",
       y = "数量",
       fill = "类别") +
  geom_text(aes(label = paste0(round(percentage, 1), "%")), vjust = -0.5) +
  theme(legend.position = "none")

# 保存条形图
ggsave(paste0(output_figure_path, "中国数据问卷有效率.png"), plot = efficiency_bar_plot, width = 8, height = 6, dpi = 300)

################### 尼日利亚人口学描述性统计 ###################

# 加载尼日利亚数据
nigeria_data <- read.csv("survey_of_open_science/3_RawData/2_clean_data/r1_Nigeria_clean_data.csv")

# 统计职业发展阶段（Q30）
nigeria_career_stage_summary <- nigeria_data %>%
  group_by(Q30) %>%
  summarise(count = n()) %>%
  mutate(percentage = count / sum(count) * 100)

# 统计学科领域（Q32）
nigeria_discipline_summary <- nigeria_data %>%
  group_by(Q32) %>%
  summarise(count = n()) %>%
  mutate(percentage = count / sum(count) * 100)

# 打印统计结果
print(nigeria_career_stage_summary)
print(nigeria_discipline_summary)

# 创建职业发展阶段环形图
nigeria_career_stage_plot <- ggplot(nigeria_career_stage_summary, aes(x = "", y = count, fill = Q30)) +
  geom_bar(width = 1, stat = "identity") +
  coord_polar(theta = "y") +
  theme_minimal() +
  labs(title = "尼日利亚样本职业发展阶段分布",
       fill = "职业发展阶段") +
  theme(axis.title.x = element_blank(),
        axis.title.y = element_blank(),
        panel.grid = element_blank(),
        axis.text.x = element_blank(),
        axis.ticks = element_blank()) +
  geom_text(aes(label = paste0(round(percentage, 1), "%")), 
            position = position_stack(vjust = 0.5))

# 创建学科领域环形图
nigeria_discipline_plot <- ggplot(nigeria_discipline_summary, aes(x = "", y = count, fill = Q32)) +
  geom_bar(width = 1, stat = "identity") +
  coord_polar(theta = "y") +
  theme_minimal() +
  labs(title = "尼日利亚样本学科领域分布",
       fill = "学科领域") +
  theme(axis.title.x = element_blank(),
        axis.title.y = element_blank(),
        panel.grid = element_blank(),
        axis.text.x = element_blank(),
        axis.ticks = element_blank()) +
  geom_text(aes(label = paste0(round(percentage, 1), "%")),
            position = position_stack(vjust = 0.5), 
            size = 3, color = "white") +
  theme(legend.position = "bottom") +
  guides(fill = guide_legend(nrow = 2, byrow = TRUE))

# 保存职业发展阶段环形图
ggsave(paste0(output_figure_path, "尼日利亚样本生涯分布.png"), plot = nigeria_career_stage_plot, width = 8, height = 6, dpi = 300)

# 保存学科领域环形图
ggsave(paste0(output_figure_path, "尼日利亚样本学科分布.png"), plot = nigeria_discipline_plot, width = 8, height = 6, dpi = 300)

# 创建尼日利亚数据框
nigeria_efficiency_data <- data.frame(
  country = "尼日利亚",
  category = c("有效问卷", "无效问卷"),
  count = c(173, 557 - 173)
)

# 计算尼日利亚数据的百分比
nigeria_efficiency_data <- nigeria_efficiency_data %>%
  mutate(percentage = count / sum(count) * 100)

# 创建条形图函数
create_bar_plot <- function(data, title, file_path) {
  plot <- ggplot(data, aes(x = category, y = count, fill = category)) +
    geom_bar(stat = "identity") +
    theme_minimal() +
    labs(title = title,
         x = "问卷类别",
         y = "数量",
         fill = "类别") +
    geom_text(aes(label = paste0(round(percentage, 1), "%")), vjust = -0.5) +
    theme(legend.position = "none")
  
  ggsave(file_path, plot = plot, width = 8, height = 6, dpi = 300)
}

create_bar_plot(nigeria_efficiency_data, "尼日利亚数据问卷有效率", paste0(output_figure_path, "尼日利亚数据问卷有效率.png"))

################### Likert题型 ###################

# 问题描述映射
question_labels <- c(
  "Q5_5" = "对开放代码的态度",
  "Q5_4" = "对开放数据的态度",
  "Q5_7" = "对开放获取的态度",
  "Q5_8" = "对开放同行评审的态度",
  "Q5_3" = "对重复性研究的态度",
  "Q5_6" = "对预印本的态度",
  "Q5_2" = "对注册报告的态度",
  "Q5_1" = "对预注册的态度",
  "Q7_5" = "开放代码的意向",
  "Q7_4" = "开放数据的意向",
  "Q7_7" = "开放获取的意向",
  "Q7_8" = "开放同行评审的意向",
  "Q7_3" = "重复性研究的意向",
  "Q7_6" = "预印本的意向",
  "Q7_2" = "注册报告的意向",
  "Q7_1" = "预注册的意向"
)

# 选择数据并修改列名
likert_data <- nigeria_data %>%
  select(starts_with("Q5_"), starts_with("Q7_")) %>%
  rename_with(~ question_labels[.], everything())

# 确保所有列都转换为因子，并具有相同的水平
# 修改因子级别，将尼日利亚数据的英文标签映射到统一描述
english_levels <- c("Strongly disagree", "Disagree", "Neutral", "Agree", "Strongly agree")
chinese_levels <- c("非常反对/意向非常低", "比较反对/意向较低", "中立", "比较认同/意向较高", "非常认同/意向非常高")

likert_data_processed <- likert_data %>%
  mutate(across(everything(), ~ factor(.x, levels = english_levels, labels = chinese_levels)))

# 检查转换后的数据结构和前几行
str(likert_data_processed)
head(likert_data_processed)

# 分析Likert数据
likert_results <- likert(likert_data_processed)

# 可视化
png(paste0(output_figure_path, "likert_chart_nigeria.png"), width = 2000, height = 1500, res = 220)

plot <- plot(likert_results) +
  labs(
    title = "尼日利亚样本 Likert 量表结果",  # 图表标题
    x = "项目",                               # X轴标签
    y = "百分比",                             # Y轴标签
    fill = "评分等级"                          # 图例标题
  ) +
  papaja::theme_apa()

print(plot)
dev.off()

################### 单选题统计分析 ###################

single_choice_data <- descriptive_stats %>%
  filter(Statistic == 'Frequency & Percentage') %>%
  mutate(Question = factor(Question))

single_choice_data$Question <- as.factor(single_choice_data$Question)

# 为每个单选题生成一个独立的图表
unique_questions <- unique(single_choice_data$Question)

for (question in unique_questions) {
  # 过滤出当前迭代的题目数据
  question_data <- filter(single_choice_data, Question == question)
  
  # 生成图表
  p <- ggplot(question_data, aes(x = Option, y = Frequency, fill = Option)) +
    geom_bar(stat = "identity") +
    labs(title = paste("Question:", question), x = "Option", y = "Frequency") +
    theme_minimal() +
    theme(axis.text.x = element_text(angle = 45, hjust = 1),
          legend.position = "none")  # 如果选项名字足够表达意思，可以选择不显示图例
  
  # 显示图表
  print(p)
}

################### 多选题统计分析 ###################

multi_choice_columns <- c("Q4", "Q8", "Q9", "Q10", "Q11", "Q12", "Q13", "Q14", "Q18", "Q19")

# 将每个多选题的响应分解为多行
multi_choice_data_long <- cleaned_data %>%
  select(multi_choice_columns) %>%
  pivot_longer(cols = everything(), names_to = "Question", values_to = "Options") %>%
  separate_rows(Options, sep = ",") %>%
  group_by(Question, Options) %>%
  summarize(Count = n(), .groups = 'drop')

# 查看处理后的数据
head(multi_choice_data_long)

# 为每个多选题生成图表
unique_questions <- unique(multi_choice_data_long$Question)

for (question in unique_questions) {
  question_data <- filter(multi_choice_data_long, Question == question)
  
  p <- ggplot(question_data, aes(x = Options, y = Count, fill = Options)) +
    geom_bar(stat = "identity") +
    labs(title = paste("Question:", question), x = "Options", y = "Count of selections") +
    theme_minimal() +
    theme(axis.text.x = element_text(angle = 45, hjust = 1),
          legend.position = "none")
  
  print(p)
}

# Q4
# 清洗数据：删除选项中的换行符，并过滤掉我们不想包括的选项 ("0-" 和 "AnswerDisplayOrder")
Q4_data_clean <- multi_choice_data_long %>%
  filter(Question == "Q4" & !grepl("^0-|AnswerDisplayOrder", Options)) %>%
  mutate(Options = gsub("\n", " ", Options)) # 将换行符替换为空格

# 打印出清洗后的唯一选项值，确保它们看起来正确
unique_options <- unique(Q4_data_clean$Options)
print(unique_options)

# 根据你的需要创建新的标签映射
Q4_option_labels <- setNames(
  c("预注册", "注册报告", "重复性研究", "开放数据", "开放代码", "预印本", "开放获取", "开放同行评审"), # 新标签
  unique_options # 清洗后的唯一选项值
)

# 使用映射来更新数据中的选项标签
Q4_data_labeled <- Q4_data_clean %>%
  mutate(Options = factor(Options, levels = unique_options, labels = Q4_option_labels))

# 绘制条形图
ggplot(Q4_data_labeled, aes(x = Options, y = Count)) +
  geom_bar(stat = "identity", fill = "steelblue") +
  theme_minimal() +
  labs(title = "Q4选项分布情况", x = "选项", y = "频数") +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))

################### Q4 * Q33分析 ###################

# 筛选出心理学相关的行并进行清洗
psychology_data <- cleaned_data %>%
  filter(Q33 == "心理学（心理学直接选择此项）") %>%
  select(Q33, Q4) %>%
  separate_rows(Q4, sep = ",") %>%
  filter(!grepl("^0-|AnswerDisplayOrder", Q4)) %>%
  mutate(Q4 = gsub("\n", " ", Q4))

# 更新psychology_data中的Q4选项标签
psychology_data <- psychology_data %>%
  mutate(Q4 = factor(Q4, levels = unique_options, labels = Q4_option_labels))

# 计算心理学领域每个Q4选项的计数
psychology_Q4_count <- psychology_data %>%
  count(Q4, name = "Count_psychology")

# 合并总体Q4数据和心理学领域Q4数据
combined_Q4_data <- Q4_data_labeled %>%
  full_join(psychology_Q4_count, by = c("Options" = "Q4"))

# 计算每个Q4选项的总选择次数占总人数的百分比
combined_Q4_data <- combined_Q4_data %>%
  mutate(Percentage = paste(Count, " (", round((Count / 199) * 100, 1), "%)", sep = ""))

# 创建堆叠条形图，并在每个柱子上显示了解该实践的人数和百分比
ggplot(combined_Q4_data, aes(x = Options)) +
  geom_bar(aes(y = Count, fill = "总体"), stat = "identity") +
  geom_bar(aes(y = Count_psychology, fill = "心理学"), stat = "identity") +
  geom_text(aes(y = ifelse(Count < 50, 50, Count), label = Percentage), 
            position = position_stack(vjust = 1.02), 
            color = "black", size = 4) +
  scale_fill_manual(values = c("总体" = "lightblue", "心理学" = "steelblue"),
                    labels = c("总体" = "全部学科", "心理学" = "心理学")) +
  theme_minimal() +
  labs(title = "中国研究者对开放科学各实践的了解", x = "开放科学实践类型", y = "知道含义的人数", fill = "学科") +
  theme(axis.text.x = element_text(angle = 45, hjust = 1)) +
  guides(fill = guide_legend(reverse = TRUE)) +
  coord_cartesian(ylim = c(50, max(combined_Q4_data$Count + 10))) +  # 设置纵轴显示范围
  papaja::theme_apa()

ggsave(paste0(output_figure_path, "combined_Q4_distribution.png"), width = 12, height = 8, dpi = 300)

################### Likert题型 ###################

# 问题描述映射
question_labels <- c(
  "Q5_5" = "对开放代码的态度",
  "Q5_4" = "对开放数据的态度",
  "Q5_7" = "对开放获取的态度",
  "Q5_8" = "对开放同行评审的态度",
  "Q5_3" = "对重复性研究的态度",
  "Q5_6" = "对预印本的态度",
  "Q5_2" = "对注册报告的态度",
  "Q5_1" = "对预注册的态度",
  "Q7_5" = "开放代码的意向",
  "Q7_4" = "开放数据的意向",
  "Q7_7" = "开放获取的意向",
  "Q7_8" = "开放同行评审的意向",
  "Q7_3" = "重复性研究的意向",
  "Q7_6" = "预印本的意向",
  "Q7_2" = "注册报告的意向",
  "Q7_1" = "预注册的意向"
)

# 选择数据并修改列名
likert_data <- cleaned_data %>%
  select(starts_with("Q5_"), starts_with("Q7_")) %>%
  rename_with(~ question_labels[.], everything())

# 确保所有列都转换为因子，并具有相同的水平
# 修改因子级别，将数字替换为描述
levels_desc <- c("非常反对/意向非常低", "比较反对/意向较低", "中立", "比较认同/意向较高", "非常认同/意向非常高")

likert_data_processed <- likert_data %>%
  mutate(across(everything(), ~ factor(.x, levels = c("1", "2", "3", "4", "5"), labels = levels_desc)))

# 分析Likert数据
likert_results <- likert(likert_data_processed)

# 可视化
png(paste0(output_figure_path, "likert_chart.png"), width = 2000, height = 1500, res = 220)

plot <- plot(likert_results) +
  labs(
    title = "Likert 量表结果",          # 图表标题
    x = "项目",                         # X轴标签
    y = "百分比",                       # Y轴标签
    fill = "评分等级"                    # 图例标题
  ) +
  papaja::theme_apa()

print(plot)

dev.off()

################### 相关性分析 ###################

# 选择数据并确保数据为数值型
likert_data_numeric <- cleaned_data %>%
  select(starts_with("Q5_"), starts_with("Q7_")) %>%
  mutate(across(everything(), as.numeric))

# 检查是否有NA值，如果有，则需要决定如何处理它们
# 例如，你可以选择删除含有NA值的行或进行插值

# 计算态度（Q5_）和实践意向（Q7_）之间的Spearman相关性
correlation_matrix <- cor(likert_data_numeric[, grep("Q5_", names(likert_data_numeric))], 
                          likert_data_numeric[, grep("Q7_", names(likert_data_numeric))], 
                          use = "pairwise.complete.obs", 
                          method = "spearman")

# 查看相关性矩阵
print(correlation_matrix)

# 定义新的标签
new_labels <- c(
  "Q5_5" = "对开放代码的态度",
  "Q5_4" = "对开放数据的态度",
  "Q5_7" = "对开放获取的态度",
  "Q5_8" = "对开放同行评审的态度",
  "Q5_3" = "对重复性研究的态度",
  "Q5_6" = "对预印本的态度",
  "Q5_2" = "对注册报告的态度",
  "Q5_1" = "对预注册的态度",
  "Q7_5" = "开放代码的意向",
  "Q7_4" = "开放数据的意向",
  "Q7_7" = "开放获取的意向",
  "Q7_8" = "开放同行评审的意向",
  "Q7_3" = "重复性研究的意向",
  "Q7_6" = "预印本的意向",
  "Q7_2" = "注册报告的意向",
  "Q7_1" = "预注册的意向"
)

# 更新相关性矩阵的行名和列名
rownames(correlation_matrix) <- new_labels[rownames(correlation_matrix)]
colnames(correlation_matrix) <- new_labels[colnames(correlation_matrix)]

# 转换为长格式
correlation_data_melted <- melt(correlation_matrix)

# 绘制热图
heatmap_plot <- ggplot(correlation_data_melted, aes(x = Var2, y = Var1, fill = value)) +
  geom_tile() +
  scale_fill_gradient2(low = "blue", high = "red", mid = "white", midpoint = 0, 
                       limits = c(-0.6, 0.6), space = "Lab", 
                       name="Spearman\nCorrelation",
                       breaks = c(-0.6, -0.3, 0, 0.3, 0.6)) +  # 强制显示-0.6, 0, 0.6
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 45, vjust = 1, hjust = 1),
        axis.text.y = element_text(angle = 0), 
        axis.title = element_blank(),
        legend.position = "right") +  # 确保图例在右侧
  labs(fill = "Correlation") +
  papaja::theme_apa() +
  theme(axis.text.x = element_text(angle = 90, vjust = 0.5, hjust = 1),
        axis.text.y = element_text(angle = 0), 
        axis.title = element_blank(),
        plot.margin = unit(c(1, 1, 1, 1), "lines"))  # 可以调整图表边距

ggsave(paste0(output_figure_path, "heatmap_plot.png"), heatmap_plot, width = 10, height = 8, dpi = 300)

################### 滑块题型统计分析 ###################

# 获取所有滑块题型列
slider_columns <- grep("^Q.*_", names(cleaned_data), value = TRUE)

# 首先，转换所有滑块题型数据为字符类型以避免数据类型不一致问题
slider_data_prepared <- cleaned_data %>%
  mutate(across(all_of(slider_columns), as.character))

# 对每个大题单独处理并生成图表
for (col in slider_columns) {
  # 选取当前大题的数据，并将其转换为长格式
  current_data <- slider_data_prepared %>%
    select(Question = col) %>%
    na.omit() %>%  # 移除NA值，以防它们干扰图表的生成
    pivot_longer(cols = everything(), names_to = "Question", values_to = "Value")
  
  # 将Value列的值转换为数值类型，以便绘图
  current_data$Value <- as.numeric(current_data$Value)
  
  # 使用ggplot生成直方图
  p <- ggplot(current_data, aes(x = Value)) + 
    geom_histogram(binwidth = 1, fill = "blue", color = "black") +
    labs(title = paste("Distribution for", col), x = "Value", y = "Count") +
    theme_minimal() +
    theme(axis.text.x = element_text(angle = 45, hjust = 1))
  
  # 打印当前大题的图表
  print(p)
}
