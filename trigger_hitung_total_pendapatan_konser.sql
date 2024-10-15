DELIMITER $$

CREATE PROCEDURE hitung_total_pendapatan_konser (IN konser_id INT)
BEGIN
    DECLARE total_pendapatan INT DEFAULT 0;

    -- Hitung total pendapatan berdasarkan jumlah tiket yang telah dipesan dan harga tiket
    SELECT SUM(t.jumlah_tiket * t.harga_tiket)
    INTO total_pendapatan
    FROM Tiket t
    JOIN Pemesanan p ON t.id_tiket = p.id_tiket
    WHERE t.id_konser = konser_id;

    -- Tampilkan hasil total pendapatan
    SELECT total_pendapatan AS 'Total Pendapatan';

END$$

DELIMITER ;