-- Create the user and database used by anath for storing certificates

-- No need to encrypt the password, everybody knows it
CREATE USER anath WITH PASSWORD 'anath-user';
CREATE DATABASE anathpki WITH OWNER = anath;
