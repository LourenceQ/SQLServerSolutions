-- phpMyAdmin SQL Dump
-- version 5.0.4deb2
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Generation Time: Mar 30, 2022 at 07:52 PM
-- Server version: 10.5.12-MariaDB-0+deb11u1
-- PHP Version: 7.4.28

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `dbp_class`
--

-- --------------------------------------------------------

--
-- Table structure for table `cities`
--

CREATE TABLE `cities` (
  `id` int(11) NOT NULL,
  `name` varchar(30) DEFAULT NULL,
  `sigla` varchar(2) DEFAULT NULL,
  `state_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `cities`
--

INSERT INTO `cities` (`id`, `name`, `sigla`, `state_id`) VALUES
(1, 'Teófilo Otoni', 'TO', 1),
(2, 'Governador Valadares', 'GV', 1),
(3, 'Barueri', 'BU', 2),
(4, 'Salvador', 'SA', 3);

-- --------------------------------------------------------

--
-- Table structure for table `states`
--

CREATE TABLE `states` (
  `id` int(11) NOT NULL,
  `name` varchar(20) DEFAULT NULL,
  `sigla` varchar(2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `states`
--

INSERT INTO `states` (`id`, `name`, `sigla`) VALUES
(1, 'Minas Gerais', 'MG'),
(2, 'Sao Paulo', 'SP'),
(3, 'Bahia', 'BA');

-- --------------------------------------------------------

--
-- Table structure for table `students`
--

CREATE TABLE `students` (
  `id` int(11) NOT NULL,
  `name` varchar(80) DEFAULT NULL,
  `birthday` date DEFAULT NULL,
  `email` varchar(80) DEFAULT NULL,
  `cpf` varchar(11) DEFAULT NULL,
  `matricula` varchar(10) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `students`
--

INSERT INTO `students` (`id`, `name`, `birthday`, `email`, `cpf`, `matricula`, `created_at`) VALUES
(1, 'Aluno igual', '2005-10-16', 'email@gmail.com', '1234554', '654321', '2022-03-16 22:31:02'),
(3, 'Aluno 2', '1988-05-25', 'mais@gmail.com', '123', NULL, '2022-03-16 22:31:02'),
(4, 'Aluno 3', '1988-10-01', NULL, '1234', '654321', '2022-03-16 22:31:02'),
(5, 'Aluno 4', '2010-08-10', NULL, '12345', NULL, '2022-03-16 22:31:02'),
(6, 'Aluno 5', '2000-12-05', 'outroemail@teste.com', '123457', NULL, '2022-03-16 22:31:02'),
(7, 'Aluno 6', '2005-10-16', NULL, '1234570', '654321', '2022-03-16 22:31:02'),
(8, 'Aluno 7', '2007-03-25', NULL, NULL, NULL, '2022-03-16 22:32:28');

-- --------------------------------------------------------

--
-- Table structure for table `students_addresses`
--

CREATE TABLE `students_addresses` (
  `id` int(11) NOT NULL,
  `street` varchar(30) DEFAULT NULL,
  `number` varchar(5) DEFAULT NULL,
  `neighborhood` varchar(30) DEFAULT NULL,
  `complement` varchar(15) DEFAULT NULL,
  `cep` varchar(9) DEFAULT NULL,
  `city_id` int(11) DEFAULT NULL,
  `student_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `students_addresses`
--

INSERT INTO `students_addresses` (`id`, `street`, `number`, `neighborhood`, `complement`, `cep`, `city_id`, `student_id`) VALUES
(1, 'Rua teste', '12', 'Bairro nao sei', 'casa', '39800645', 1, 1),
(2, 'Israel Pinheiro', '25', 'nenhuma', 'Ap', '3980000', 2, 3),
(3, '13 de março', '55', 'Novo bairro', 'casa', '39000-123', 3, 7),
(4, 'Novo endereco', '58', 'Felicidade', 'Casa', '39800058', 1, 1),
(5, '13 de março', '55', 'Novo bairro', 'casa', '39000-123', 3, 7);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `cities`
--
ALTER TABLE `cities`
  ADD PRIMARY KEY (`id`),
  ADD KEY `state_id` (`state_id`);

--
-- Indexes for table `states`
--
ALTER TABLE `states`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `students`
--
ALTER TABLE `students`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `cpf` (`cpf`);

--
-- Indexes for table `students_addresses`
--
ALTER TABLE `students_addresses`
  ADD PRIMARY KEY (`id`),
  ADD KEY `student_id` (`student_id`),
  ADD KEY `city_id` (`city_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `cities`
--
ALTER TABLE `cities`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `states`
--
ALTER TABLE `states`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `students`
--
ALTER TABLE `students`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `students_addresses`
--
ALTER TABLE `students_addresses`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `cities`
--
ALTER TABLE `cities`
  ADD CONSTRAINT `cities_ibfk_1` FOREIGN KEY (`state_id`) REFERENCES `states` (`id`);

--
-- Constraints for table `students_addresses`
--
ALTER TABLE `students_addresses`
  ADD CONSTRAINT `students_addresses_ibfk_1` FOREIGN KEY (`student_id`) REFERENCES `students` (`id`),
  ADD CONSTRAINT `students_addresses_ibfk_2` FOREIGN KEY (`city_id`) REFERENCES `cities` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;


-----------------------
SELECT
    students.id,
    students.matricula,
    students.name,
    students_addresses.street,
    students_addresses.neighborhood,
    cities.name,
    states.sigla
FROM
    students,
    students_addresses,
    cities,
    states
WHERE
	students.id IN(1,3)
    AND students.id = students_addresses.student_id
    AND students_addresses.city_id=cities.id
    AND cities.state_id=states.id

-----
SELECT
    students.id,
    students.matricula,
    students.name,
    students_addresses.street,
    students_addresses.neighborhood,
    cities.name,
    states.sigla
FROM
    students,
    students_addresses,
    cities,
    states
WHERE
    students.id = students_addresses.student_id
    AND students_addresses.city_id=cities.id
    AND cities.state_id=states.id
    AND students_addresses.neighborhood like '%bairro%';   

	SELECT
    students.id,
	students.matricula,
from student

join student
on student_address.id = students.id
where student_addess.id count(*) > 2 

select students.id,
	count(students_address.id) as totalAdress
from students
from students
where count(students_address.id) > 2

select	students.name
		, count(students_address.id)
from	studentes
join	studentes_address
on		students.id = studentes_address.id
group by	students.name
			, studentes_address.id

-----
SELECT
    students.name,
    COUNT(students_addresses.id)
FROM
    students
	JOIN students_addresses ON students.id = students_addresses.student_id
GROUP BY
    students.name

-------
SELECT
    students.name,
    COUNT(students_addresses.id) as totalAdresses
FROM
    students,
    students_addresses
WHERE
    students.id = students_addresses.student_id
    group by students.id
----
SELECT
    students.name,
    COUNT(students_addresses.id) as totalAdresses
FROM
    students
	JOIN students_addresses ON students.id = students_addresses.student_id
where totalAdresses > 2
GROUP BY
    students.name


------
SELECT
    students.name,
    COUNT(students_addresses.id)
FROM
    students,
    students_addresses
WHERE
    students.id = students_addresses.student_id
    group by students.id
    HAVING COUNT(students_addresses.id) > 1


