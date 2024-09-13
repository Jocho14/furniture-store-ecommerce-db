import "module-alias/register";
import { client } from "@/tests/src/databaseConfig";
import { prepareDatabase } from "@/tests/src/databaseConfig";

beforeEach(async () => {
  await client.connect();
  await prepareDatabase();
});

afterEach(async () => {
  await client.end();
});

describe("Database insert test", () => {
  test("Insert data into the database", async () => {
    expect(
      await client.query(
        `INSERT INTO users (first_name, last_name, phone_number, date_of_birth) 
          VALUES ('John', 'Doe', '1234567890', '1990-01-01')`
      )
    ).resolves;
  });
});
