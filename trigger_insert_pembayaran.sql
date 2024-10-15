DELIMITER $$

CREATE TRIGGER insert_pembayaran
AFTER INSERT ON Pemesanan
FOR EACH ROW
BEGIN
    DECLARE harga_tiket INT;
    DECLARE jumlah_tiket INT;
    DECLARE total_pembayaran INT;

    -- Ambil harga dan jumlah tiket dari tabel Tiket
    SELECT harga_tiket, jumlah_tiket
    INTO harga_tiket, jumlah_tiket
    FROM Tiket
    WHERE id_tiket = NEW.id_tiket;

    -- Hitung total pembayaran (harga tiket x jumlah tiket)
    SET total_pembayaran = harga_tiket * jumlah_tiket;

    -- Insert ke tabel Pembayaran dengan metode pembayaran dan total pembayaran
    INSERT INTO Pembayaran (metode_pembayaran, jumlah_pembayaran)
    VALUES ('Kartu Kredit', total_pembayaran);  -- Ubah 'Kartu Kredit' dengan metode pembayaran dinamis jika diperlukan

    -- Update id_pembayaran pada tabel Pemesanan yang baru saja dimasukkan
    UPDATE Pemesanan
    SET id_pembayaran = (SELECT LAST_INSERT_ID())
    WHERE id_pemesanan = NEW.id_pemesanan;

END$$

DELIMITER ;