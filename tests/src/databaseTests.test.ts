import "module-alias/register";
import { client } from "@/tests/src/databaseConfig";
import { prepareDatabase } from "@/tests/src/databaseConfig";
import { ErrorMessages } from "@/tests/src/enums/errorMessages";

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

describe("Database duplicates validation", () => {
  test("Should throw phone number unique constraint error", async () => {
    await client.query(`
        INSERT INTO users (first_name, last_name, phone_number, date_of_birth) 
        VALUES ('A', 'A', '+48123123123', '1990-01-01');
      `);

    await expect(
      client.query(`
          INSERT INTO users (first_name, last_name, phone_number, date_of_birth) 
          VALUES ('B', 'B', '+48123123123', '1990-01-02');
        `)
    ).rejects.toThrow(ErrorMessages.UniqueConstraint);
  });

  test("Should throw email unique constraint error", async () => {
    const firstRes = await client.query(`
      INSERT INTO users (first_name, last_name, phone_number, date_of_birth) 
      VALUES ('A', 'A', '+48111111111', '1990-01-01') 
      RETURNING user_id;
    `);
    const first_user_id = firstRes.rows[0].user_id;
    await client.query(
      `
        INSERT INTO accounts (user_id, email, password_hash) 
        VALUES ($1, 'example@email.com', 'password');
      `,
      [first_user_id]
    );

    const secondRes = await client.query(`
      INSERT INTO users (first_name, last_name, phone_number, date_of_birth) 
      VALUES ('A', 'A', '+48222222222', '1990-01-01') 
      RETURNING user_id;
    `);
    const second_user_id = secondRes.rows[0].user_id;

    await expect(
      client.query(
        `
          INSERT INTO accounts (user_id, email, password_hash) 
          VALUES ($1, 'example@email.com', 'password');
        `,
        [second_user_id]
      )
    ).rejects.toThrow(ErrorMessages.UniqueConstraint);
  });
});
