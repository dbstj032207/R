##### One way ANOVA #####

# LDLC : 저밀도 콜레스테롤 수치 -> 종속(결과) 변수
# Dx(진단결과) :

library(moonBook)
str(acs)

moonBook::densityplot(LDLC ~ Dx, data = acs)

#

