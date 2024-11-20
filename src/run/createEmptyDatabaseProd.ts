import { prepareDatabase } from "../tests/conftest";
import { prod } from "@/databaseConfigProd";

const createEmptyDatabase = async () => {
  await prod.connect();
  await prepareDatabase(prod);
  await prod.end();
};

createEmptyDatabase();
