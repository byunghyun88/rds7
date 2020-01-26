library(tidyverse)
library(httr)
library(rvest)
library(urltools)

# 과제1. GS SHOP 크롤링

gs <- GET(url = 'http://m.gsshop.com/search/searchSect.gs?tq=%EB%A7%A5%EB%B6%81&mseq=401172&ab=b')

gs %>% 
  read_html() %>% 
  html_nodes(css = 'article.prd-item') -> list


name <- list %>% 
  html_node(css = 'dl > dt') %>% 
  html_text()

price <- list %>% 
  html_node(css = 'dd > span.set-price') %>% 
  html_text(trim = TRUE) %>% 
  str_remove(pattern = '판매가')

score <- list %>% 
  html_node(css = 'dd.user-side > div > span > span.user-eval > strong') %>% 
  html_text()

review <- list %>% 
  html_node(css = 'dd.user-side > div > span > span.user-comment') %>% 
  html_text() %>% 
  str_remove(pattern = '상품평')


df <- data.frame(name, price, score, review)

View(df)



# 과제2. 홈앤쇼핑


hs <- GET(url = 'http://m.hnsmall.com/search?query_top=%EB%A7%A5%EB%B6%81&query=&spell=&depth=&SCATE=&DCATE=&researchFlag=&arkKeyword=&search_type=%EC%A7%81%EC%A0%91+%EC%9E%85%EB%A0%A5&trackingarea=')


hs %>% 
  read_html() %>% 
  html_nodes(css = 'div > ul#product_list > li') -> list2

name <- list2 %>% 
  html_node(css = 'div.info_area > p') %>% 
  html_text()

cost <- list2 %>% 
  html_node(css = 'div.cost > p > span') %>% 
  html_text()

old_cost <- list2 %>% 
  html_node(css = 'div.cost > p.old_cost') %>% 
  html_text() %>% 
  str_remove(pattern = "원")

sale_sum <- list2 %>% 
  html_node(css = 'div.cost > p.sale_num') %>% 
  html_text()

df <- data_frame(name, cost, old_cost, sale_sum)

View(df)
