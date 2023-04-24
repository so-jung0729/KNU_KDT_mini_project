library(shiny)
library(ggplot2)
library(DT)
library(markdown)
library(rpart)
library(rpart.plot)
library(corrplot)
library(car)
library(lmtest)
library(gvlma)
library(pacman)
library(psych)
library(GGally)
library(pgirmess)
library(palmerpenguins)
library(dplyr)
library(car)
library(ggplot2)
library(ggcorrplot)




m_df <- read.csv('data/Marketing_Data.csv')
plot(m_df)
cor(m_df)

par(mfrow = c(1, 1))
boxplot(m_df)

m_df <- m_df[m_df$newspaper <= quantile(m_df$newspaper, 0.25) + 1.5 * IQR(m_df$newspaper),]


sfaf <- m_df[, c(1, 4)]
colnames(sfaf) <- c(1, 2)
colnames(sfaf)
ggplot(sfaf, mapping = aes(x = sfaf[,1], y = sfaf[,2])) + geom_point()


# =====================================================================================

ui <- fluidPage(
    titlePanel('Marketing Data Analysis'),
    navbarPage('manu',
               tabPanel('data', DT::dataTableOutput("table")),
               tabPanel("Summary",
                        br(), h3('Summary'), 
                        verbatimTextOutput("summary"),
                        verbatimTextOutput("str"),
                        br(),h3('Correlation'), 
                        verbatimTextOutput('corr')
               ),
               tabPanel("Plot",
                        sidebarLayout(
                            sidebarPanel(
                                radioButtons("plotType", "Plot type",
                                             c("Scatter"="p", "BoxPlot"="b", 'Correlation' = 'c')
                                )
                            ),
                            mainPanel(
                                plotOutput("totalplot", height = 800)
                            )
                        )
               ),
               
               tabPanel("Simple Linear Regression",
                        sidebarLayout(
                            sidebarPanel(
                                selectInput('xcol', 'X Variable', names(m_df)[1:3]), selected = 'youtube'),
                            mainPanel(
                                tabsetPanel(
                                    tabPanel("Plot Model", 
                                    br(),verbatimTextOutput("s_lm_title"),
                                    plotOutput("s_lmplot", height = 600)
                                    ), 
                                    tabPanel("Model", 
                                             br(),h3('Simple Linear Regression Analysis'),
                                             verbatimTextOutput("s_title"),
                                             verbatimTextOutput("s_lm"),
                                    ),
                                    tabPanel("Residual Analysis", 
                                             br(),h3('Residual Analysis'),
                                             plotOutput("s_lm_plot", height = 600),
                                             br(),h4('정규성'),
                                             verbatimTextOutput("s_shapiro"),
                                             br(),h4('등분산성'), 
                                             verbatimTextOutput("s_ncvTest"),
                                             br(),h4('선형성'), 
                                             verbatimTextOutput("s_gvlma"),
                                             br(),h4('독립성'), 
                                             verbatimTextOutput("s_dw"),
                                             br(),h4('이상관측치'),
                                             verbatimTextOutput('s_out')
                                    )
                                    
                                )
                            )
                        )),
              
               tabPanel("Multiple Linear Model",
                        sidebarLayout(
                            sidebarPanel(
                                selectInput("col_lm", "variable selection",
                                             c("youtube"='youtube', "facebook"='facebook', "newspaper"='newspaper'), 
                                            multiple =TRUE, selected = c('youtube', 'facebook')
                                )),
                            mainPanel(tabsetPanel(tabPanel("Model", 
                                                           h3('Linear Regrassion Analysis'),
                                                           verbatimTextOutput("m_title"),
                                                           verbatimTextOutput("m_lm")), 
                                                  tabPanel("Residual", 
                                                           h3('Residual Analysis'),br(),
                                                           plotOutput("m_lmplot", height = 600),
                                                           br(),h4('정규성'),
                                                           verbatimTextOutput("m_shapiro"),
                                                           br(),h4('등분산성'), 
                                                           verbatimTextOutput("m_ncvTest"),
                                                           br(),h4('선형성'), 
                                                           verbatimTextOutput("m_gvlma"),
                                                           br(),h4('독립성'), 
                                                           verbatimTextOutput("m_dw"),
                                                           br(),h4('다중공선성'), 
                                                           verbatimTextOutput('m_vif'), 
                                                           br(),h4('이상관측치'),
                                                           verbatimTextOutput('m_out')
                                                  ))
                                
                            )
                        )
               )
        ))

                        

server <- function(input, output){
    datasetInput <- reactive({
        m_df[, c(input$xcol, 'sales')]
    })

    lmdatasetInput <- reactive({
        m_df[, c(input$col_lm, "sales")]
    })

    # table
    output$table <- DT::renderDataTable({
        DT::datatable(m_df)
        })

    # summary
    output$summary <- renderPrint({
        summary(m_df)
    })
    output$str <- renderPrint({
        str(m_df)
    })
    output$corr <- renderPrint({
        cor(m_df)
    })

    # plot1
    output$totalplot <- renderPlot({
        if(input$plotType == 'p'){
            ggpairs(m_df,main = 'marketing data')
        }
        else if(input$plotType == 'b'){
            par(mfrow = c(2, 2))
            for (i in 1:4){
                boxplot(m_df[, i], main = names(m_df)[i])
            par(mfow = c(1, 1))
            }
        }
        else if(input$plotType == 'c'){
            corrplot.mixed(cor(m_df))
            
            # corrplot(cor(m_df), use = 'complete.obs' )
        }
    })


    # Simple Linear Regression -----------------------------------------

    output$s_lmplot <- renderPlot({
        s_df <- datasetInput()
        name_df <- colnames(datasetInput())
        colnames(s_df) <- c(1, 2)
        m_coef <- coef(lm(sales ~ ., data = datasetInput()))
        string <- paste('sales = ', round(m_coef[2],4), '*', name_df[1], ' + ', round(m_coef[1], 4))
        
        ggplot(s_df,  mapping = aes(x = s_df[,1], y = s_df[,2])) + 
            geom_point()  +
            xlab(name_df[1]) +
            ylab('sales') +
            stat_smooth(method = lm) + 
            annotate('text',label=string,  x = 40, y = 5, size = 6 )
    })

    output$s_title <- renderPrint({
        name_df <- colnames(datasetInput())
        m_coef <- coef(lm(sales ~ ., data = datasetInput()))
        paste('sales = ', round(m_coef[2],4), '*', name_df[1], ' + ', round(m_coef[1], 4))
    })
    
    
    output$s_lm <- renderPrint({
        m_lm <- lm(sales ~ ., data = datasetInput())
        summary(m_lm)
    })
    
    output$s_lm_plot <- renderPlot({
        m_lm <- lm(sales ~ ., data = datasetInput())
        par(mfrow = c(2, 2))
        plot(m_lm)
    })
    
    output$s_shapiro <-renderPrint({
        m_lm <- lm(sales ~ ., data = datasetInput())
        shapiro.test(resid(m_lm))
    })
    
    output$s_dw <-renderPrint({
        m_lm <- lm(sales ~ ., data = datasetInput())
        dwtest(m_lm)
    })
    
    output$s_ncvTest <-renderPrint({
        m_lm <- lm(sales ~ ., data = datasetInput())
        ncvTest(m_lm)
    })
    
    output$s_gvlma <-renderPrint({
        m_lm <- lm(sales ~ ., data = datasetInput())
        gvmodel<-gvlma(m_lm)
        summary(gvmodel)
    })
    
    output$s_out <-renderPrint({
        s_lm <- lm(sales ~ ., data = datasetInput())
        car::outlierTest(s_lm)
    })


    # Multiple Linear Model---------------------------------------------
    output$m_title <- renderPrint({
        name_df <- colnames(lmdatasetInput())
        m_coef <- coef(lm(sales ~ ., data = lmdatasetInput()))
        if (ncol(lmdatasetInput()) == 2){
            paste('sales = ', round(m_coef[2],4), '*', name_df[1], ' + ', round(m_coef[1], 4))
        } else if (ncol(lmdatasetInput()) == 3){
            paste('sales = ', round(m_coef[2],4), '*', name_df[1], ' + ', round(m_coef[3],4), '*', name_df[2], ' + ', round(m_coef[1], 4))
        } else {
            paste('sales = ', round(m_coef[2],4), '*', name_df[1], ' + ', round(m_coef[3],4), '*', name_df[2], ' + ', round(m_coef[4],4), '*', name_df[3], ' + ', round(m_coef[1], 4))
        }
    })
    
    
    output$m_lm <- renderPrint({
        m_lm2 <- lm(sales ~ ., data = lmdatasetInput())
        summary(m_lm2)
    })

    output$m_lmplot <- renderPlot({
        m_lm2 <- lm(sales ~ ., data = lmdatasetInput())
        par(mfrow = c(2, 2))
        plot(m_lm2)
    })
    
    output$m_shapiro <-renderPrint({
        m_lm2 <- lm(sales ~ ., data = lmdatasetInput())
        shapiro.test(resid(m_lm2))
    })
    
    output$m_dw <-renderPrint({
        m_lm2 <- lm(sales ~ ., data = lmdatasetInput())
        dwtest(m_lm2)
    })

    output$m_ncvTest <-renderPrint({
        m_lm2 <- lm(sales ~ ., data = lmdatasetInput())
        ncvTest(m_lm2)
    })
    
    output$m_gvlma <-renderPrint({
        m_lm2 <- lm(sales ~ ., data = lmdatasetInput())
        gvmodel<-gvlma(m_lm2)
        summary(gvmodel)
    })
    
    output$m_vif <- renderPrint({
        if (ncol(lmdatasetInput()) > 2){
            m_lm2 <- lm(sales ~ ., data = lmdatasetInput())
            vif(m_lm2)
        } else {print('다중공선성 검정 필요 없음')}
    })
    
    output$m_out <-renderPrint({
        m_lm2 <- lm(sales ~ ., data = lmdatasetInput())
        car::outlierTest(m_lm2)
    })
}
shinyApp(ui = ui, server = server)




































