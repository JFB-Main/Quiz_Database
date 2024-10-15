DELIMITER $$

CREATE TRIGGER log_status_change
AFTER UPDATE ON Pemesanan
FOR EACH ROW
BEGIN
    -- Pastikan status_pemesanan diubah
    IF OLD.status_pemesanan <> NEW.status_pemesanan THEN
        INSERT INTO histori_pemesanan (id_pemesanan, status_lama, status_baru, waktu_perubahan, user_id)
        VALUES (NEW.id_pemesanan, OLD.status_pemesanan, NEW.status_pemesanan, NOW(), NEW.user_id);
    END IF;
END$$

DELIMITER ;
