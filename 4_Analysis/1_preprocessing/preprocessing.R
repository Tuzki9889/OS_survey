########## 对原始数据的预处理 ##########

##### 前置工作

# 加载包
if (!requireNamespace("pacman", quietly = TRUE)) install.packages("pacman")
library(pacman)
p_load(psych, tidyverse, writexl, readxl, openxlsx, readr)

# 设置文件路径
input_file <- "C:/Users/YourUsername/survey_of_open_science/3_RawData/1_raw_data/1_china/r1_raw_data.csv"
output_file <- "C:/Users/YourUsername/survey_of_open_science/3_RawData/1_raw_data/1_china/r1_raw_data.csv"

# 读取数据
r1_raw_data <- read_csv(input_file,
                        col_names = TRUE,
                        skip = 1,
                        locale = locale(encoding = "GB2312"))

##### 筛选

# 删除题目，保留参与者数据
r1_raw_data <- r1_raw_data %>%
  slice(-c(1, 2))

# 查看当前的列名
colnames(r1_raw_data)

# 筛选同意知情同意书的参与者
r1_raw_data <- r1_raw_data %>%
  filter(Q2 == "好的，我已知情" & Q3 == "好的，我已知情")

# 筛选注意力检测通过了的参与者
r1_raw_data <- r1_raw_data %>%
  filter(Q16 == "1- 非常不愿意")

# 筛选最后一题必答题完成了的参与者
r1_raw_data <- r1_raw_data %>%
  filter(!is.na(Q33) & nzchar(Q33))

##### 重新编码

# 整理所有李克特五分量表的题目
Likert5_cols <- c("Q5_1", "Q5_2", "Q5_3", "Q5_4", "Q5_5", "Q5_6", "Q5_7", "Q5_8",
                  "Q7_1", "Q7_2", "Q7_3", "Q7_4", "Q7_5", "Q7_6", "Q7_7", "Q7_8",
                  "Q15", "Q17")

# 创建重新编码函数
recode_likert <- function(column) {
  case_when(
    column %in% c("1- 非常反对", "1- 概率非常低", "1- 非常不愿意", "1- 非常困难") ~ 1,
    column %in% c("2- 比较反对", "2- 概率较低", "2- 比较不愿意", "2- 比较困难") ~ 2,
    column %in% c("3- 中立", "3- 中等", "3- 中立", "3- 中等") ~ 3,
    column %in% c("4- 比较认同", "4- 概率较高", "4- 比较愿意", "4- 比较容易") ~ 4,
    column %in% c("5- 非常认同", "5- 概率非常高", "5- 非常愿意", "5- 非常容易") ~ 5,
    TRUE ~ NA_real_ # 对于不匹配的情况赋予NA
  )
}

# 应用重新编码函数
r1_raw_data <- r1_raw_data %>%
  mutate(across(all_of(Likert5_cols), recode_likert))

##### 输出

# 将清理后的数据保存到指定路径
write_csv(r1_raw_data, output_file)
