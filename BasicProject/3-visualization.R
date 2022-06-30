# midwest 데이터
midwest <- ggplot2::midwest
str(midwest)


##### 기본 함수 #####
### plot()
### plot(y축 데이터, 옵션)
### plot(x축 데이터, y축 데이터, 옵션)

y <- c(1, 1, 2, 2, 3, 3, 4, 4, 5, 5)
plot(y)

x <- 1:10
y <- 1:10
plot(x, y)

"type = p, i, b, o, n"
plot(x, y, xlim=c(0, 15), ylim=c(0, 15), main="Graph", type="l")


"lty = solid, dashed, dotted, dotdash, longdash, twodash"
plot(x, y, xlim=c(0, 15), ylim=c(0, 15), main="Graph", type="l",
     pch=1, cex=.8, col="red", lty="dashed")


str(cars)
plot(cars, type="o")


# 같은 속도일대 제동거리가 다를 경우 대체적인 추세를 알기 어렵다.
# 속도별 제동거리의 평균을 구해 그래프로 그려보자.
mean_cars <- tapply(cars$dist, cars$speed, mean)
plot(mean_cars, type="o", xlab = "speed", ylab = "dist")

### points()
head(iris)
plot(iris$Sepal.Width, iris$Sepal.Length)
plot(iris$Petal.Width, iris$Petal.Length)

with(iris, plot(Sepal.Width, Sepal.Length))

with(iris, {
  plot(Sepal.Width, Sepal.Length)
  plot(Petal.Width, Petal.Length)
  })

with(iris, points(Petal.Width, Petal.Length))

### lines()
lines(cars)

### barplot(), hist(), pie(), mosaicplot(), 
### pair(), persp(), contour(), ...


##### 그래프 배열 #####
head(mtcars)
str(mtcars)

# 4개의 그래프를 동시에 그리기
par(mfrow = c(2, 2))
plot(mtcars$wt, mtcars$mpg)
plot(mtcars$wt, mtcars$disp)
hist(mtcars$wt)
boxplot(mtcars$wt)

par(mfrow = c(1, 1))
plot(mtcars$wt, mtcars$mpg)

# 행 또는 열마다 그래프 개수를 다르게 설정
?layout
layout(matrix(c(1, 1, 2, 3), 2, 2, byrow=T))
plot(mtcars$wt, mtcars$mpg)
plot(mtcars$wt, mtcars$disp)
hist(mtcars$wt)

##### 특이한 그래프 #####

### arrows
x <- c(1, 3, 6, 8, 9)
y <- c(12, 56, 78, 32, 9)

plot(x, y)
arrows(3, 56, 1, 12) # (3, 56) -> (1, 12)
text(4, 40, "이것은 샘플", srt = 64)


### 꽃잎 그래프
x <- c(1, 1, 1, 2, 2, 2, 2, 2, 2, 3, 3, 4, 5, 6, 6, 6)
y <- c(2, 1, 4, 2, 3, 2, 2, 2, 2, 2, 1, 1, 1, 1, 1, 1)

plot(x, y) # 겹치는 데이터 파악 불가

sunflowerplot(x, y)

### 별 그래프
# 데이터의 전체적인 윤곽을 살펴보는 그래프
# 데이터 항목에 대한 변화의 정도를 한눈에 파악
str(mtcars)
stars(mtcars[1:4])
stars(mtcars[1:4], key.loc = c(13, 1.0), flip.labels = F)
stars(mtcars[1:4], key.loc = c(13, 1.0), flip.labels = F,
      draw.segments = T)


##### ggplot2 #####
# install.packages("ggplot2")
library(ggplot2)


### 산포도
head(mpg)

# data, aes(배경설정) + geom_그래프 종류
ggplot(data = mpg, aes(x = displ, y = hwy)) + geom_point()

# data, aes(배경설정) + geom_그래프 종류 + 설정추가
ggplot(data = mpg, aes(x = displ, y = hwy)) + geom_point() + xlim(3, 6) + ylim(10, 30)

### 막대그래프: geom_col(), 히스토그램: geom_bar()
# 구동박식(drv)별로 고속도로 평균연비를 조회하고 그 결과를 그래프로 표현
library(dplyr)
df_mpg <- mpg %>% group_by(drv) %>% summarise(mean_hwy=mean(hwy))
df_mpg

ggplot(df_mpg, aes(drv, mean_hwy)) + geom_col()
ggplot(df_mpg, aes(reorder(drv, mean_hwy), mean_hwy)) + geom_col()

ggplot(mpg, aes(drv)) + geom_bar()
ggplot(mpg, aes(hwy)) + geom_bar()
