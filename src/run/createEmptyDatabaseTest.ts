import { prepareDatabase } from "../tests/conftest";
import { test } from "@/databaseConfigTest";

const createEmptyDatabase = async () => {
  await test.connect();
  await prepareDatabase(test);
  await test.end();
};

createEmptyDatabase();
