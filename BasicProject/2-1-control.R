##### 조건문 #####

a <- scan()
a

b <- scan(what = character())
b

df <- data.frame()
df <- edit(df)
df

a <- scan()
if(a < 10){
  print("10보다 작다")
}else{
  print("10보다 크다")
}

if(a >= 10){
  print("A")
}else if(a >= 9){
  print("B")
}else if(a >= 8){
  print("C")
}

### switch(), which(), ifelse()
#ifelse(조건식, 참, 거짓)