DELIMITER $$

CREATE TRIGGER cek_kapasitas_konser
BEFORE INSERT ON Pemesanan
FOR EACH ROW
BEGIN
    DECLARE total_tiket_terpesan INT;
    DECLARE kapasitas_konser INT;

    -- Hitung total tiket yang sudah dipesan untuk konser tertentu
    SELECT SUM(t.jumlah_tiket)
    INTO total_tiket_terpesan
    FROM Pemesanan p
    JOIN Tiket t ON p.id_tiket = t.id_tiket
    WHERE t.id_konser = (SELECT id_konser FROM Tiket WHERE id_tiket = NEW.id_tiket);

    -- Ambil kapasitas maksimal dari konser yang bersangkutan
    SELECT kapasitas_max
    INTO kapasitas_konser
    FROM Konser
    WHERE id_konser = (SELECT id_konser FROM Tiket WHERE id_tiket = NEW.id_tiket);

    -- Jika jumlah tiket yang dipesan melebihi kapasitas konser, batalkan insert
    IF total_tiket_terpesan + (SELECT jumlah_tiket FROM Tiket WHERE id_tiket = NEW.id_tiket) > kapasitas_konser THEN
        SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = 'Jumlah tiket melebihi kapasitas konser';
    END IF;
END$$

DELIMITER ;