library(rvest)
result = NULL
for (year in 2013:2017){
  for (month in 1:12){
if (month < 10) {
url = paste("http://e-service.cwb.gov.tw/HistoryDataQuery/MonthDataController.do?command=viewMain&station=467410&stname=%25E8%2587%25BA%25E5%258D%2597&datepicker=",year,"-0",month,sep = "")
} else {
url = paste("http://e-service.cwb.gov.tw/HistoryDataQuery/MonthDataController.do?command=viewMain&station=467410&stname=%25E8%2587%25BA%25E5%258D%2597&datepicker=",year,"-",month,sep = "")}

web = read_html(url)
content = html_nodes(web,"td:nth-child(28) , td:nth-child(22) , td:nth-child(14) , td:nth-child(8) , #MyTable td:nth-child(1)")
text = html_text(content)
m_table = matrix(text,ncol = 5, byrow = T)

n_day = nrow(m_table)
yr_col = rep(year,n_day)
m_col = rep(month,n_day)
m_table = cbind(yr_col,m_col,m_table)

result = rbind(result,m_table)
}
}

result = as.data.frame(result)
colnames(result) = c("year","month","day","temp","hd","precp","sunhr")

weather = write.csv(result,file = "weather.csv")
