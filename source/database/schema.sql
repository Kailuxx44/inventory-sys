-- SQLite database schema for gym inventory management
DROP TABLE IF EXISTS Issue;
DROP TABLE IF EXISTS Inventory;
DROP TABLE IF EXISTS User;
DROP TABLE IF EXISTS Category;
DROP TABLE IF EXISTS UserRole;

PRAGMA foreign_keys = ON;

CREATE TABLE UserRole (
    userRoleID INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT NOT NULL
);

CREATE TABLE Category (
    categoryID INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT NOT NULL UNIQUE
);

CREATE TABLE User (
    userID INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT NOT NULL,
    surname TEXT NOT NULL,
    patronymic TEXT,
    login TEXT NOT NULL UNIQUE,
    passwordHash TEXT NOT NULL,
    userRole INTEGER NOT NULL,
    FOREIGN KEY (userRole) REFERENCES UserRole(userRoleID) ON DELETE RESTRICT
);

CREATE TABLE Inventory (
    inventoryID INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT NOT NULL,
    inventoryNumber TEXT NOT NULL UNIQUE,
    categoryID INTEGER NOT NULL,
    quantity INTEGER NOT NULL DEFAULT 1 CHECK (quantity >= 0),
    storagePlace TEXT NOT NULL,
    isUsable INTEGER NOT NULL DEFAULT 1 CHECK (isUsable IN (0, 1)),
    dateAdded TEXT NOT NULL,
    note TEXT,
    FOREIGN KEY (categoryID) REFERENCES Category(categoryID) ON DELETE RESTRICT
);

CREATE TABLE Issue (
    issueID INTEGER PRIMARY KEY AUTOINCREMENT,
    InventoryID INTEGER NOT NULL,
    userID INTEGER NOT NULL,
    issuedAt TEXT NOT NULL,
    FOREIGN KEY (InventoryID) REFERENCES Inventory(inventoryID) ON DELETE CASCADE,
    FOREIGN KEY (userID) REFERENCES User(userID) ON DELETE CASCADE
);

INSERT INTO UserRole (name) VALUES 
('Администратор'), 
('Тренер');

INSERT INTO Category (name) VALUES 
('Свободные веса'), 
('Кардиооборудование'), 
('Фитнес-аксессуары'),
('Силовые тренажеры'), 
('Функциональные тренажеры');

INSERT INTO User (name, surname, patronymic, login, passwordHash, userRole) VALUES 
('Алексей', 'Смирнов', 'Сергеевич', 'admin_gym', 'hash_admin_123', 1),
('Дмитрий', 'Кузнецов', 'Игоревич', 'd_kuznetsov', 'hash_coach_456', 2);

INSERT INTO Inventory (name, inventoryNumber, categoryID, quantity, storagePlace, isUsable, dateAdded, note) VALUES 
('Набор гантелей (10-30 кг)', 'GYM-001', 1, 1, 'Зона свободных весов', 1, '2026-09-01 10:00:00', 'Состояние новое'),
('Беговая дорожка Pro-Fitness 500', 'GYM-002', 2, 4, 'Кардио-зона', 1, '2026-09-11 11:30:00', 'Проведено ТО'),
('Резинки для фитнеса (комплект)', 'GYM-003', 3, 15, 'Склад №1', 1, '2026-10-10 12:00:00', 'Новый комплект'),
('Силовой тренажер для жима ногами"', 'GYM-004', 4, 2, 'Зона силовых тренажеров', 1, '2026-10-15 14:00:00', 'Требуется смазка'),
('Функциональный тренажер TRX', 'GYM-005', 5, 5, 'Функциональная зона', 1, '2026-10-20 09:00:00', 'Используется');

INSERT INTO Issue (InventoryID, userID, issuedAt) VALUES 
(3, 2, '2026-10-21 15:00:00');