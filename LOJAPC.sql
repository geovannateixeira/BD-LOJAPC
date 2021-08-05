-- phpMyAdmin SQL Dump
-- version 4.9.7deb1
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Tempo de geração: 04/08/2021 às 12:28
-- Versão do servidor: 8.0.26-0ubuntu0.21.04.3
-- Versão do PHP: 7.4.16

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Banco de dados: `LOJAPC`
--

-- --------------------------------------------------------

--
-- Estrutura para tabela `COMPRAS`
--

CREATE TABLE `COMPRAS` (
  `COD_PRODUTO` int DEFAULT NULL,
  `NOME_PROD` varchar(25) DEFAULT NULL,
  `QUANTIDADE_PROD` int DEFAULT NULL,
  `NOTA_FISCAL` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Estrutura para tabela `CUPOM`
--

CREATE TABLE `CUPOM` (
  `NUMERO_CUPOM` varchar(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Estrutura para tabela `FUNC`
--

CREATE TABLE `FUNC` (
  `NOME` varchar(25) NOT NULL,
  `SOBRENOME` varchar(25) NOT NULL,
  `EMAIL` varchar(25) NOT NULL,
  `CPF` int NOT NULL,
  `CARGO` varchar(25) NOT NULL,
  `SALARIO` float(8,2) NOT NULL,
  `DATA_ADM` date NOT NULL,
  `COD_FUNC` int NOT NULL,
  `LOGIN` varchar(25) NOT NULL,
  `COD_NOTA` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Estrutura para tabela `NOTA_FISCAL`
--

CREATE TABLE `NOTA_FISCAL` (
  `COD_ID` int NOT NULL,
  `COD_FUNC` int NOT NULL,
  `COD_PROD` int NOT NULL,
  `NOME_PROD` varchar(25) NOT NULL,
  `DESCRICAO_PROD` varchar(25) NOT NULL,
  `PRECO` float(5,2) NOT NULL,
  `NOME_CLIENTE` varchar(25) DEFAULT NULL,
  `CPF_CLIENTE` int DEFAULT NULL,
  `CUPOM` varchar(10) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Estrutura para tabela `PAGAMENTOS`
--

CREATE TABLE `PAGAMENTOS` (
  `SALARIO_FUNC` float(8,2) NOT NULL,
  `PAGAR_PARCERIA` float(5,2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Estrutura para tabela `PRODUTO`
--

CREATE TABLE `PRODUTO` (
  `NOME_PRODUTO` varchar(25) NOT NULL,
  `COD_PRODUTO` int NOT NULL,
  `PRECO` float(5,2) NOT NULL,
  `DESCRICAO` varchar(45) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Estrutura para tabela `USUARIO`
--

CREATE TABLE `USUARIO` (
  `NOME` varchar(25) NOT NULL,
  `SOBRENOME` varchar(25) NOT NULL,
  `EMAIL` varchar(25) NOT NULL,
  `CPF` int NOT NULL,
  `ENDERECO` varchar(25) NOT NULL,
  `CELULAR` int NOT NULL,
  `DATA_NASC` date DEFAULT NULL,
  `NUM_CUPOM` varchar(10) DEFAULT NULL,
  `COMPRA` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Índices para tabelas despejadas
--

--
-- Índices de tabela `COMPRAS`
--
ALTER TABLE `COMPRAS`
  ADD KEY `COD_PRODUTO` (`COD_PRODUTO`),
  ADD KEY `NOTA_FISCAL` (`NOTA_FISCAL`);

--
-- Índices de tabela `CUPOM`
--
ALTER TABLE `CUPOM`
  ADD PRIMARY KEY (`NUMERO_CUPOM`);

--
-- Índices de tabela `FUNC`
--
ALTER TABLE `FUNC`
  ADD PRIMARY KEY (`COD_FUNC`),
  ADD KEY `SALARIO` (`SALARIO`);

--
-- Índices de tabela `NOTA_FISCAL`
--
ALTER TABLE `NOTA_FISCAL`
  ADD PRIMARY KEY (`COD_ID`),
  ADD KEY `COD_FUNC` (`COD_FUNC`),
  ADD KEY `COD_PROD` (`COD_PROD`),
  ADD KEY `CPF_CLIENTE` (`CPF_CLIENTE`),
  ADD KEY `CUPOM` (`CUPOM`);

--
-- Índices de tabela `PAGAMENTOS`
--
ALTER TABLE `PAGAMENTOS`
  ADD PRIMARY KEY (`SALARIO_FUNC`);

--
-- Índices de tabela `PRODUTO`
--
ALTER TABLE `PRODUTO`
  ADD PRIMARY KEY (`COD_PRODUTO`);

--
-- Índices de tabela `USUARIO`
--
ALTER TABLE `USUARIO`
  ADD PRIMARY KEY (`CPF`),
  ADD KEY `NUM_CUPOM` (`NUM_CUPOM`);

--
-- Restrições para tabelas despejadas
--

--
-- Restrições para tabelas `COMPRAS`
--
ALTER TABLE `COMPRAS`
  ADD CONSTRAINT `COMPRAS_ibfk_1` FOREIGN KEY (`COD_PRODUTO`) REFERENCES `PRODUTO` (`COD_PRODUTO`),
  ADD CONSTRAINT `COMPRAS_ibfk_2` FOREIGN KEY (`NOTA_FISCAL`) REFERENCES `NOTA_FISCAL` (`COD_ID`);

--
-- Restrições para tabelas `FUNC`
--
ALTER TABLE `FUNC`
  ADD CONSTRAINT `FUNC_ibfk_1` FOREIGN KEY (`SALARIO`) REFERENCES `PAGAMENTOS` (`SALARIO_FUNC`);

--
-- Restrições para tabelas `NOTA_FISCAL`
--
ALTER TABLE `NOTA_FISCAL`
  ADD CONSTRAINT `NOTA_FISCAL_ibfk_1` FOREIGN KEY (`COD_FUNC`) REFERENCES `FUNC` (`COD_FUNC`),
  ADD CONSTRAINT `NOTA_FISCAL_ibfk_2` FOREIGN KEY (`COD_PROD`) REFERENCES `PRODUTO` (`COD_PRODUTO`),
  ADD CONSTRAINT `NOTA_FISCAL_ibfk_3` FOREIGN KEY (`CPF_CLIENTE`) REFERENCES `USUARIO` (`CPF`),
  ADD CONSTRAINT `NOTA_FISCAL_ibfk_4` FOREIGN KEY (`CUPOM`) REFERENCES `CUPOM` (`NUMERO_CUPOM`);

--
-- Restrições para tabelas `USUARIO`
--
ALTER TABLE `USUARIO`
  ADD CONSTRAINT `USUARIO_ibfk_1` FOREIGN KEY (`NUM_CUPOM`) REFERENCES `CUPOM` (`NUMERO_CUPOM`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
