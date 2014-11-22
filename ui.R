shinyUI(
  pageWithSidebar(
    #Application title
    headerPanel("Exploratory Data Analysis"),
    
    sidebarPanel(
      
      textInput("filename","Please enter name of the CSV data file without extension:"),
      br(),
      radioButtons("input_type", "Please select the Data Type:",
                         c("Continuous" = "cont",
                           "Discrete" = "disc"),inline=TRUE),
      submitButton('Perform EDA'),
      br(),
      p("Note: For trial run following datasets are already included:"),
      br(),
      
      p("Continuous Type: Normal, MilesPerGallon and PickUpTime."),
      p("Discrete Type: Poission, #ofCylinders and #ofCarburetors."), 
      br(),  
      p("However one can always upload any other dataset and perform EDA.")
      ),
    
    # Show a tabset that includes a plot, summary, and
    # table view of the generated distribution
    mainPanel(
      h4("Summary Statistics:"),
      p("In this section Basic Statistics are calculated for the given data."),
      verbatimTextOutput("Summary"),
      br(),
      
      h4("Data Visualization:"),
      p("In this section given data is visualized using common statistical plots."),
      tabsetPanel(
        tabPanel("Stem and Leaf Plot", 
                 fluidRow(p("Stem and Leaf Plot enables the user to visualize the entire
                            data exhibiting the shape of the distribution, skewness, 
                            kurtosis, points of concentration, gaps in data etc.")),
                 fluidRow(verbatimTextOutput("StemPlot"))
                 ),
        
        tabPanel("Histogram/Bar Plot", 
                 
                 fluidRow(p("If the data type is continuous then Histogram enables the user to 
                            visualize the shape of the distribution. Histogram 
                            overlaid with normal probability curve can be used to test if 
                            the given data follows a normal distribution.")),
                 
                fluidRow(p("If the data type is discrete then Bar Plot enables the user to 
                            visualize the frequency distribution.")),
                 
                 fluidRow(plotOutput("Histogram"))
                 ),
        tabPanel("Box Plot", 
                 fluidRow(p("Box Plot also enables the user to visualize the shape of the distribution 
                            and skewness. The heighth of the box represents the Inter Quartile 
                            Range (a measure of dispersion).")),
                 fluidRow(p("Box Plot enables the user also to identify the outliers (the points lying
                            outside the whiskers endpoints) in the data.")),
                 fluidRow(plotOutput("BoxPlot"))
                ),
      br(),
      
      h4("Tests for Normality (if Data Type is continuous):"),
      p("In this section given data (if it is continuous) is tested for normality using common statistical procedures."),
      tabsetPanel(
        tabPanel("Q-Q Plot", 
                 
                 fluidRow(p("Q-Q Plot enables the user to identify if the data follows a normal
                            distribution. It plots the sample quantiles of the data against the
                            theoretical normal distribution quantiles.")),
                 fluidRow(p("If most of the data points fall on the 45-degree straight line 
                            in the Q-Q Plot, the data can be taken to be following normal
                            distribution.")),
                 fluidRow(plotOutput("QQPlot"))
                 ),
        tabPanel("Shapiro-Wilk Test for Normality", 
                 
                 fluidRow(p("Shapiro-Wilk Test is a statistical procedure to test for normality of the data.")),
                 fluidRow(p("If p-value is greater than 0.05 then the data can be taken to be following normal
                            distribution with 95% confidence.")),
                 verbatimTextOutput("ShapiroTest"))
      )
    )      
)
)
)
