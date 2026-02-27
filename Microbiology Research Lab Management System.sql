create database microbial_research_lab;
use microbial_research_lab;

create table researchers (researchers_id int primary key,researcher_name varchar(100) not null, researcher_role varchar(100) check ( researcher_role in ('Intern','Research Scholar','Assistant','PhD scholar', 'Executive Scientist')),
project_name varchar(100), project_duration varchar(50),Email varchar(100) unique,phone_no char(10));
 
INSERT INTO researchers (researchers_id, researcher_name, researcher_role, project_name, project_duration, Email, phone_no)
VALUES
(1, 'Gayathri Ramesh', 'Research Scholar', 'Fermented Pomegranate Peel-Derived Prebiotic', '6 months', 'gayathri.r@gmail.com', '9876543210'),
(2, 'Nivi', 'Intern', 'Pumpkin Pulp Fermentation Study', '3 months', 'nivi@gmail.com', '9123456780'),
(3, 'Varahi', 'Executive Scientist', 'Fermented Pea Protein for Bitterness Reduction Study', '1 year', 'varahi@gmail.com', '9546738928'),
(4, 'Venkat', 'Assistant', 'Postbiotic Shampoo Development', '1 year', 'venkat@gmail.com', '9988776655'),
(5, 'Nirmala', 'PhD Scholar', 'Silver Nanoparticle Synthesis Study', '1 year', 'nimi@gmail.com', '9090909090'),
(6, 'Ramesh', 'Research Scholar', 'Probiotic Skin Microbiome Enhancement', '6 months', 'ramesh@gmail.com', '9191919191');


CREATE TABLE Samples (
  sample_id INT PRIMARY KEY AUTO_INCREMENT,
  sample_name VARCHAR(100) NOT NULL,
  sample_type VARCHAR(50),
  date_received DATE,
  supplier_id INT,
  FOREIGN KEY (supplier_id) REFERENCES Suppliers(supplier_id)
);

INSERT INTO Samples (sample_name, sample_type, date_received, supplier_id)
VALUES
('Pomegranate Peel Extract', 'Fruit', '2025-10-01', 1),
('Pumpkin Pulp', 'Vegetable', '2025-09-20', 2),
('Pea protein', 'Vegetable', '2025-07-16', 1),
('Milk Sample', 'Dairy', '2025-09-15', 3),
('Shampoo Sample A', 'Cosmetic', '2025-10-02', 1),
('Yogurt Sample', 'Fermented Food', '2025-09-25', 3);


CREATE TABLE Instruments (
  instrument_id INT PRIMARY KEY AUTO_INCREMENT,
  instrument_name VARCHAR(100) NOT NULL,
  instrument_type VARCHAR(50),
  purchase_date DATE,
  status VARCHAR(20) CHECK (status IN ('Working', 'Under Maintenance', 'Out of Order'))
);

INSERT INTO Instruments (instrument_name, instrument_type, purchase_date, status)
VALUES
('Laminar Air Flow', 'Safety Equipment', '2023-01-10', 'Working'),
('Autoclave', 'Sterilization', '2022-06-05', 'Working'),
('Bunsen Burner', 'Heating', '2021-03-12', 'Working'),
('pH Meter', 'Analytical', '2024-02-20', 'Working'),
('Magnetic Stirrer', 'Mixing', '2023-04-22', 'Working'),
('Water Bath', 'Heating', '2021-12-10', 'Out of Order'),
('Microscope', 'Imaging', '2023-09-05', 'Working'),
('Refrigerated Centrifuge', 'Separation', '2024-01-18', 'Under Maintenance'),
('Incubator', 'Culture Growth', '2022-08-30', 'Working'),
('Vacuum Pump', 'Pump', '2023-06-15', 'Working'),
('Shaker', 'Mixing', '2023-02-10', 'Working'),
('Analytical Balance', 'Measurement', '2022-03-05', 'Working'),
('Gas Chromatograph', 'Analytical', '2021-11-18', 'Under Maintenance'),
('Microcentrifuge', 'Separation', '2023-05-20', 'Working');


CREATE TABLE Reagents (
  reagent_id INT PRIMARY KEY AUTO_INCREMENT,
  reagent_name VARCHAR(100) NOT NULL,
  reagent_type VARCHAR(50),
  expiry_date DATE,
  stock_quantity INT
);

INSERT INTO Reagents (reagent_name, reagent_type, expiry_date, stock_quantity)
VALUES
('Nutrient Broth', 'Culture Media', '2026-05-10', 25),
('Agar Powder', 'Solidifying Agent', '2026-03-15', 40),
('Ethanol', 'Disinfectant', '2027-01-20', 60),
('Gram Stain Kit', 'Staining Reagent', '2025-12-01', 10),
('Silver Nitrate', 'Chemical Reagent', '2026-09-18', 15);

CREATE TABLE Experiments (
  experiment_id INT PRIMARY KEY AUTO_INCREMENT,
  experiment_name VARCHAR(100) NOT NULL,
  researchers_id INT,
  sample_id INT,
  instrument_id INT,
  reagent_id INT,
  date_performed DATE,
  FOREIGN KEY (researchers_id) REFERENCES Researchers(researchers_id),
  FOREIGN KEY (sample_id) REFERENCES Samples(sample_id),
  FOREIGN KEY (instrument_id) REFERENCES Instruments(instrument_id),
  FOREIGN KEY (reagent_id) REFERENCES Reagents(reagent_id)
);

INSERT INTO Experiments (experiment_name, researchers_id, sample_id, instrument_id, reagent_id, date_performed)
VALUES
('Antimicrobial Activity Test', 1, 1, 1, 1, '2025-10-03'),
('Gram Staining', 2, 3, 3, 4, '2025-09-27'),
('Total Plate Count', 3, 2, 4, 2, '2025-09-29'),
('MIC Determination', 4, 4, 5, 5, '2025-10-05'),
('Postbiotic Efficacy Test', 5, 5, 1, 3, '2025-10-06');


CREATE TABLE Results (
  result_id INT PRIMARY KEY AUTO_INCREMENT,
  experiment_id INT,
  microbial_status VARCHAR(20) CHECK (microbial_status IN ('Detected', 'Not Detected')),
  remarks VARCHAR(255),
  FOREIGN KEY (experiment_id) REFERENCES Experiments(experiment_id)
);

INSERT INTO Results (experiment_id, microbial_status, remarks)
VALUES
(1, 'Detected', 'Bacillus spp. observed; moderate growth'),
(2, 'Not Detected', 'No Gram-negative bacteria found'),
(3, 'Detected', 'High bacterial load — not safe for use'),
(4, 'Detected', 'MIC value within safe limit; good antimicrobial activity'),
(5, 'Not Detected', 'Postbiotic shows complete inhibition of pathogens');
select*from researchers;
select * from researchers where project_name="Fermented Pomegranate Peel-Derived Prebiotic"; 
select e.experiment_name,e.date_performed,r.researcher_name,r.project_duration from experiments e join researchers r
on r.researchers_id=e.researchers_id where r.project_name= "Pumpkin Pulp Fermentation Study";
select researcher_name,researcher_role from researchers;
select * from researchers where researcher_name like 'R%';
select reagent_name, stock_quantity from reagents where stock_quantity < 20;
select experiment_name, date_performed from experiments where date_performed between '2025-10-01' and '2025-10-31';
select e.experiment_name, r.researcher_name from experiments e join researchers r on e.researchers_id= r.researchers_id;
select e.experiment_name,s.sample_name,i.instrument_name from experiments e join samples s on e.sample_id=s.sample_id join instruments i on e.instrument_id=i.instrument_id;
select r.researcher_name, e.experiment_name, res.microbial_status from results res join experiments e on res. experiment_id=e.experiment_id join researchers r on e. researchers_id = r.researchers_id;
select microbial_status, count(*) as total from results group by microbial_status;
select r.researcher_name,count(e.experiment_id) as total_experiments from researchers r join experiments e on r.researchers_id=e.researchers_id group by r.researcher_name;
select instrument_name, purchase_date from instruments order by purchase_date asc limit 1;
select researcher_name from researchers where researchers_id=( select researchers_id from experiments where experiment_name = 'Antimicrobial Activity Test');
INSERT into reagents (reagent_name, reagent_type,expiry_date, stock_quantity) values ('Lactic Acid', 'Chemical', '2027-06-01', 30);
