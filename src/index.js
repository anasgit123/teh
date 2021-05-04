import 'dotenv/config';
import cors from 'cors';
import express from 'express';
import os from 'os';

let counter = 0;
const app = express();

app.use(cors());

app.get('/', (req, res) => {
  res.send(`BRATHER, ${os.hostname}, ${counter++}`);
});

app.listen(process.env.PORT, () =>
  console.log(`Example app listening on port ${process.env.PORT}!`),
);
