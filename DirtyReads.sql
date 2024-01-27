﻿USE CompanieTelefonicaBD;

-- Dirty Reads – Când un cititor citește date necomise

GO
BEGIN TRAN;
UPDATE Clienti SET tip_client = 'Cu abonament' WHERE numar_telefon = 741561421;
WAITFOR DELAY '00:00:07';
ROLLBACK TRAN;

GO
SET TRANSACTION ISOLATION LEVEL READ
UNCOMMITTED
BEGIN TRAN
SELECT * FROM Clienti
WAITFOR DELAY '00:00:15'
SELECT * FROM Clienti
COMMIT TRAN

GO
SELECT * FROM Angajati;
SELECT * FROM Clienti;
SELECT * FROM Cereri;

-- Solution: SET TRANSACTION ISOLATION LEVEL TO READ COMMITTED
GO
SET TRANSACTION ISOLATION LEVEL READ COMMITTED
BEGIN TRAN
SELECT * FROM Clienti
WAITFOR DELAY '00:00:15'
SELECT * FROM Clienti
COMMIT TRAN