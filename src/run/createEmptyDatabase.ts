import { prepareDatabase } from "../tests/conftest";
import { client } from "@/databaseConfig";

prepareDatabase(client);
