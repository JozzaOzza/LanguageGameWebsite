# LanguageGameWebsite

An attempt at making a website to practice foreign languages (starting with Italian, then adding French, Spanish and Portuguese).

## Structure

A frontend web application, calling a backend API which retrieves data from a database.
For something like this, the backend and database may not actually be necessary, but I want to include those for the sake of practice.

### Frontend

Aiming to have a frontend web application where a user can choose a language, choose a type of word in that language (from either nouns, verbs, adjectives, adverbs, and more), and choose a topic within that broader type.
Once this is selected the user can start a quick test (of 10 to 25 questions).
Each question will simply consist of the app randomly selecting a word from the topic they've chosen, and showing the English version of that word to the user.
The user will then attempt to respond with the equivalent word from whichever language they chose using a textbox for input (and any buttons for characters with accents if needed).
At the end of the test, the app will show the user their score, which responses were right and wrong, and what the correct answers were.

### Backend

Sitting behind the frontend web app will be an API which the frontend uses to fetch data from a database.
The user will choose a topic in the frontend, which will trigger a call to the backend, and from that call it will use the information to make a query to the database and retrieve the data, returning it to the frontend.

### Database

This will be where the words are all stored.
Each word type for each language will have its own table, and the topic within that type will appear as a specific value for one of the columns (e.g. the column 'topic').
