import "module-alias/register";
import { client } from "@/databaseConfig";
import { runSQLScript } from "@/utils/sqlHelpers";
import { ErrorMessages } from "@/enums/errorMessages";

const prepareDatabase = async () => {
  await runSQLScript("@/schema/drop_all_tables.sql", client);
  await runSQLScript("@/schema/add_extensions.sql", client);
  await runSQLScript("@/schema/create_tables.sql", client);
};

export const setupDatabaseTests = () => {
  beforeAll(async () => {
    await client.connect();
    await client.query("SET lc_messages = 'en_US.UTF-8'");
  });

  beforeEach(async () => {
    await prepareDatabase();
  });

  afterAll(async () => {
    await client.end();
  });
};

export { client };
export { ErrorMessages };
