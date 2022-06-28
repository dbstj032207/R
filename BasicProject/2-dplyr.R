install.packages("dplyr")
library(dplyr)

# 데이터 준비
exam <- read.csv("../data/csv_exam.csv")
exam



##### filter() #####

# 1반 학생들의 데이터 추출
exam[exam["class"] == "1", ]
exam[exam$"class" == "1", ]

subset(exam, class == "1")

filter(exam, class == "1")

exam %>% filter(class == "1")


# 2반이면서 영어점수가 80점 이상인 데이터 추출
exam[exam$class == 2 & exam$english >= 80, ]
exam %>% filter(class==2 & english >= 80)

# 1, 3, 5에 해당하는 데이터만 추출
filter(exam, class %in% c(1, 3, 5))


##### select() #####
# 수학점수만 추출
exam[,3]
exam["math"]
exam %>% select(math)

# 반, 수학, 영어점수 추출
exam[, c("class", "math", "english")]
exam %>% select(class, math, english)


# 수학점수를 제외한 나머지 칼럼 추출
exam %>% select(-math)

# 1반 학생들의 수학점수만 추출(2명만 표시)
# select class, math from exam where class = 1 and rownum < 3
# select class, math from exam where class = 1 and limit 2

exam %>% filter(class == 1) %>% select(class, math) %>% head(2)


# mpg데이터
install.packages("ggplot2")
library(ggplot2)
mpg <- ggplot2::mpg
mpg

##### arrange() #####
exam %>% arrange(math)
exam %>% arrange(desc(math))
exam %>% arrange(class, math)


##### mutate() #####
exam$sum <- exam$math + exam$english + exam$science
exam

exam$mean <- exam$sum / 3
exam

exam <- exam[, -c(6, 7)]
exam

exam %>% mutate(sum = math + english + science)

exam


##### summarize() #####
exam %>% summarise(mean_math=mean(math), mean_eng=mean(english))


##### group_by() #####
exam %>% group_by(class) %>% summarise(mean_math=mean(math), mean_eng=mean(english),
                                       median_math=median(math), count = n())

##### left_join(), bind_rows() #####
test1 <- data.frame(id = c(1, 2, 3, 4, 5), midterms = c(60, 70, 80, 90, 85))
test2 <- data.frame(id = c(1, 2, 3, 4, 5), midterms = c(70, 83, 65, 95, 80))

left_join(test1, test2, by="id")
bind_rows(test1, test2)

##### 실습 #####
mpg <- as.data.frame(mpg)
mpg

head(mpg)
tail(mpg)
str(mpg)
names(mpg)
dim(mpg)
View(mpg)

### 배기량(displ)이 4이하인 차량의 모델명, 배기량, 생산년도를 조회
mpg %>% filter(displ <= 4) %>% select(model, displ, year)

### 통합 연비 파생변수를 만들기(total)
### 통합연비 : (ctr + hwy) / 2
### 통합연비로 내림차순 정렬한 뒤에 뒤에서 3개의 행만 선택해서 조회
mpg1 <- mpg %>% mutate(total = (cty+hwy)/2) %>% arrange(desc(total))
mpg1 %>% head(3)


### 회사별로 "suv"차량의 도시 및 고속도로 통합연비로 평균을 구해 
### 내림차순으로 정렬하고 1~5위까지 조회
mpg %>% 
    group_by(manufacturer) %>%
    filter(class == "suv") %>%
    summarise(mean_total=(cty+hwy)/2) %>% 
    arrange(desc(mean_total)) %>%
    head(5)
  
### 어떤 회사의 hwy연비가 가장 높은지 알아보려고 한다. 
### hwy평균이 가장 높은 회사 세곳을 조회
mpg %>% 
  group_by(manufacturer) %>%
  summarise(mean_hwy=mean(hwy)) %>% 
  arrange(desc(mean_hwy)) %>%
  head(3)

### 어떤 회사에서 compact(경차) 차종을 가장 많이 생산하는지 알아보려고 한다.
### 각 회사별 경차 차종 수를 내림차순으로 조회
mpg %>% 
  group_by(manufacturer) %>%
  filter(class == "compact") %>%
  summarise(count = n()) %>% 
  arrange(desc(count)) %>%
  head(5)

### 연료별 가격을 구해서 새로운 데이터프레임(fuel)으로 만든 후 
### 기존 데이터셋(mpg)와 병합하여 조회
### c:CNG=2.35, d:Disel=2.38, e=Ethanol=2.11, p:Premium=2.76, r:Regular=2.22
unique(mpg$fl)

fuel <- data.frame(fl = c("p", "r", "e", "d", "c"), 
                   price_fl=c(2.76, 2.22, 2.11, 2.38, 2.35))
fuel

mpg_fl <- left_join(mpg, fuel, by="fl")
mpg_fl

### 통합연비의 기준치를 통해 합격(pass) / 불합격(fail)을 부여하여 test라는 이름의 파생변수 추가

mpg1$test <- ifelse(mpg1$total >= 20, "pass", "fail")
mpg1

mpg1 %>% mutate(test2 = case_when(total < 20 ~ "fail", total >= 20 ~ "pass"))


### 통합연비 등급을 A, B, C 세 등급으로 나누는 파생변수 추가(grade)
### 30이상이면 A, 20~29이면 B, 20미만이면 C등급으로 분류
mpg1$grade <- ifelse(mpg1$total >= 30, "A", ifelse(mpg1$total>=20, "B", "C"))
mpg1


mpg1$grade <- case_when(mpg1$total >= 30 ~ "A", 
                        mpg1$total >= 20 ~ "B", 
                        mpg1$total <10 ~ "C")
mpg1





