library(shiny)

shinyServer(function(input, output) {
  
  
  # Summary Statistics.
  
  output$Summary <- renderPrint({
    
    filepath<-paste("./",input$filename,".csv",sep="")
    data<-read.csv(filepath, header=TRUE)
    
    x    <- as.data.frame(data)[,1]  
    summary(x)
  })
  
  # Histogram / Bar Plot
  
  output$Histogram <- renderPlot({
  
    if (input$input_type == "cont") 
    {
      filepath<-paste("./",input$filename,".csv",sep="")
      data<-read.csv(filepath, header=TRUE)
      
      x    <- as.data.frame(data)[,1]  
      #bins <- seq(min(x), max(x), length.out = input$bins + 1)
      
      # draw the histogram with the specified number of bins
      h<-hist(x, col = 'darkgray', border = 'white', main="Histogram of the Input Data", xlab= "Data")
      xfit<-seq(min(x),max(x),length=40) 
      yfit<-dnorm(xfit,mean=mean(x),sd=sd(x)) 
      yfit <- yfit*diff(h$mids[1:2])*length(x) 
      lines(xfit, yfit, col="red", lwd=2)    
    }
    
    else
    {
    filepath<-paste("./",input$filename,".csv",sep="")
    data<-read.csv(filepath, header=TRUE)
  
    x    <- as.data.frame(data)[,1]  
    
    h<-barplot(table(x), col = 'darkgray', border = 'white', main="Bar Plot of the Input Data", xlab= "Data")
    }  
  })
  
  
  # Box Plot
  
  output$BoxPlot <- renderPlot({
    
    filepath<-paste("./",input$filename,".csv",sep="")
    data<-read.csv(filepath, header=TRUE)
    
    data    <- as.data.frame(data)
    data[,2]=1
    boxplot(data[,1]~data[,2],data,horizontal=FALSE,main="Box Plot of the Input Data")
  })
  
  
  # Stem and Leaf Plot.
  
  output$StemPlot <- renderPrint({
    
    filepath<-paste("./",input$filename,".csv",sep="")
    data<-read.csv(filepath, header=TRUE)
    
    x    <- as.data.frame(data)[,1] 

    stem(x)    
    
  })  
  
  # Q Q Plot
  
  output$QQPlot <- renderPlot({
    
    if (input$input_type == "cont") 
    {
      filepath<-paste("./",input$filename,".csv",sep="")
      data<-read.csv(filepath, header=TRUE)
      
      x    <- as.data.frame(data)[,1]  
      std_x<-(x-mean(x))/sqrt(var(x))
      qqnorm(std_x)
      qqline(std_x)  
    }  
  })
  
  # Shapiro-Wilks Test
  
  output$ShapiroTest <- renderPrint({
    
    if (input$input_type == "cont") 
    {
      filepath<-paste("./",input$filename,".csv",sep="")
      data<-read.csv(filepath, header=TRUE)
      
      InputData    <- as.data.frame(data)[,1]  
      shapiro.test(InputData)
    }  
  })  
})