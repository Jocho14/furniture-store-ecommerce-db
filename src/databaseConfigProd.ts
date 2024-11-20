import { Client } from "pg";
import * as dotenv from "dotenv";

dotenv.config();

export const prod = new Client({
  user: process.env.PROD_DB_USER,
  host: process.env.PROD_DB_HOST,
  database: process.env.PROD_DB_NAME,
  password: process.env.PROD_DB_PASSWORD,
  port: parseInt(process.env.PROD_DB_PORT || "5432"),
  ssl: {
    rejectUnauthorized: false,
  },
});
