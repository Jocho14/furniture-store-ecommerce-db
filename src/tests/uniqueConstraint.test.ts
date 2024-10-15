import { setupDatabaseTests, client, ErrorMessages } from "@/tests/conftest";

setupDatabaseTests();

describe("Database duplicates validation", () => {
  test("Should not allow inserting duplicated phone number", async () => {
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

  test("Should not allow inserting duplicated email address", async () => {
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

  test("Should not allow setting more than one thumbnail per product", async () => {
    await client.query(`
        INSERT INTO products (name, price, description) 
        VALUES ('Chair', 199.99, 'Cool chair');
      `);

    await client.query(`
        INSERT INTO images (product_id, url, alt, is_thumbnail) 
        VALUES (1, 'https://example', 'Chair', TRUE);
      `);

    await expect(
      client.query(`
          INSERT INTO images (product_id, url, alt, is_thumbnail) 
          VALUES (1, 'https://example2', 'Chair', TRUE);
        `)
    ).rejects.toThrow(ErrorMessages.UniqueConstraint);
  });
});
