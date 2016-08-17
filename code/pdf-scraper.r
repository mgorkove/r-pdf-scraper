
library(rvest) #library for parsing html 
library(gsubfn) #for strapplyc
URL <- "http://www.sandag.org/index.asp?committeeid=15&fuseaction=committees.detail#mSched" #executive Committee 2016 meetings
pg <- read_html(URL)
linkNodes <- html_nodes(pg, ".bodylink")
pdfRegex <- ".+pdf"
baseHref <- "http://www.sandag.org"
baseDownloadDir <- "C:/r-scraping/"
for (node in linkNodes) {
  link <- html_attr(node, "href")
  isPdf <- grepl(pdfRegex,link)
  if (html_text(node) == "Minutes" && isPdf) {
    fullLink <- paste(baseHref, link, sep = "")
    downloadFilename <- strapplyc(link, "/(meetingid_.*.pdf)", simplify = TRUE)
    fullDownloadDir <- paste(baseDownloadDir, downloadFilename, sep = "")
    download.file(url = fullLink, destfile= fullDownloadDir, method = "curl", quiet = FALSE)
  }
}



