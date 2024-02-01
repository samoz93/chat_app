export const CONFIG = {
  dbUserName: process.env.POSTGRES_USER,
  dbPassword: process.env.POSTGRES_PASSWORD,
  dbDatabase: process.env.POSTGRES_DB,
  dbHost: process.env.POSTGRES_HOST,
  dbPort: parseInt(process.env.POSTGRES_PORT, 10),
  isDev: process.env.NODE_ENV !== 'production',
  jwtSecret: process.env.JWT_SECRET,
  cookieSecret: process.env.COOKIES_SECRET,
};

export const DB_OPTIONS = {
  type: 'postgres',
  port: CONFIG.dbPort,
  username: CONFIG.dbUserName,
  password: CONFIG.dbPassword,
  database: CONFIG.dbDatabase,
  synchronize: true,
};
