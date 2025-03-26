--  adding a primary key.
CREATE  TABLE users (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100)
);
--  ADD SOME users
INSERT INTO users (name)
VALUES 
('JANE'),
('John'),
('alyse'),
('alyson'),
('maddy'),
('Maddison'),
('Zain'),
('Zabin'),
('Zanib'),
('Fatima'),
('Gwen'),
('ben'),
('usman'),
('ali'),
('alie'),
('Sabby'),
('zoe');
--  foreign keys.
CREATE TABLE  photos  (
    id  serial primary key,
    url text,
    user_id  int references users(id)
);
INSERT INTO   photos (url,user_id)
VALUES
('SABBY.PNG',18),
('http://mango.com/maongo.jpg',1),
('http://apple.com/appe.jpg',3),
('grapes.jpg',3),
('school1.png',7),
('elephant.jpg',6),
('car.png',4),
('cycle.jpg',1),
('van.png',8);
-- exercise
CREATE TABLE boats (
    id SERIAL PRIMARY KEY,
    name  TEXT
);
CREATE TABLE crew (
    id SERIAL PRIMARY KEY,
    name VARCHAR(256),
    boat_id INT REFERENCES  boats(id)
);
INSERT INTO boats (name)
VALUES
('Sea breeze'),
('Titanic'),
('Ocean master'),
('Augusto'),
('Atlantas');
INSERT INTO crew (name,boat_id)
VALUES 
('Capton Marvel',3),
('Alyse',1),
('Max',1),
('Jenny',2);
SELECT * FROM  crew WHERE boat_id=1;
--  constriant on insertion 
--  this is wrong because the user with id 100 doesn't exists, and throws an foreign key constraint error.
INSERT INTO   photos (url,user_id)
VALUES
('superomo.jpg',100);
--   constraints on deletion which has a foreign relationship.
--  trying to delete a user which is related to  photos.
DELETE FROM  users WHERE id  = 3;
--  throws an error because   the user is had a relationship with  other intatties.
-- define the constriants on   the foreign key columns that deletes or set the column to the null or give some default value.
-- Using the ON DELETE CASCADE constraint.
-- When this constraint is applied to a foreign key, deleting the related entity automatically removes the corresponding row, ensuring no orphaned records remain.
CREATE TABLETABLE photos (
    id SERIAL PRIMARY KEY,
    url TEXT,
    user_id INT REFERENCES users(id) ON DELETE CASCADE
);
--  NOW WHEN  the user is deleted no error is thrown.
DELETE  FROM users WHERE LOWER(name) = 'sabby';

--  using the on delete set null constriant that instead of deletingthe related  rows it it sets that column value to null.
CREATE TABLE photos (
    id SERIAL PRIMARY KEY,
    url TEXT,
    user_id INT REFERENCES users(id) ON DELETE SET NULL
);
/*
Category,Item
Measuring Instruments,Vernier calipers
Measuring Instruments,Micrometer screw gauge
Measuring Instruments,Meter scales
Measuring Instruments,Stopwatch
Measuring Instruments,Thermometers
Electricity and Magnetism Equipment,Multimeters
Electricity and Magnetism Equipment,Resistors, capacitors, and inductors
Electricity and Magnetism Equipment,Batteries and power supplies
Electricity and Magnetism Equipment,Wires and connectors
Electricity and Magnetism Equipment,Electromagnets
Electricity and Magnetism Equipment,Galvanometers and ammeters
Electricity and Magnetism Equipment,Voltmeters
Electricity and Magnetism Equipment,Power supplies
Optics Tools,Lenses (convex and concave)
Optics Tools,Mirrors (plane, concave, and convex)
Optics Tools,Prisms
Optics Tools,Optical benches
Optics Tools,Lasers and ray boxes
Optics Tools,Diffraction gratings
Mechanical Equipment,Pendulums
Mechanical Equipment,Spring balances
Mechanical Equipment,Masses and weights
Mechanical Equipment,Pulleys
Mechanical Equipment,Inclined planes
Mechanical Equipment,Force sensors
Wave and Sound Equipment,Tuning forks
Wave and Sound Equipment,Oscilloscopes
Wave and Sound Equipment,Sound level meters
Wave and Sound Equipment,Resonance tubes
Demonstration Models and Apparatus,Newton’s cradle
Demonstration Models and Apparatus,Simple machines
Demonstration Models and Apparatus,Models of the solar system
Demonstration Models and Apparatus,Electroscope
Demonstration Models and Apparatus,Boyle’s law apparatus
Safety Equipment,Goggles
Safety Equipment,Fire extinguishers
Safety Equipment,First aid kits
*/