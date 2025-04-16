An app that feteches data from an external API (Open Libary), and decodes JSON responses, the book information is then displayed to the user. The user is able to search for books, and on submit the users
query is managed by the NetworkManger. The NetworkManger uses the query to construct a url. The url created by the NetworkManger is then used to fetch data from the API that data is then JSON decoded 
and stored in a bookModel array. The bookModel array is displayed to the user showcasing books related to their search query. 


Bugs: 
There are some issues with the description not being correctly decoded by the JSON manager.
There was an intended "favorites" feature where the user could favorite books and use coreData to save the favorites array, but this feature was not fully implemented. 


Completed as a part of an assignment for Mobile Applications and Development (CS-4153)



