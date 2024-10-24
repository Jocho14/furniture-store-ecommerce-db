import { prepareDatabase } from "../tests/conftest";
import { client } from "@/databaseConfig";

const createEmptyDatabase = async () => {
  await client.connect();
  await prepareDatabase(client);
  await client.end();
};

createEmptyDatabase();
