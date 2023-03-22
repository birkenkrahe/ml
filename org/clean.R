sms_raw <- read.csv(file="https://raw.githubusercontent.com/birkenkrahe/ml/main/data/sms_spam.csv",
                    header=TRUE,
                    stringsAsFactors=FALSE)
library(tm)
sms_corpus <- VCorpus(VectorSource(sms_raw$text))

tm_map(x=sms_corpus,
       FUN = content_transformer(tolower)) -> sms_corpus_clean
tm_map(x=sms_corpus_clean,
       FUN=removeNumbers) -> sms_corpus_clean
tm_map(x=sms_corpus_clean,
       FUN=removeWords,
       c(stopwords("en"),"just")) -> sms_corpus_clean
tm_map(sms_corpus_clean, removePunctuation) -> sms_corpus_clean
library(SnowballC)
tm_map(sms_corpus_clean, stemDocument) -> sms_corpus_clean
tm_map(sms_corpus_clean, stripWhitespace) -> sms_corpus_clean
sms_dtm <- DocumentTermMatrix(sms_corpus_clean)
m <- as.matrix(sms_dtm)
sms_dtm2 <- DocumentTermMatrix(sms_corpus,
                               control = list(
                                 tolower = TRUE,
                                 removeNumbers = TRUE,
                                 stopwords = TRUE,
                                 removePunctuation = TRUE,
                                 stemming = TRUE))
search()
ls()
