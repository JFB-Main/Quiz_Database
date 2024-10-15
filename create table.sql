-- Table: Pelanggan (Customer)
CREATE TABLE Pelanggan (
    id_pelanggan int NOT NULL AUTO_INCREMENT PRIMARY KEY,
    nama_pelanggan varchar(255) NOT NULL,
    email_pelanggan varchar(255) NOT NULL UNIQUE,
    nomor_telephone_pelanggan varchar(255) NOT NULL UNIQUE
);

-- Table: Konser (Concert)
CREATE TABLE Konser (
    id_konser int NOT NULL AUTO_INCREMENT PRIMARY KEY,
    nama_konser varchar(255) NOT NULL,
    lokasi_konser varchar(255) NOT NULL,
    kapasitas_konser int NOT NULL,
    tanggal_konser DATE NOT NULL,
    kapasitas_max INT NOT NULL
);

-- Table: Tiket (Ticket)
CREATE TABLE Tiket (
    id_tiket int NOT NULL AUTO_INCREMENT PRIMARY KEY,
    id_konser INT NOT NULL,
    jumlah_tiket INT NOT NULL,
    jenis_tiket varchar(255) NOT NULL,
    harga_tiket int NOT NULL,
    FOREIGN KEY (id_konser) REFERENCES Konser(id_konser) ON DELETE CASCADE
);

-- Table: Pemesanan (Order)
CREATE TABLE Pemesanan (
    id_pemesanan INT AUTO_INCREMENT PRIMARY KEY,
    id_pelanggan INT NOT NULL,
	id_tiket INT NOT NULL,
    id_Pembayaran INT NOT NULL,
    tanggal_pemesanan DATE NOT NULL,
    status_pemesanan ENUM('berhasil', 'dibatalkan') NOT NULL,
    FOREIGN KEY (id_pelanggan) REFERENCES Pelanggan(id_pelanggan) ON DELETE CASCADE,
    FOREIGN KEY (id_tiket) REFERENCES Tiket(id_tiket) ON DELETE CASCADE,
	FOREIGN KEY (id_Pembayaran) REFERENCES Pembayaran(id_Pembayaran) ON DELETE CASCADE
);

-- Table: Pembayaran (Payment)
CREATE TABLE Pembayaran (
    id_pembayaran INT AUTO_INCREMENT PRIMARY KEY,
    id_pemesanan INT NOT NULL,
    metode_pembayaran varchar(255) NOT NULL,
    jumlah_pembayaran INT NOT NULL
);

CREATE TABLE histori_pemesanan (
    id_histori INT AUTO_INCREMENT PRIMARY KEY,
    id_pemesanan INT NOT NULL,
    status_lama ENUM('dibatalkan', 'menunggu', 'lunas') NOT NULL,
    status_baru ENUM('dibatalkan', 'menunggu', 'lunas') NOT NULL,
    waktu_perubahan DATETIME DEFAULT CURRENT_TIMESTAMP,
    id_pelanggan INT NOT NULL,
    FOREIGN KEY (id_pemesanan) REFERENCES Pemesanan(id_pemesanan) ON DELETE CASCADE,
    FOREIGN KEY (id_pelanggan) REFERENCES Pemesanan(id_pelanggan) ON DELETE CASCADE
);