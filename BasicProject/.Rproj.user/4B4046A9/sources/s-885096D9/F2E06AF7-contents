##### 변수 #####
goods = "냉장고"

# 변수 사용 시 객체 형태로 사용하는 것을 권장
goods.name = "냉장고"
goods.code = "rf001"
goods.price = 1000000

goods.name

goods.name <- "Television"
goods.code <- "tv001"
goods.price <- 2000000

# 데이터 타입 확인
class(goods.name)
class(goods.price)
mode(goods.name)
mode(goods.price)


##### 데이터 타입(구조) #####
# 1. 스칼라


########## Vector ##########

# 1. 기본 자료 구조
# 2. 1차원 배열
# 3. 인덱스 접근
# 4. 동일한 자료형만 사용
# 5. c(), seq(), rep(), ...

v <- c(1, 2, 3, 4, 5)
v
class(v)
mode(v)

(v <- c(1, 2, 3, 4, 5))

# 슬라이싱
# 직관적인 인덱싱 (1부터 시작)
c(1:5) 

# 여러개의 자료형이 있으면
# 하나의 자료형으로 자동으로 통일 됨
(v <- c(1, 2, 3, 4, "5"))  

seq(from=1, to=10, by=2)

rep(1:4, 2)

### vector의 접근
v <- c(1:50)
v[10:45]
length(v)

c(13)

c(13, -5, 20:23)

c(13, -5, 20:23, 12, -2:3)

v1 <- c(13, -5, 20:23, 12, -2:3)
v1[1]
v1[c(2, 4)]
v1[c(4, 5:8, 7)]
v1[-1]  # R에서 -는 제거를 의미 (즉, 첫번째 인덱스를 제외하고 가져옴)
v1[-2]
v1[c(-2, -4)]
v1[-c(2, 4)]
v1[length(v1)]


### 집합 연산
x <- c(1, 3, 5, 7)
y <- c(3, 5)

union(x, y)      # 합집합
setdiff(x, y)    # 차집합
intersect(x, y)  # 교집합


### 컬럼명 지정
age <- c(30, 40, 45)
names(age) <- c("홍길동", "유비", "관우")
age


### 특정 변수의 데이터 제거
age <- NULL
age


### 백터 생성의 또 다른 표현
x <- c(2, 3)
x

x <- (2:5)  # 범위를 지정할 때는 c 생략 가능
x



##### factor #####

gender <- c("man", "woman", "woman", "man", "man")
gender
class(gender)
mode(gender)
is.factor(gender)
"--------------------"
ngender <- as.factor(gender)
ngender
is.factor(ngender)
class(ngender)
mode(ngender)

plot(ngender)

gfactor <- factor(gender, levels = c("woman", "man"))
gfactor
plot(gfactor)



##### Matrix #####

matrix((1:5))

matrix((1:5), nrow=2)   # 개수가 안맞으면 반복

matrix((1:12), nrow=2)

matrix((1:12), nrow=2, byrow = TRUE)  # 채워지는 순서 변경


x1 <- c(3, 4, 50:52)
x2 <- c(30, 5, 6:8, 7, 8)
x1
x2

rbind(x1, x2)  # 행으로 합치기 (개수가 맞지 않으면 순환)

cbind(x1, x2)  # 열로 합치기 (개수가 맞지 않으면 순환)


### 차수 확인
x <- matrix(c(1:9), ncol=3)
x 
length(x)
nrow(x)
ncol(x)
dim(x)


### 컴럼명 지정
colnames(x) <- c("one", "two", "three")
x

colnames(x)


### apply
x
apply(x, 1, max)  # 두번째 인자(margin) => 기준 1:행 2:열
apply(x, 2, max)  
apply(x, 1, sum)
apply(x, 2, sum)













##### data.frame #####

no <- c(1, 2, 3)
name <- c("hong", "lee", "kim")
pay <- c(150.25, 250.18, 300.34)

data.frame(No=no, Name=name, PAYMENT=pay)


### read.csv(), read.delim(), read.table()
getwd()

read.csv("../data/emp.csv")

setwd("../data")
getwd()

read.csv("emp.csv")

read.table("emp.txt", header = T, sep = " ")

read.table("emp.csv", header = T, sep = ",")


### 실습
aws = read.delim("AWS_sample.txt", sep="#")
aws
View(aws)

aws[1, 1]

x1 <- aws[1:3, 2:4]
x1

x2 <- aws[9:11, 2:4]
x2

cbind(x1, x2)
rbind(x1, x2)  # 적합

aws[, 1]
aws$AWS_ID

# 구조 확인
str(aws)

# 기본 통계량
summary(aws)


### 주요 함수들
# apply
df <- data.frame(x = c(1:5), y = seq(1, 10, 2), z = c("a", "b", "c", "d", "e"))
df

apply(df[,c(1, 2)], 1, sum)
apply(df[,c(1, 2)], 2, sum)

# subset
df
x1 <- subset(df, x>=3)
x1

x2 <- subset(df, x>=2 & y <= 6)
x2

# 병합 : merge
height <- data.frame(id=c(1, 2), h=c(180, 175))
weight <- data.frame(id=c(1, 2), h=c(80, 75))
merge(height, weight, by.x="id", by.y="id")





##### array #####

(v <- c(1:12))

arr <- array(v, c(4, 2, 3)) # (행, 열, 면)

arr[,, 1]
arr[,, 2]

arr[2, 1 ,1]
arr[, , 2][2, 1]


##### list #####

x1 <- 1
x2 <- data.frame(varl=c(1, 2, 3), var2=c('a', 'b', 'c'))
x3 <- matrix(c(1:12), ncol=2)
x4 <- array(1:20, dim=c(2, 5, 2))

x5 <- list(c1=x1, c2=x2, c3=x3, c4=x4)
x5


x5$c2
x5$c1

list1 <- list(c("lee", "kim"), "유비", 95)
list1

list1[1]
list1[[1]]
list1[[1]][1]
list1[[1]][2]

list2 = list("lee", "이순신", 95)
list2

un = unlist(list2)
un


### apply(), lapply(), sapply()
# lapply : apply는 2차원 이상의 데이터를 입력받기 때문에 vector를 입력받기
#          위한 방법으로 사용, 리턴값이 list형이다.
(a1 <- c(1:5))

apply(a1, max)

lapply(a1, max)

a2 <- list(c(1:5))
a3 <- list(c(6:10))
a4 <- c(a2, a3)
a4

apply(a4, max)

x <- lapply(a4, max)
(x <- unlist(x))


sapply(a4, max)




