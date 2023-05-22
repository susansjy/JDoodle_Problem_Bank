# JDoodle_Problem_Bank

A web app with a problem bank of programming questions to test users' programming knowledge.

## Description
The app will have a problem bank of at least ten programming questions, each with 5 test cases to validate the answers. The app will display five random programming problems one by one from the problem bank to the user. Once the user submits answers to all the problems, the app will display a detailed result page showing what test cases their program passed and failed.

## Tech
Vue 3, NestJs, WebSocket, Lodash, lowdb, Bootstrap, Axios

## Documents
**frontend**: contains the frontend implementation using Vue 3, which includes the UI design, interaction logic, and the lowdb database integration.

**backend**: contains the backend implementation using NestJs. It includes functionalities such as randomly selecting five questions, unit tests, and obtaining the WebSocket token.

## Run
To run the web app successfully, please follow these steps:

```bash
cd frontend
npm install
npm run dev
```

```bash
cd backend
npm install
npm run start:dev
```

Then you can visit http://127.0.0.1:5173/

## Future work
The app includes all the required features. However, due to time limitations, some aspects were implemented using convenient and quick methods, such as utilizing lowdb in the frontend. Given more time, there are areas that can be improved further. For example, the database design and security measures can be enhanced. Additionally, additional features can be incorporated to elevate the app, such as implementing a user login system, introducing a progress bar, and enhancing the interactive problem-solving process.
