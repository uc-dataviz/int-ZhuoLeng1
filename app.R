#('shiny')
#install.packages('rsconnect')
#install.packages('hexbin')
library(rsconnect)
#rsconnect::deployApp()


library(shiny)
library(tidyverse)
#install.packages('plotlyy')
library(plotly)
library(ggplot2)


data <- read_csv("country.csv")


ui <- fluidPage(
  titlePanel("Spotify music feature data by countries"),
  h2('Zhuo Leng'),
  sidebarLayout(
    sidebarPanel(
      sliderInput(
        "danceability",
        "danceability",
        min = 0.5,
        max = 0.9,
        value = c(0.6, 0.8)
      ),
      radioButtons(
        "yearInput",
        "year",
        choices = c("2017", "2016"),
        selected = "2017"
      )),

mainPanel(
  tabsetPanel(
    tabPanel("Data Description", p('For this assignment, I analyze the Spotify 2017/2016 playlist data based on most streamed songs throughout the year to understand the music preferences of customers in different regions using different audio features.
'),p('My dataset is acquired from Spotify, which is music, podcast, and video streaming service company that was officially launched on 7 Oct 2008. In this dataset, preference for different music types and elements is reflected by an index and then grouped by countries. The measuring attributes in music include lyrics, genres and audio features etc.. As I was intrigued by how music preference varies by region, I developed a visualization dashboard to compare the difference among different countries more intuitively. For comparison purpose, I used data from both 2016 and 2017.
'),p('The columns of the dataset represent different music features, such as Danceability (how suitable a track is for dancing based on a combination of musical elements.), Energy (measure from 0.0 to 1.0 and represents a perceptual measure of intensity and activity; typically, energetic tracks feel fast, loud, and noisy.), Speechiness (detects the presence of spoken words in a track based on values from 0 to 1; the more exclusively speech-like the recording, e.g. talk show, audio book, poetry, the closer to 1.0 the attribute value). In my analysis, I only use danceability, energy and speechiness these three features. Those measurements provides lots of insights for understanding how people in different regions choose music. The rows in the dataset are countries abbreviation. After I conducted basic analysis to get the average of features??? scores, I decided to focus on result of the top 10 countries that have highest features??? scores among others.')),
    tabPanel("Bubble Chart", p('For my UI design, I set two different interactive select boxes. First, I used danceability as my sliderInput. Min is 0.5, max is 0.9, and selection value is from 0.6-0.8. By setting sliderInput as danceability, I could limit my danceability in a certain range then compare the number of countries that have different ranges of danceability score. Second, you can customize year: 2017, 2016 in order to compare yearly change of features. My interactive plot is a bubble chart by energy and speechiness. The y of my chart represents for energy and x of chart is country name. From my plot, we could know relationship of speechiness vs. energy of different countries by selected year and selected danceability range interactively.'),plotlyOutput('coolplot')),
    tabPanel("Story", h3('What is the story?'),p("Firstly, we could just set year = 2017. When danceability range is set from 0.6-0.8, all ten countries can show in our plot, which means all of our countries have danceability at that range. From the bubble chart by energy, we can notice that US music has the lowest energy, however base on its size of bubble, it has  a highest speechiness score. AR(Argentina's) music has the highest energy, but compared with other bubble size, it has relative small bubble which means it???s music has less speechiness score. Music of IT(Italy) is the least speechy, with high energy that rank 2nd among other countries. Music of Australia and Canada are less energy, rank bottom 2nd and 3rd respectively, however from their size of bubble, they are more speechy than that of other countries. Their speechiness score can rank top 2nd and 3rd respectively. From our result, we could get conclusion that relationship of speechiness and energy is relatively negative correlated. Music that has higher energy alway has lower speechiness score.
"),p("Then, by adjusting min of danceability range from 0.6 to 0.8, we can notice that when I move min to 0.7, only 8 countries left in our bubble chart. Italy and Japan are missing. This means that they have lower danceability score than others. Then keep moving min to 0.72, now Australia and Canada are missing. As we known music of Australia and Canada have low energy but high speechiness. So we can make an assumption that low energy of music always means low danceability. Still keep adjusting min to 0.75 to verify our assumption, we notice that only US is keeped in our chart. US music has the highest danceability, however it has lowest energy and high speechiness. So our assumption has been rejected. Danceability has no obvious correlation with energy. "),
             p("Second, we set year = 2016 to see if the result of 2016 highly different with that of 2017. Most of our result from 2017 data can be hold. When danceability range is set from 0.6-0.8, all ten countries can show in our plot, which means all of our countries have danceability at that range. From the bubble chart, US music has the lowest energy, however base on its size of bubble, it has  a highest speechiness score, which is same in 2017 data. Argentina's music has the highest energy, but compared with other bubble size, it has relative small bubble which means it???s music has less speechiness score. This is also same result as 2017 data. However, in 2016, music of China is the least speechy, with high energy that rank 2nd among other countries. We could also get conclusion that music of countries with higher speechiness also end up with lower energy. Then, by adjusting min of danceability range from 0.6 to 0.8, we can get different result. When move danceability min to 0.7, only 7 countries left in our bubble chart, Italy, China and Japan are missing, which means music from these three countries are less danceable than that from other countries. Then we keep adjusting min to 0.75, US is the only country keeped in our chart, which is same as result from 2017.")
             ),
    tabPanel("Conclusion",h4('Why did you select the graphic form?
What is the role of interactivity? How does it enhance your ability to tell the story and communicate the data?
'),p("For this plot, I combine bubble plot with scatter plot. One of the main story of my plot is to compare the relationship between energy with speechiness by countries. So for this purpose, I select scatter plot with different color to represent different energy by countries to plot the relationship of x and y. In order to identify the speechiness at the same time, I select bubble plot and use different size/color to represents different level of speechiness. All these different graphical form make my plot more readable, attractive, interpretable and beautiful.
"),p("Interactivity can help me use data to tell the story and facilitate effective communication. For this plot, I design two different interactive select boxes for my UI. First, I used danceability as my sliderInput. Min is 0.5, max is 0.9, and selection value is from 0.6-0.8. By setting sliderInput as danceability, I could limit my danceability in a certain range then compare the number of countries that have different ranges of danceability score. Second, audience can customize year: 2017, 2016 in order to compare yearly change of features. I select bubble plot and combine it with scatter plot, then I use size, color, data transformations, all these specific channels to encode the data in order to improve interpretation and communication of my graph. To combine bubble plot with scatter plot, I describe my main story: compare the relationship between country and energy, at the same time, I want to know their speechiness level. All these different graphical form make my plot more readable, beautiful. Other than that, by design my graph interactively, audience could select different danceability range and years to see how my bubble chart can be changed base on their different setting. By setting the year = 2017, audience could get insight of the relationship of energy and speechiness. Then by moving min-max SliderInput of danceability, we could also know the danceability rank of countries??? music base on the number of countries that left in our plot. Then by setting the year = 2016, audience this time could easily compare that with the result of 2017. They could find that most conclusion can be retained, except for speechiness level of China and danceability rank of Japan. The interactive feature just let the audience to explore the data by themself, thus facilitate effective communication between data and audience.")
             )
)
)
)
)


server <- function(input, output) {
  output$coolplot <- renderPlotly({
    filtered <- data %>%
      filter(danceability >= input$danceability[1],
             danceability <= input$danceability[2],
             year == input$yearInput
      )
    ggplot(filtered, aes(country,energy)) +
      labs(subtitle="music energy and speech by countries",
           title="Bubble chart") +
      geom_jitter(aes(col=country, size=speechiness))
  
    
  })
}

shinyApp(ui = ui, server = server)
