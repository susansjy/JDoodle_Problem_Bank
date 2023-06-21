-- Adminer 4.8.1 MySQL 8.0.32 dump

SET NAMES utf8;
SET time_zone = '+00:00';
SET foreign_key_checks = 0;
SET sql_mode = 'NO_AUTO_VALUE_ON_ZERO';

SET NAMES utf8mb4;

DROP DATABASE IF EXISTS `jdoodle`;
CREATE DATABASE `jdoodle` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `jdoodle`;

DROP TABLE IF EXISTS `answers`;
CREATE TABLE `answers` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `questionId` int unsigned NOT NULL,
  `answer` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `username` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime DEFAULT NULL,
  `deletedAt` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `questionId` (`questionId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


DROP TABLE IF EXISTS `questionTestCases`;
CREATE TABLE `questionTestCases` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `questionId` int unsigned NOT NULL,
  `code` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime DEFAULT NULL,
  `deletedAt` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `questionId` (`questionId`),
  CONSTRAINT `questionTestCases_ibfk_1` FOREIGN KEY (`questionId`) REFERENCES `questions` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

INSERT INTO `questionTestCases` (`id`, `questionId`, `code`, `createdAt`, `updatedAt`, `deletedAt`) VALUES
(1,	1,	'console.log(sum(3, 5) === 8)',	'2023-06-20 11:23:21',	'2023-06-20 11:23:21',	NULL),
(2,	1,	'console.log(sum(-2, 10) === 8)',	'2023-06-20 11:23:21',	'2023-06-20 11:23:21',	NULL),
(3,	1,	'console.log(sum(0, 0) === 0)',	'2023-06-20 11:23:21',	'2023-06-20 11:23:21',	NULL),
(4,	1,	'console.log(sum(-5, -7) === -12)',	'2023-06-20 11:23:21',	'2023-06-20 11:23:21',	NULL),
(5,	1,	'console.log(sum(100, -100) === 0)',	'2023-06-20 11:23:21',	'2023-06-20 11:23:21',	NULL),
(6,	2,	'console.log(palindrome(\"racecar\") === true)',	'2023-06-20 11:23:21',	'2023-06-20 11:23:21',	NULL),
(7,	2,	'console.log(palindrome(\"hello\") === false)',	'2023-06-20 11:23:21',	'2023-06-20 11:23:21',	NULL),
(8,	2,	'console.log(palindrome(\"level\") === true)',	'2023-06-20 11:23:21',	'2023-06-20 11:23:21',	NULL),
(9,	2,	'console.log(palindrome(\"madam\") === true)',	'2023-06-20 11:23:21',	'2023-06-20 11:23:21',	NULL),
(10,	2,	'console.log(palindrome(\"python\") === false)',	'2023-06-20 11:23:21',	'2023-06-20 11:23:21',	NULL),
(11,	3,	'console.log(max([3, 8, 2, 10, 5]) === 10)',	'2023-06-20 11:23:21',	'2023-06-20 11:23:21',	NULL),
(12,	3,	'console.log(max([-5, -10, -2, -7]) === -2)',	'2023-06-20 11:23:21',	'2023-06-20 11:23:21',	NULL),
(13,	3,	'console.log(max([1, 1, 1, 1]) === 1)',	'2023-06-20 11:23:21',	'2023-06-20 11:23:21',	NULL),
(14,	3,	'console.log(max([0, 0, 0, 0]) === 0)',	'2023-06-20 11:23:21',	'2023-06-20 11:23:21',	NULL),
(15,	3,	'console.log(max([100, 50, 75, 200]) === 200)',	'2023-06-20 11:23:21',	'2023-06-20 11:23:21',	NULL),
(16,	4,	'console.log(factorial(5) === 120)',	'2023-06-20 11:23:21',	'2023-06-20 11:23:21',	NULL),
(17,	4,	'console.log(factorial(0) === 1)',	'2023-06-20 11:23:21',	'2023-06-20 11:23:21',	NULL),
(18,	4,	'console.log(factorial(1) === 1)',	'2023-06-20 11:23:21',	'2023-06-20 11:23:21',	NULL),
(19,	4,	'console.log(factorial(10) === 3628800)',	'2023-06-20 11:23:21',	'2023-06-20 11:23:21',	NULL),
(20,	4,	'console.log(factorial(7) === 5040)',	'2023-06-20 11:23:21',	'2023-06-20 11:23:21',	NULL),
(21,	5,	'console.log(prime(7) === true)',	'2023-06-20 11:23:21',	'2023-06-20 11:23:21',	NULL),
(22,	5,	'console.log(prime(12) === false)',	'2023-06-20 11:23:21',	'2023-06-20 11:23:21',	NULL),
(23,	5,	'console.log(prime(2) === true)',	'2023-06-20 11:23:21',	'2023-06-20 11:23:21',	NULL),
(24,	5,	'console.log(prime(31) === true)',	'2023-06-20 11:23:21',	'2023-06-20 11:23:21',	NULL),
(25,	5,	'console.log(prime(9) === false)',	'2023-06-20 11:23:21',	'2023-06-20 11:23:21',	NULL),
(26,	6,	'console.log(reverse(\"hello\") === \"olleh\")',	'2023-06-20 11:23:21',	'2023-06-20 11:23:21',	NULL),
(27,	6,	'console.log(reverse(\"python\") === \"nohtyp\")',	'2023-06-20 11:23:21',	'2023-06-20 11:23:21',	NULL),
(28,	6,	'console.log(reverse(\"racecar\") === \"racecar\")',	'2023-06-20 11:23:21',	'2023-06-20 11:23:21',	NULL),
(29,	6,	'console.log(reverse(\"world\") === \"dlrow\")',	'2023-06-20 11:23:21',	'2023-06-20 11:23:21',	NULL),
(30,	6,	'console.log(reverse(\"programming\") === \"gnimmargorp\")',	'2023-06-20 11:23:21',	'2023-06-20 11:23:21',	NULL),
(31,	7,	'console.log(average([4, 6, 8, 10]) === 7)',	'2023-06-20 11:23:21',	'2023-06-20 11:23:21',	NULL),
(32,	7,	'console.log(average([1, 2, 3, 4, 5]) === 3)',	'2023-06-20 11:23:21',	'2023-06-20 11:23:21',	NULL),
(33,	7,	'console.log(average([0]) === 0)',	'2023-06-20 11:23:21',	'2023-06-20 11:23:21',	NULL),
(34,	7,	'console.log(average([-10, 0, 10]) === 0)',	'2023-06-20 11:23:21',	'2023-06-20 11:23:21',	NULL),
(35,	7,	'console.log(average([100, 200, 300]) === 200)',	'2023-06-20 11:23:21',	'2023-06-20 11:23:21',	NULL),
(36,	8,	'console.log(vowels(\"Hello World\") === 3)',	'2023-06-20 11:23:21',	'2023-06-20 11:23:21',	NULL),
(37,	8,	'console.log(vowels(\"OpenAI\") === 3)',	'2023-06-20 11:23:21',	'2023-06-20 11:23:21',	NULL),
(38,	8,	'console.log(vowels(\"Python Programming\") === 4)',	'2023-06-20 11:23:21',	'2023-06-20 11:23:21',	NULL),
(39,	8,	'console.log(vowels(\"aeiou\") === 5)',	'2023-06-20 11:23:21',	'2023-06-20 11:23:21',	NULL),
(40,	8,	'console.log(vowels(\"qwrtypsdfghjklzxcvbnm\") === 0)',	'2023-06-20 11:23:21',	'2023-06-20 11:23:21',	NULL),
(41,	9,	'console.log(anagrams(\"listen\", \"silent\") === true)',	'2023-06-20 11:23:21',	'2023-06-20 11:23:21',	NULL),
(42,	9,	'console.log(anagrams(\"hello\", \"world\") === false)',	'2023-06-20 11:23:21',	'2023-06-20 11:23:21',	NULL),
(43,	9,	'console.log(anagrams(\"rail safety\", \"fairy tales\") === true)',	'2023-06-20 11:23:21',	'2023-06-20 11:23:21',	NULL),
(44,	9,	'console.log(anagrams(\"python\", \"typhon\") === true)',	'2023-06-20 11:23:21',	'2023-06-20 11:23:21',	NULL),
(45,	9,	'console.log(anagrams(\"abc\", \"def\") === false)',	'2023-06-20 11:23:21',	'2023-06-20 11:23:21',	NULL),
(46,	10,	'console.log(second([5, 2, 9, 3, 7]) === 7)',	'2023-06-20 11:23:21',	'2023-06-20 11:23:21',	NULL),
(47,	10,	'console.log(second([10, 5, 8, 2]) === 8)',	'2023-06-20 11:23:21',	'2023-06-20 11:23:21',	NULL),
(48,	10,	'console.log(second([1, 1, 1]) === 1)',	'2023-06-20 11:23:21',	'2023-06-20 11:23:21',	NULL),
(49,	10,	'console.log(second([-5, -10, -2]) === -5)',	'2023-06-20 11:23:21',	'2023-06-20 11:23:21',	NULL),
(50,	10,	'console.log(second([100, 200, 50, 300]) === 200)',	'2023-06-20 11:23:21',	'2023-06-20 11:23:21',	NULL);

DROP TABLE IF EXISTS `questions`;
CREATE TABLE `questions` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `functionName` varchar(32) NOT NULL,
  `detail` text NOT NULL,
  `placeholder` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime DEFAULT NULL,
  `deletedAt` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

INSERT INTO `questions` (`id`, `functionName`, `detail`, `placeholder`, `createdAt`, `updatedAt`, `deletedAt`) VALUES
(1,	'sum',	'Calculate the sum of two integers',	'const sum = (number1, number2) => 0',	'2023-06-20 11:23:21',	'2023-06-20 11:23:21',	NULL),
(2,	'palindrome',	'Check if a given string is a palindrome',	'const palindrome = (string) => true',	'2023-06-20 11:23:21',	'2023-06-20 11:23:21',	NULL),
(3,	'max',	'Find the maximum number in a list',	'const max = (numberArray) => 0',	'2023-06-20 11:23:21',	'2023-06-20 11:23:21',	NULL),
(4,	'factorial',	'Calculate the factorial of a number',	'const factorial = (number) => 0',	'2023-06-20 11:23:21',	'2023-06-20 11:23:21',	NULL),
(5,	'prime',	'Check if a number is prime',	'const prime = (number) => true',	'2023-06-20 11:23:21',	'2023-06-20 11:23:21',	NULL),
(6,	'reverse',	'Reverse a string',	'const reverse = (string) => \"\"',	'2023-06-20 11:23:21',	'2023-06-20 11:23:21',	NULL),
(7,	'average',	'Calculate the average of numbers in a list',	'const average = (numberArray) => 0',	'2023-06-20 11:23:21',	'2023-06-20 11:23:21',	NULL),
(8,	'vowels',	'Count the number of vowels in a string',	'const vowels = (string) => 0',	'2023-06-20 11:23:21',	'2023-06-20 11:23:21',	NULL),
(9,	'anagrams',	'Check if two strings are anagrams (contain the same characters in any order)',	'const anagrams = (string1, string2) => true',	'2023-06-20 11:23:21',	'2023-06-20 11:23:21',	NULL),
(10,	'second',	'Find the second largest number in a list.',	'const second = (numberArray) => 0',	'2023-06-20 11:23:21',	'2023-06-20 11:23:21',	NULL);

-- 2023-06-21 02:20:09
