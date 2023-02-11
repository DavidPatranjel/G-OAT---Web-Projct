DROP TYPE IF EXISTS categ_oatmeal;
DROP TYPE IF EXISTS tipuri_produse;

CREATE TYPE categ_oatmeal AS ENUM( 'oatmeal', 'sweets', 'drinks', 'For baby goats', 'For the herd');
CREATE TYPE tipuri_produse AS ENUM('soy milk', 'coconut milk', 'almond milk', 'rice milk', 'other');


CREATE TABLE IF NOT EXISTS ovaz (
   id serial PRIMARY KEY,
   nume VARCHAR(50) UNIQUE NOT NULL,
   descriere TEXT,
   pret NUMERIC(8,2) NOT NULL,
   gramaj INT NOT NULL CHECK (gramaj>=0),
   calorii INT NOT NULL CHECK (calorii>=0),   
   tip_produs tipuri_produse DEFAULT 'other',
   categorie categ_ovaz DEFAULT 'oatmeal',
   ingrediente VARCHAR [], --pot sa nu fie specificare deci nu punem NOT NULL
   added_sugar BOOLEAN NOT NULL DEFAULT FALSE,
   imagine VARCHAR(300),
   data_adaugare TIMESTAMP DEFAULT current_timestamp
);

INSERT into oat_products (nume,descriere,pret, gramaj, calorii, tip_produs, categorie, ingrediente, added_sugar, imagine) VALUES 
('Strawberry jam oatmeal', 'Oatmeal with strawberry jam', 15, 300, 170, 'soy milk', 'oatmeal', '{"fine oat flakes","soy milk","honey","homemade strawberry jam"}', False, 'aproximativ-savarina.jpg'),
('Peanutbutter oatmeal', 'Oatmeal with peanutbutter', 15 , 300, 200, 'almond milk', 'oatmeal', '{"fine oat flakes","almond milk","honey","dates","chocolate topping","creamy peanutbutter"}', True, 'posibil-amandina.jpg'),
('Honey-walnut oatmeal', 'Oatmeal with honey and walnuts', 15 , 300, 186, 'rice milk', 'oatmeal', '{"fine oat flakes","rice milk","honey","walnuts","dates","hazelnuts"}', False,'tort-glazurat.jpg'),
('Berries and cream oatmeal', 'Oatmeal with berries and cream', 15 , 300, 236, 'coconut milk', 'oatmeal', '{"fine oat flakes","coconut milk","honey","raspberries","cranberries","blueberries","strawberries"}', False,'oat_cream.jpg'),
('Tiramisu oatmeal', 'Oatmeal with tiramisu flavour', 15 , 300, 203 'almond milk', 'oatmeal', '{"fine oat flakes","almond milk","honey","coffee esence","cacao"}', False,'dulcelind.jpg'),
('Orange and raisin oatmeal', 'Oatmeal with orange and raisins', 15 , 300, 195, 'soy milk', 'oatmeal', '{"fine oat flakes","soy milk","honey","orange","raisins"}', False,'dulcelind.jpg'),
('Strawberry lemonade', 'Refreshing lemonade with freshly squeezed fruits', 10 , 500, 37, 'other', 'drinks', '{"water","sugar","strawberries juice","lemon juice"}', True,'dulcelind.jpg'),
('Mint lemonade', 'Refreshing lemonade with freshly squeezed fruits', 10 , 500, 41, 'other', 'drinks', '{"water","sugar","lemon juice","mint leaves"}', True,'dulcelind.jpg'),
('Mango and strawberry smoothie', 'Creamy smoothie made from carefully frozen fruits', 10 , 300, 106, 'soy milk', 'drinks', '{"soy milk","mango","strawberries","lemon juice"}', False,'dulcelind.jpg'),
('Pina colada smoothie', 'Creamy smoothie made from carefully frozen fruits', 10 , 300, 110, 'coconut milk', 'drinks', '{"coconut milk","coconut","honey","water","ananas"}', False,'dulcelind.jpg'),
('Banana oatmeal puree', 'Healthy and tasty fruit puree for the little ones', 10, 150, 103, 'soy milk', 'For baby goats', '{"fine oat flakes","soy milk","banana","honey"}', False, 'aproximativ-savarina.jpg'),
('Apple and Banana oatmeal puree', 'Healthy and tasty fruit puree for the little ones', 10 , 150, 97, 'rice milk', 'For baby goats', '{"fine oat flakes","rice milk","banana","honey","apples"}', False, 'posibil-amandina.jpg'),
('Berries oatmeal puree', 'Healthy and tasty fruit puree for the little ones', 10 , 150, 100, 'rice milk', 'For baby goats', '{"fine oat flakes","honey","raspberries","cranberries","blueberries","strawberries"}', False,'tort-glazurat.jpg'),
('Raspberry and carrot oatmeal puree', 'Healthy and tasty fruit puree for the little ones', 10 , 150, 102, 'almond milk', 'For baby goats', '{"fine oat flakes","almond milk","raspberries","honey","carrot"}', False,'baby_carrot.jpg'),
('Family pack 4+1 oatmeal', 'Promotional package created espacially for everyone to enjoy our goodies', 60 , 1500, 1000, 'other', 'For the herd', '{}', True,'dulcelind.jpg'),
('Family pack 10+3 oatmeal', 'Promotional package created espacially for everyone to enjoy our goodies', 150 , 250, 620, 'other', 'For the herd', '{}', True,'dulcelind.jpg'),
('Family pack 7 oatmeal + 2 sweets', 'Promotional package created espacially for everyone to enjoy our goodies', 110 , 250, 620, 'other', 'For the herd', '{}', True,'dulcelind.jpg'),
('Family pack "the G-OAT experience', 'Biggest promotional package created espacially for everyone to enjoy our goodies', 250, 2500, 2050, 'other', 'For the herd', '{}', True,'dulcelind.jpg'),


