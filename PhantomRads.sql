﻿USE CompanieTelefonicaBD;

-- Phantom Reads - Când sunt adăugate noi înregistrări și apar în cadrul unei tranzacții

GO
BEGIN TRAN
WAITFOR DELAY '00:00:04'
INSERT INTO Clienti values(32, 102, 'Fara abonament', 'Turcu', 'Ioana', 744003789)
COMMIT TRAN

GO
SET TRANSACTION ISOLATION LEVEL REPEATABLE
READ
BEGIN TRAN
SELECT * FROM Clienti
WAITFOR DELAY '00:00:05'
SELECT * FROM Clienti
COMMIT TRAN

-- Solution: SET TRANSACTION ISOLATION LEVEL SERIALIZABLE
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE
BEGIN TRAN
SELECT * FROM Clienti
WAITFOR DELAY '00:00:05'
SELECT * FROM Clienti
COMMIT TRAN

GO
SELECT * FROM Angajati;
SELECT * FROM Clienti;
SELECT * FROM Cereri;