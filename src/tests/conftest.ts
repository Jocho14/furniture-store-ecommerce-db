import "module-alias/register";
import { Client } from "pg";
import { client } from "@/databaseConfig";
import { runSQLScript } from "@/utils/sqlHelpers";
import { ErrorMessages } from "@/enums/errorMessages";

export const prepareDatabase = async (client: Client) => {
  await runSQLScript("@/schema/delete_db.sql", client);
  await runSQLScript("@/schema/create_db.sql", client);
  await runSQLScript("@/schema/drop_all_tables.sql", client);
  await runSQLScript("@/schema/add_extensions.sql", client);
  await runSQLScript("@/schema/create_tables.sql", client);
  await runSQLScript("@/schema/create_indexes.sql", client);
};

export const setupDatabaseTests = () => {
  beforeAll(async () => {
    await client.connect();
    await client.query("SET lc_messages = 'en_US.UTF-8'");
  });

  beforeEach(async () => {
    await prepareDatabase(client);
    await client.query("BEGIN");
  });

  afterEach(async () => {
    await client.query("ROLLBACK");
  });

  afterAll(async () => {
    await client.end();
  });
};

export { client };
export { ErrorMessages };
