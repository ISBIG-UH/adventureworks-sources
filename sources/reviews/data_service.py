
import duckdb


class DataService:
    def __init__(self, db_file):
        self.con = duckdb.connect(db_file)
        
        self.con.execute(
        """
            CREATE TABLE IF NOT EXISTS users (
                id INT NOT NULL PRIMARY KEY,
                firstName VARCHAR(50) NOT NULL,
                lastName VARCHAR(50) NOT NULL,
                email VARCHAR(100) NOT NULL,
                birthdate VARCHAR(20) NOT NULL 
            );

            CREATE TABLE IF NOT EXISTS stores (
                id INT NOT NULL PRIMARY KEY,
                name VARCHAR(200) NOT NULL            
            );

            CREATE TABLE IF NOT EXISTS reviews (
                id INT NOT NULL PRIMARY KEY,
                userid INT NOT NULL,
                storeid INT NOT NULL,
                product VARCHAR(100) NOT NULL,
                rating INT NOT NULL,
                date VARCHAR(20) NOT NULL
            );
        """)

        res = self.con.execute("SELECT COUNT(*) FROM users").fetchone()
        if res[0] <= 0:
            self.con.execute(
            """
                COPY users FROM 'generator/data/output/users.csv' (AUTO_DETECT TRUE, DELIMITER ',');

                COPY stores FROM 'generator/data/output/stores.csv' (AUTO_DETECT TRUE, DELIMITER ',');

                COPY reviews FROM 'generator/data/output/reviews.csv' (AUTO_DETECT TRUE, DELIMITER ',');          
            """)

    def get_users(self, size: int, page: int,):
        return self.con.execute("SELECT * FROM users LIMIT ? OFFSET ?", (size, size*page,)).fetch_df()

    def get_stores(self, size: int, page: int):
        return self.con.execute("SELECT * FROM stores LIMIT ? OFFSET ?", (size, size*page,)).fetch_df()
    
    def get_reviews(self, size: int, page: int, store: int = None, user: int=None):
        return self.con.execute("""
            SELECT * FROM reviews
            WHERE
                (? IS NULL OR ? = storeid)
                AND (? IS NULL OR ? = userid)
            LIMIT ? OFFSET ?
        """, (store, store, user, user, size, size * page)).fetch_df()
