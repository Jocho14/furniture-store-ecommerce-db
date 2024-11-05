import "module-alias/register";
import { runSQLScript } from "@/utils/sqlHelpers";
import { client } from "@/databaseConfig";

const runScript = async () => {
  await client.connect();
  await runSQLScript("@/data/test_data_account.sql", client);
  await client.end();
};

runScript();
