<%-- 
    Document   : Home
    Created on : 10 Jun 2024, 10:45:30 AM
    Author     : LENOVO
--%>

<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.io.BufferedReader, java.io.InputStreamReader, java.net.HttpURLConnection, java.net.URL" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <link href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap.min.css" rel="stylesheet"
              integrity="sha256-MfvZlkHCEqatNoGiOXveE8FIwMzZg4W85qfrfIFBfYc= sha512-dTfge/zgoMYpP7QbHy4gWMEGsbsdZeCXz7irItjcC3sPUFtf0kuFbDz/ixG7ArTxmDjLXDmezHubeNikyKGVyQ=="
              crossorigin="anonymous">
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Home</title>
        <link rel="stylesheet" href="css/general.css">
        <style>
            body {
                display: flex;
                flex-direction: column;
                min-height: 100vh;
                background: url('images/back.jpeg') no-repeat center center fixed;
                background-size: cover;
                margin: 0;
                padding: 0;
            }
            .container {
                flex: 1;
                max-width: 90%;
                margin: 3% auto;
                border-radius: 8px;
                height: 85vh;
            }
            h1 {
                text-align: center;
                color: #333;
            }
            .quote {
                font-size: 1.2em;
                margin: 20px 0;
                color: #555;
            }
            .author {
                font-size: 1em;
                text-align: right;
                color: #777;
            }
            .container-fluid {
                padding: 30px 50px;
            }
            .panel {
                border-radius: 30px 30px 0px 0px !important;
                transition: box-shadow 0.5s;
            }
            .panel:hover {
                box-shadow: 0px 0px 40px rgba(0, 0, 0, .2);
            }
            .panel-footer .btn:hover {
                border: 1px solid #000000;
                background-color: #770737 !important;
                color: #F3CFC6;
            }
            .panel-heading {
                color: #620021 !important;
                background-color: #F8C8DC !important;
                padding: 25px;
                border-bottom: 0px solid transparent;
                border-radius: 30px 30px 0px 0px;
            }
            .panel-footer {
                background-color: white !important;
            }
            .panel-footer .btn {
                margin: 15px 0;
                background-color: #FBCEB1;
                color: #620021;
            }
            footer {
                padding: 1rem;
                text-align: center;
            }
            @media screen and (max-width: 768px) {
                .col-sm-4 {
                    text-align: center;
                    text-size-adjust: 50px;
                    margin: 25px 0;
                }
                .btn-lg {
                    width: 100%;
                    margin-bottom: 35px;
                }
            }
        </style>
    </head>
    <body>
        <header>
            <div class="topnav">
                <a class="active" href="Home.jsp">HOME</a>
                <a href="addTask.html">TASK</a>
                <a href="calendar.html">CALENDAR</a>
                <a href="weather.html">WEATHER</a>
                <button id="signout_button">Sign Out</button>
            </div>
        </header>
        <div class="container">
            <h1 style="font-size: 48px; margin: 0;">Welcome Dear Master Planner!</h1>
            <%
                // Define the API endpoint and the category parameter
                String category = "happiness"; // You can change this to any valid category
                String apiUrl = "https://api.api-ninjas.com/v1/quotes?category=" + category;

                // Define your API key
                String apiKey = "w9JNrP28XcQy1sIYso6FuvoikrmgBZklme6QCyDe"; // Replace with your actual API key

                try {
                    // Create the URL object
                    URL url = new URL(apiUrl);

                    // Open the connection
                    HttpURLConnection connection = (HttpURLConnection) url.openConnection();
                    connection.setRequestMethod("GET");
                    connection.setRequestProperty("X-Api-Key", apiKey);
                    connection.setRequestProperty("accept", "application/json");

                    // Get the response code
                    int responseCode = connection.getResponseCode();

                    if (responseCode == HttpURLConnection.HTTP_OK) { // HTTP 200 OK
                        // Read the response
                        BufferedReader in = new BufferedReader(new InputStreamReader(connection.getInputStream()));
                        String inputLine;
                        StringBuilder content = new StringBuilder();

                        while ((inputLine = in.readLine()) != null) {
                            content.append(inputLine);
                        }

                        // Close the connections
                        in.close();
                        connection.disconnect();

                        // Parse the JSON response manually
                        String jsonResponse = content.toString();

                        // Extract fields from JSON
                        String quoteStartTag = "\"quote\": \"";
                        String authorStartTag = "\"author\": \"";
                        String categoryStartTag = "\"category\": \"";

                        int quoteStartIndex = jsonResponse.indexOf(quoteStartTag) + quoteStartTag.length();
                        int quoteEndIndex = jsonResponse.indexOf("\"", quoteStartIndex);
                        String quote = jsonResponse.substring(quoteStartIndex, quoteEndIndex);

                        int authorStartIndex = jsonResponse.indexOf(authorStartTag) + authorStartTag.length();
                        int authorEndIndex = jsonResponse.indexOf("\"", authorStartIndex);
                        String author = jsonResponse.substring(authorStartIndex, authorEndIndex);

                        int categoryStartIndex = jsonResponse.indexOf(categoryStartTag) + categoryStartTag.length();
                        int categoryEndIndex = jsonResponse.indexOf("\"", categoryStartIndex);
                        String quoteCategory = jsonResponse.substring(categoryStartIndex, categoryEndIndex);

            %>
            <h4 style="font-size: 24px"><strong>Here is your quote of the day!</strong></h4><br>
            <p style="font-size: 18px" class="quote"><strong>Quote:</strong> <%= quote %></p>
            <p style="font-size: 14px" class="author"><strong>Author:</strong> <%= author %></p><br>
            <%
                    } else {
                        out.println("<p>Failed to get a quote. HTTP response code: " + responseCode + "</p>");
                    }
                } catch (Exception e) {
                    out.println("<p>Error: " + e.getMessage() + "</p>");
                }
            %>
            <div class="container-fluid">
                <div class="row">
                    <div class="col-md-6">
                        <div class="panel panel-default text-center">
                            <div class="panel-heading">
                                <h1>Want to add some task? Let's do it!</h1>
                            </div>
                            <div class="panel-body">
                                <h4>Let's transform your ambitions into actions.
                                    Harness the power of today to build the future you desire. Let's make it productive!
                                </h4>
                            </div>
                            <div class="panel-footer">
                                <a href="addTask.html" class="btn btn-lg">Add Your Task Here!</a>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-6">
                        <div class="panel panel-default text-center">
                            <div class="panel-heading">
                                <h1>Planning? Let's check the weather!</h1>
                            </div>
                            <div class="panel-body">
                                <h4>Insight into the weather helps you plan perfectly.
                                    Embrace today's weather forecast to navigate your plans smoothly and efficiently.
                                </h4>
                            </div>
                            <div class="panel-footer">
                                <a href="weather.html" class="btn btn-lg">Forecast Weather Here!</a>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <script>
            document.getElementById('signout_button').onclick = function () {
                window.location.href = "index.html";
            };
        </script>
        <footer>
            <p>&copy; DailyPlanner-2024</p>
        </footer>
    </body>
</html>
