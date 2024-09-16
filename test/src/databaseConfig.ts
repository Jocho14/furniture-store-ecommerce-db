import { Client } from "pg";
import * as dotenv from "dotenv";
import { runSQLScript } from "@/test/src/utils/sqlHelpers";

dotenv.config();

export const client = new Client({
  user: process.env.DB_USER,
  host: process.env.DB_HOST,
  database: process.env.DB_NAME,
  password: process.env.DB_PASSWORD,
  port: parseInt(process.env.DB_PORT || "5432"),
});

export const prepareDatabase = async () => {
  await runSQLScript("@/schema/drop_all_tables.sql", client);
  await runSQLScript("@/schema/create_tables.sql", client);
};
