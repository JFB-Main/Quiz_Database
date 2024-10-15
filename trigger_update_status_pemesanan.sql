DELIMITER $$

CREATE TRIGGER update_status_pemesanan
AFTER INSERT ON Pembayaran
FOR EACH ROW
BEGIN
    DECLARE total_harga_tiket INT DEFAULT 0;
    DECLARE total_pembayaran INT DEFAULT 0;

    -- Ambil total harga tiket yang dipesan dari tabel Tiket berdasarkan id_pemesanan
    SELECT SUM(t.harga_tiket * t.jumlah_tiket)
    INTO total_harga_tiket
    FROM Tiket t
    JOIN Pemesanan p ON t.id_tiket = p.id_tiket
    WHERE p.id_pemesanan = NEW.id_pemesanan;

    -- Ambil total pembayaran yang sudah dilakukan untuk id_pemesanan terkait
    SELECT SUM(pem.jumlah_pembayaran)
    INTO total_pembayaran
    FROM Pembayaran pem
    WHERE pem.id_pemesanan = NEW.id_pemesanan;

    -- Jika total pembayaran sama atau lebih besar dari total harga tiket, update status menjadi 'lunas'
    IF total_pembayaran >= total_harga_tiket THEN
        UPDATE Pemesanan
        SET status_pemesanan = 'lunas'
        WHERE id_pemesanan = NEW.id_pemesanan;
    END IF;
END$$