import "module-alias/register";
import { client } from "@/tests/src/databaseConfig";
import { prepareDatabase } from "@/tests/src/databaseConfig";

beforeAll(async () => {
  await client.connect();
});

beforeEach(async () => {
  await prepareDatabase();
});

afterAll(async () => {
  await client.end();
});

describe("Database insert test", () => {
  test("Insert data into the database", async () => {
    expect(
      await client.query(
        `INSERT INTO users (first_name, last_name, phone_number, date_of_birth) 
          VALUES ('Jake', 'Doe', '1234567890', '1990-01-01')`
      )
    ).resolves;
  });

  test("Insert data into the database", async () => {
    expect(
      await client.query(
        `INSERT INTO users (first_name, last_name, phone_number, date_of_birth) 
          VALUES ('Jake', 'Doe', '1234567890', '1990-01-01')`
      )
    ).resolves;
  });

  test("Insert data into the database fail", async () => {
    expect(
      await client.query(
        `INSERT INTO users (first_name, last_name, phone_number, date_of_birth) 
          VALUES ('Jake', 'Doe', '1234567890', '1990-01-01');
          INSERT INTO users (first_name, last_name, phone_number, date_of_birth) 
          VALUES ('Jake', 'Doe', '1234567890', '1990-01-01')`
      )
    ).resolves;
  });
});
