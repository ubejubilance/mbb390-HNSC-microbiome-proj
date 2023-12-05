library(curl)
url = "ftp://ftp.microbio.me/pub/cancer_microbiome_analysis/"
h = new_handle(dirlistonly=TRUE)
con = curl(url, "r", h)
tbl = read.table(con, stringsAsFactors=TRUE, fill=TRUE)
close(con)
head(tbl)

url1 = "ftp://ftp.microbio.me/pub/cancer_microbiome_analysis/TCGA/"
h = new_handle(dirlistonly=TRUE)
con = curl(url1, "r", h)
tbl = read.table(con, stringsAsFactors=TRUE, fill=TRUE)
close(con)
head(tbl)

urls <- paste0(url1, tbl[5:1,1])
urls <- paste0(url1, tbl[1:5,1])
urls <- paste0(url1, tbl[5,1])
fls = basename(urls)
curl_fetch_disk(urls[1], fls[1])

data <- read.csv("Metadata-TCGA-All-18116-Samples.csv")
print (data)