##### one samplet t-test #####

### A회사의 건전지 수명이 1000시간일때, 무작위로 뽑아 10개의 건전지 수명에 대해
### 샘플이 모집단과 다르다고 할 수 있는가?

# 귀무가설 : 표본의 평균은 모집단의 평균과 같다.
# 대립가설 : 표본의 평균은 모집단의 평균과 다르다.

a <- c(980, 1008, 968, 1032, 1012, 1002, 996, 1017, 990, 955)

mean.a <- mean(a)
mean.a

t.test(a, mu=1000, alt="less")
t.test(a, mu=1000, alt="greater")
t.test(a, mu=1000, alt="two.sided")

##### independent two sample t-test #####
install.packages("moonBook")
library(moonBook)

# 경기도 소재 대학병원에서 2년동안 내원한 급성 관상동맥증후군 환자 데이터
?acs
head(acs)
str(acs)
summary(acs)

### 주제 : 두 집단(남성, 여성)의 나이차이를 알고 싶다.
mean.man <- mean(acs$age[acs$sex =="Male"])
mean.woman <- mean(acs$age[acs$sex =="Female"])
cat(mean.man, mean.woman)

### 가설 설정
# 귀무 가설 : 남성과 여성의 나이에 대해 차이가 없다.
# 대립 가설 : 남성과 여성의 나이에 대해 차이가 있다.

### 정규분포 테스트

moonBook::densityplot(age ~ sex, data=acs)

# 귀무 가설 : 정규분포와 같다
# 대립 가설 : 정규분포아 다르다
shapiro.test(acs$age[acs$sex =="Male"]) 
# p-value가 0.05보다 크다. 귀무가설 => 정규분포

shapiro.test(acs$age[acs$sex =="Female"]) 
# p-value가 0.05보다 작다. 대립가설 => 정규분포가 아니다


### 등분산 테스트
# 두 집단의 등분산 여부를 알고 싶다.
# 귀무 가설 : 두 집단이 등분산이다.
# 대립 가설 : 두 집단은 등분산이 아니다.

var.test(age ~ sex, data=acs)


### 가설 검정
# 귀무 가설 : 남성과 여성의 나이에 대해 차이가 없다.
# 대립 가설 : 남성과 여성의 나이에 대해 차이가 있다.

# MWW
wilcox.test(age ~ sex, data=acs) # 대립

# 여성의 나이가 정규분포라고 가정 => t-test
t.test(age ~ sex, data=acs, alt="two.sided", var.equal=T)

# welch's test
t.test(age ~ sex, data=acs, alt="two.sided", var.equal=F)


##### paired sample t-test #####

str(sleep)
sleep


### 주제 : 같은 집단에 대해 수면시간의 증가량 차이가 나는지 알고싶다.

# 평균을 구해 차이를 확인
mean.group1 <- mean(sleep$extra[sleep$group == 1])
mean.group2 <- mean(sleep$extra[sleep$group == 2])
cat(mean.group1, mean.group2)


# 정규분포 여부
shapiro.test(sleep$extra[sleep$group == 1]) 
# p-value가 0.05보다 크다. 귀무가설 => 정규분포

shapiro.test(sleep$extra[sleep$group == 2]) 
# p-value가 0.05보다 크다. 귀무가설 => 정규분포

# 등분산 여부
var.test(extra ~ group, data=sleep) # 등분산

# t-test(paired sample t-test)
t.test(extra ~ group, data=sleep, alt="two.sided", var.equal=T,
       paired=T)

### ID를 제거하여 서로 다른 두 집단으로 테스트를 해보자.
sleep2 <- sleep[, -3]
sleep2

shapiro.test(sleep2$extra[sleep2$group == 1]) 
shapiro.test(sleep2$extra[sleep2$group == 2]) 
var.test(extra ~ group, data=sleep2)

# t-test(paired sample t-test)
t.test(extra ~ group, data=sleep2, alt="two.sided", var.equal=T,
       paired=F)

### 그래프
before <- subset(sleep, group==1, extra)
before

after <- subset(sleep, group==2, extra)
after

install.packages("PairedData")
install.packages("gld")
library(PairedData)

ab <- paired(before, after)
plot(ab, type="profile")


##### Power Analysis #####
# 적정한 표본의 개수를 산출
# cohen's d (effective size)



##### 실습2 #####
### 주제: 오토나 수동에 따라 연비가 같을까? 다를까?
### am:  0은 오토, 1이 수동, npg는 연비

str(mtcars)
head(mtcars)

a_mpg <- mean(mtcars$mpg[mtcars$am == 0])
m_mpg <- mean(mtcars$mpg[mtcars$am == 1])
cat(a_mpg, m_mpg)

# 정규분포 테스트
shapiro.test(mtcars$mpg[mtcars$am == 0]) # 정규분포
shapiro.test(mtcars$mpg[mtcars$am == 1]) # 정규분포

# 등분산 테스트
var.test(mtcars[mtcars$am == 1, 1], mtcars[mtcars$am == 0, 1]) # 등분산

# t-test
t.test(mpg ~ am, data = mtcars, var.equal = T) # 대립가설 => 차이가 있다.


##### 실습 3 #####
# 주제: 쥐의 몸무게가 전과 후의 차이가 있는지 알고 싶다.

mydata <- read.csv("../data/pairedData.csv")
mydata


# 데이터 타입 변경 => long형으로 변경
library(reshape2)
data1 <- melt(mydata, id=("ID"), variable.name = "GROUP",
              value.name = "RESULT")
data1

install.packages("tidyr")
library(tidyr)

data2 <- gather(mydata, key="GROUP", value = "RESULT")
data2


# 정규분포 테스트
shapiro.test(data1$RESULT[data1$GROUP == "before"]) # 정규분포
shapiro.test(data1$RESULT[data1$GROUP == "After"]) # 정규분포

# 등분산 테스트
var.test(RESULT ~ GROUP, data = data1, paired = T)

# 최종 결론
t.test(RESULT ~ GROUP, data = data1, paired = T)

# 시각화
before <- subset(data1, GROUP=="before", RESULT)
before

after <- subset(data1, GROUP=="After", RESULT)
after

g_data <- paired(before, after)
g_data

plot(g_data, type="profile")

moonBook::densityplot(RESULT ~ GROUP, data = data1)

##### 실습4 #####
### 주제 : 시 별로 2010년도와 2015년도의 출산율의 차이가 있나?

mydata <- read.csv("../data/paired.csv")
mydata

mydata1 <- gather(mydata, key="GROUP", value="RESULT", -c(ID, cities))
mydata1

mydata2 <- melt(mydata, id.vars = c(1, 4), variable.name = "GROUP",
                value.name = "RESULT")
mydata2

with(mydata1, shapiro.test(RESULT[GROUP=="birth_rate_2010"]))
with(mydata1, shapiro.test(RESULT[GROUP=="birth_rate_2015"]))

wilcox.test(RESULT ~ GROUP, data=mydata1, paired=T)

t.test(RESULT ~ GROUP, data=mydata1, paired=T)


##### 실습 5 #####
# https://www.kaggle.com/kappernielsen/independent-t-test-example
# 주제1 : 남녀별로 각 시험에 대해 평균차이가 나는지 알고 싶다.
# 주제2 : 같은 사람에 대해서 성적의 차이가 있는지 알고 싶다.
#             - 첫번째 시험(g1)과 세번째 시험(g3)를 사용

mat <- read.csv("../data/student-mat.csv")
View(mat)

summary(mat$G1)
summary(mat$G2)
summary(mat$G3)

table(mat$sex)

# 주제1
# 남녀별로 세번의 시험 평균을 비교해보자
library(dplyr)

mat %>% select(sex, G1, G2, G3) %>% group_by(sex) %>%
  summarise(mean_g1=mean(G1), mean_g2=(G2), mean_g3=(G3),
            cnt_g1=n(), cnt_g2=n(), cnt_g3=n(), 
            sd_g1=sd(G1), sd_g2=sd(G2), sd_g3=sd(G3))


shapiro.test(mat$G1[mat$sex == "M"])
shapiro.test(mat$G1[mat$sex == "F"])

shapiro.test(mat$G2[mat$sex == "M"])
shapiro.test(mat$G2[mat$sex == "F"])

shapiro.test(mat$G3[mat$sex == "M"])
shapiro.test(mat$G3[mat$sex == "F"])

var.test(G1 ~ sex, data=mat)
var.test(G2 ~ sex, data=mat)
var.test(G3 ~ sex, data=mat)

t.test(G1 ~ sex, data=mat, var.equal=T)
t.test(G2 ~ sex, data=mat, var.equal=T)
t.test(G2 ~ sex, data=mat, var.equal=T)

wilcox.test(G1 ~ sex, data=mat)
wilcox.test(G2 ~ sex, data=mat)
wilcox.test(G3 ~ sex, data=mat)

# 단측 검정
t.test(G1 ~ sex, data=mat, var.equal=T, alt="greater")
t.test(G2 ~ sex, data=mat, var.equal=T, alt="greater")
t.test(G2 ~ sex, data=mat, var.equal=T, alt="greater")

t.test(G1 ~ sex, data=mat, var.equal=T, alt="less")
t.test(G2 ~ sex, data=mat, var.equal=T, alt="less")
t.test(G2 ~ sex, data=mat, var.equal=T, alt="less")

# 같은 학생 입장에서 G1과 G3에 대해 변화가 있었는지 확인
mat %>% select(G1, G3) %>% summarise(mean_g1=mean(G1), mean_g3=mean(G3))

mydata <-  gather(mat, key="GROUP", value="RESULT", "G1", "G3")
View(mydata)

t.test(mydata$RESULT ~ mydata$GROUP, data=mydata, paired = T)
wilcox.test(mydata$RESULT ~ mydata$GROUP, data=mydata, paired = T)

t.test(mat$G1, mat$G3, paired = T)

# 단측 검정
# 가설 : 첫번째 시험이 세번째 시험보다 더 좋을 것이다. (g1 > g3)
t.test(mydata$RESULT ~ mydata$GROUP, data=mydata, paired = T, alt="greater")



