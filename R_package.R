library(shiny)
library(rvest)
install.packages("shiny")
library(stringr)

# Define UI
ui <- fluidPage(
  titlePanel("Movie Information Scraper"),
  sidebarLayout(
    sidebarPanel(
      textInput("movie_url", "Enter IMDb URL:", ""),
      actionButton("scrape_button", "Scrape Movie Info")
    ),
    mainPanel(
      verbatimTextOutput("scraped_output")
    )
  )
)

# Define server logic
server <- function(input, output) {
  # Function to scrape movie information
  scrape_movie_info <- function(movie_url) {
    # Read the HTML content from the IMDb URL
    page <- read_html(movie_url)
    
    # Check if the page is successfully loaded
    if (is.null(page)) {
      return("Error: Unable to load the page. Please check the URL.")
    }
    
    # Specify the full file path
    file_path <- "D:/SEMESTER 2/OSS/UNIT 2/23MX109_U2_EX1/moviepage.html"  # Adjust the path as per your system
    
    # Save the HTML content to a file
    writeLines(as.character(page), file_path)
    
    # Return the file path
    return(file_path)
  }
  
  # Event handler for scraping button click
  observeEvent(input$scrape_button, {
    movie_url <- input$movie_url
    
    # Call the function to scrape movie information
    scraped_file <- scrape_movie_info(movie_url)
    
    # Output the result
    output$scraped_output <- renderText({
      if (!is.null(scraped_file)) {
        paste("The HTML content of the page has been saved to:", scraped_file)
      } else {
        "Error: Unable to scrape movie information."
      }
    })
  })
}

# Run the application
shinyApp(ui = ui, server = server)
