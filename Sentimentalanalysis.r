library(yuzhet)
library(tm)

# read wordcloud
review2 <- read.csv(file.choose())
str(review2)

corpus <- iconv(review2$text)
corpus <- Corpus(VectorSource(corpus))
inspect(corpus[1:5])

# cleaning corpus
corpus <- tm_map(corpus, tolower)
corpus <- tm_map(corpus, removePunctuation)
corpus <- tm_map(corpus, removeNumbers)
corpus <- tm_map(corpus, removeWords, stopwords("english"))
corpus <- tm_map(corpus, removeWords, c("book", "read", "life"))
corpus <- tm_map(corpus, stripWhitespace)

inspect(corpus[1:5])

# term document matrix
tdm <- TermDocumentMatrix(corpus)
tdm

# as.matrix(tdm)
dm <- as.matrix(tdm)

# bar plot of words (which word is repeated to highest)
mc <- rowSums(dm)
mc <- subset(mc, mc >= 2)
barplot(mc, las=2, col="blue")

# word cloud
set.seed(2000)
wordcloud(words=names(w), freq=w, max.words=20, random.order=T, min.freq=2, colors=brewer.pal(25, "Dark2"), scale=c(3, 9))

# obtain sentiment score
sentiment_data <- get_nrc_sentiment(sentiment_data)
s[1:5]

# calculate review wise score
s$score <- s$positive - s$negative
s[1:5]

# write scores into a csv file
write.csv(x=s, file="C:\\Users\\RHEYA\\Documents\\COLLEGE\\sem 3\\prg\\PACKAGE\\finalscorev2.csv")

# plot product sentiment
barplot(colSums(s), las=2, col=rainbow(10), ylab="Count", main="Sentiment")
