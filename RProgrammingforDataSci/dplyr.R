library(dplyr)

#select
#filter
#arrange
#rename
#mutate
#summarise / summarize
# %>%

chicago <- readRDS("chicago.rds")
dim(chicago)
str(chicago)

names(chicago)[1:3]
subset <- select(chicago, city:dptp)
head(subset)
select(chicago, -(city:dptp))
select(chicago, ends_with("2"))
select(chicago, starts_with("d"))

chic.f <- filter(chicago, pm25tmean2 > 30)
summary(chic.f$pm25tmean2)

chicago <- arrange(chicago, date)
arrange(chicago, desc(date))

chicago <- rename(chicago, dewpoint = dptp, pm25 = pm25tmean2)

chicago <- mutate(chicago, pm25detrent = pm25 - mean(pm25, na.rm = TRUE))
head(transmute(chicago,
               pm10detrent = pm10tmean2 - mean(pm10tmean2, na.rm = TRUE),
               o3detrend = o3tmean2 - mean(o3tmean2, na.rm = TRUE)))

chicago <- mutate(chicago, year = as.POSIXlt(date)$year + 1900)
years <- group_by(chicago, year)
summarize(years, pm25 = mean(pm25, na.rm = TRUE),
          o3 = max(o3tmean2, na.rm = TRUE),
          no2 = median(no2tmean2, na.rm = TRUE))

qq <- quantile(chicago$pm25, seq(0, 1, 0.2), na.rm = TRUE)
chicago <- mutate(chicago, pm25.quint = cut(pm25, qq))
quint <- group_by(chicago, pm25.quint)
summarize(quint, o3 = mean(o3tmean2, na.rm = TRUE),
          no2 = mean(no2tmean2, na.rm = TRUE))

mutate(chicago, pm25.quint = cut(pm25,qq)) %>%
  group_by(pm25.quint) %>%
  summarize(o3 = mean(o3tmean2, na.rm = TRUE),
            no2 = mean(no2tmean2, na.rm = TRUE))

chicago <- tbl_df(chicago)
