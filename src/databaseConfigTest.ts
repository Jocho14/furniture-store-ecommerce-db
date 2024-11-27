import { Client } from "pg";
import * as dotenv from "dotenv";

dotenv.config();

export const test = new Client({
  user: process.env.TEST_DB_USER,
  host: process.env.TEST_DB_HOST,
  database: process.env.TEST_DB_NAME,
  password: process.env.TEST_DB_PASSWORD,
  port: parseInt(process.env.TEST_DB_PORT || "5432"),
});
