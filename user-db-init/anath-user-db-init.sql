-- Create the user and database used by anath for storing users

-- No need to encrypt the password, everybody knows it
CREATE USER anath WITH PASSWORD 'anath-user';
CREATE DATABASE anathusers WITH OWNER = anath;
