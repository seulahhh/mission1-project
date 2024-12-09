```html
src                                      
├─ main                                  
│  ├─ java                               
│  │  ├─ Services                        
│  │  │  ├─ ApiService.java            
│     │  │  └─ getApiDataRows() -- API 와 통신하여 API 데이터를 가공하고 List<Row>로 반환  
│  │  │  └─ dbService.java               
│  │  ├─ apiServices                     
│  │  │  ├─ ApiConnection.java           
│  │  │  └─ ApiDataService.java          
│  │  ├─ db                              
│  │  │  ├─ All.java                     
│  │  │  ├─ Info.java                    
│  │  │  ├─ Result.java                  
│  │  │  └─ Row.java                     
│  │  └─ view                            
│  │     └─ InfoView.java                
│  ├─ resources                          
│  └─ webapp                             
│     ├─ META-INF                        
│     │  └─ MANIFEST.MF                  
│     ├─ WEB-INF                         
│     │  ├─ classes    
│     │  │  └─ seoul-wifi.sqlite3 👉🏼 DB 파일
│     │  └─ lib                          
│     │     ├─ gson-2.11.0.jar           
│     │     └─ sqlite-jdbc-3.36.0.3.jar  
│     └─ index.jsp                       
└─ test                                  
├─ java                               
└─ resources                          
    ```