-- phpMyAdmin SQL Dump
-- version 4.8.1
-- https://www.phpmyadmin.net/
--
-- Хост: 127.0.0.1
-- Время создания: Июл 10 2018 г., 15:05
-- Версия сервера: 10.1.33-MariaDB
-- Версия PHP: 7.2.6

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- База данных: `mainbase`
--
CREATE DATABASE IF NOT EXISTS `mainbase` DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci;
USE `mainbase`;

DELIMITER $$
--
-- Процедуры
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `add_log` (IN `msg` VARCHAR(255), IN `time` VARCHAR(255), IN `myCoef` VARCHAR(255))  NO SQL
BEGIN
SET @tmpId = 0;
SELECT id INTO @tmpId FROM maintable WHERE sysOfEq = myCoef;
INSERT INTO logstable VALUES (@tmpId, msg, time);
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `add_sys` (IN `sys` VARCHAR(128) CHARSET utf8, IN `res` VARCHAR(128) CHARSET utf8)  NO SQL
INSERT INTO maintable VALUES(0, sys, res)$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Структура таблицы `logstable`
--

CREATE TABLE `logstable` (
  `id` int(11) UNSIGNED NOT NULL,
  `message` varchar(128) DEFAULT NULL,
  `errTime` varchar(128) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Содержит id СЛАУ, строку с логами,время возникновения ошибки';

-- --------------------------------------------------------

--
-- Структура таблицы `maintable`
--

CREATE TABLE `maintable` (
  `id` int(11) UNSIGNED NOT NULL,
  `sysOfEq` varchar(128) DEFAULT NULL,
  `solution` varchar(128) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Таблица содержит id СЛАУ, саму СЛАУ, её решение';

--
-- Индексы сохранённых таблиц
--

--
-- Индексы таблицы `logstable`
--
ALTER TABLE `logstable`
  ADD KEY `id` (`id`);

--
-- Индексы таблицы `maintable`
--
ALTER TABLE `maintable`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `id` (`id`),
  ADD UNIQUE KEY `sysOfEq` (`sysOfEq`),
  ADD UNIQUE KEY `equation` (`solution`);

--
-- AUTO_INCREMENT для сохранённых таблиц
--

--
-- AUTO_INCREMENT для таблицы `maintable`
--
ALTER TABLE `maintable`
  MODIFY `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- Ограничения внешнего ключа сохраненных таблиц
--

--
-- Ограничения внешнего ключа таблицы `logstable`
--
ALTER TABLE `logstable`
  ADD CONSTRAINT `logstable_ibfk_1` FOREIGN KEY (`id`) REFERENCES `maintable` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
