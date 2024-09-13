import "module-alias/register";
import fs from "fs";
import { Client } from "pg";
import { resolvePath } from "./helpers";

export const runSQLScript = async (filePath: string, client: Client) => {
  const sql = fs.readFileSync(resolvePath(filePath), "utf8");
  await client.query(sql);
};
