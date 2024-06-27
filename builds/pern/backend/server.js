// server.js

const express = require('express');
const { Sequelize } = require('sequelize');

const app = express();
const port = 5000;

// Connect to PostgreSQL
const sequelize = new Sequelize('postgres://user:password@db:5432/perndb');

app.get('/', async (req, res) => {
  try {
    await sequelize.authenticate();
    res.send('Hello from Express and PostgreSQL!');
  } catch (error) {
    res.status(500).send('Unable to connect to the database.');
  }
});

app.listen(port, () => {
  console.log(`Server is running on http://localhost:${port}`);
});
