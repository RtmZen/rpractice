library(rvest)
url <- "http://ittf.com/ittf_ranking/WR_per_name.asp?Player_ID=108246&U18=0&U21=0&Siniors=1&"
ttRanking <- html(url)

dat <- ttRanking %>%
         html_node("table") %>%
         html_table(fill = TRUE)

rankingRaw <- data.frame(dat[4:103, 1],
                         dat[4:103, 2],
                         dat[4:103, 4],
                         dat[4:103, 5])
names(rankingRaw) <- dat[3, c(1, 2, 4, 5)]
head(rankingRaw)

month <- sapply(strsplit(as.character(rankingRaw[, 1]),
                         split = " "),
                "[",
                1)
year <- as.numeric(sapply(strsplit(as.character(rankingRaw[, 2]),
                                   split = "A"),
                          "[",
                          1))
ranking <- as.numeric(sapply(strsplit(as.character(rankingRaw[, 3]),
                                      split = "A"),
                             "[",
                             1))
points <- as.numeric(sapply(strsplit(as.character(rankingRaw[, 4]),
                                     split = "A"),
                            "[",
                            1))

if (length(month) * 3 == length(year) + length(ranking) + length(points)) {
  ranking <- data.frame(month,
                        year,
                        ranking,
                        points)
  head(ranking)
} else stop("Data frame cannot be made. Columns have different lengths.")

