import "module-alias/register";
import { client } from "@/test/src/databaseConfig";
import { prepareDatabase } from "@/test/src/databaseConfig";
import { ErrorMessages } from "@/test/src/enums/errorMessages";

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
