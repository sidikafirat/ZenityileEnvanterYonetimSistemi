# Sıma Pırlanta - Yönetici ve Kullanıcı Yönetim Sistemi

Bu proje, **Zenity** kullanılarak geliştirilmiş bir Bash tabanlı stok ve kullanıcı yönetim sistemidir. Kullanıcılar, sisteme yönetici veya kullanıcı olarak giriş yapabilir. Yöneticiler uygulama üzerinde tüm fonksiyonlara erişim yetkisine sahipken kullanıcılar yalnızca 'Rapor Al'
ve 'Ürün Listeleme' fonksiyonlarında erişim yetkisi vardır.
## Özellikler

- **Giriş ve Kayıt Sistemi**: Yönetici ve kullanıcılar için giriş ve kayıt işlemleri.
- **CSV Tabanlı Veri Yönetimi**: Kullanıcı bilgileri , stoklar ve hatalı tüm işlemler CSV dosyalarında saklanır.
- **Zenity İle Grafiksel Arayüz**: Kullanıcı dostu bir arayüz sunar.
- **Yetkilendirme**: Yönetici ve kullanıcıların farklı yetkileri bulunur.
- **Loglama**: Sistem hatalarını ve kullanıcı aktivitelerini log.csv dosyasına kaydeder.

## Gereksinimler

- **Linux veya Unix tabanlı bir işletim sistemi**
- **Zenity**: Grafik arayüzler için kullanılan bir araçtır.
- **Bash**: Komut dosyası çalıştırmak için gereklidir.

## Kurulum

1. **Depoyu Klonlayın**
   ```bash
   git clone https://github.com/sidikafirat/ZenityileEnvanterYönetimSistemi.git
2. **Zenitynin Yüklü Olduğundan Emin Olun**
   ```bash
   sudo apt install zenity  # Debian tabanlı sistemler için
3. **Dosya İzinlerini Ayarlayın**
   ```bash
   chmod +x inventory_manager.sh
4. **Script'i Çalıştırın**
   ```bash
   ./inventory_manager.sh

## Kullanım
- **Youtube Kullanım Linki**
   ```bash


- **Ekran Görüntüleri**
   
### Giriş Ekranı
![Screenshot from 2025-01-05 16-16-16](https://github.com/user-attachments/assets/18fb08ec-0156-4afc-9eb1-b9d446a2a648)
### Yönetici Paneli
![Screenshot from 2025-01-05 16-17-58](https://github.com/user-attachments/assets/20f5a93c-ebb9-4bfd-b294-57b23286d76f)

### Kayıt Ol
![Screenshot from 2025-01-05 16-24-36](https://github.com/user-attachments/assets/29012196-6208-4126-8a35-fb8c252ff657)
![Screenshot from 2025-01-05 16-25-54](https://github.com/user-attachments/assets/6f84e272-e94f-4f24-b653-83a1e57a27b7)

### Ana Menü

![Screenshot from 2025-01-05 16-27-26](https://github.com/user-attachments/assets/afdb9649-be24-4a8e-9ebe-fac42d1ae5fb)

### Ürün Ekle
![Screenshot from 2025-01-05 16-32-09](https://github.com/user-attachments/assets/1a7ff0d6-e91c-41ad-a0e3-14e084fecc3a)
![Screenshot from 2025-01-05 16-35-30](https://github.com/user-attachments/assets/562ba29c-f99f-4a4d-821b-3184d546219d)
![Screenshot from 2025-01-05 16-36-21](https://github.com/user-attachments/assets/1a20b364-e3b6-4168-b8cd-10284d9b08dd)
![Screenshot from 2025-01-05 16-37-08](https://github.com/user-attachments/assets/6838cf59-6319-4aa7-8303-5187d5972aa6)

### Ürün Listele
![Screenshot from 2025-01-05 16-39-26](https://github.com/user-attachments/assets/b11c7cb2-d9b6-47eb-a9fd-9e179c2b213e)

### Ürün Güncelle

![Screenshot from 2025-01-05 16-42-22](https://github.com/user-attachments/assets/dc047a79-c40f-4d77-be25-7a2fb67d90cc)
### Ürün Silme
![Screenshot from 2025-01-05 16-44-50](https://github.com/user-attachments/assets/678c615c-5a69-4146-94fc-cf3ce56e10de)
![Screenshot from 2025-01-05 16-45-56](https://github.com/user-attachments/assets/5155c9fe-ba9f-4ebf-a50b-46d335baa1b7)

### Rapor Al
![Screenshot from 2025-01-05 16-48-03](https://github.com/user-attachments/assets/fc18310b-298c-40af-9c85-73c9e2a0d3f9)

### Kullanıcı Yönetimi
![Screenshot from 2025-01-05 16-51-28](https://github.com/user-attachments/assets/a2d64ebe-5c00-4f58-9d5b-c8d4dcb43a40)

### Program Yönetimi
![Screenshot from 2025-01-05 16-53-04](https://github.com/user-attachments/assets/e1ee0544-40db-48ba-989a-505c40ef3d2c)
![Screenshot from 2025-01-05 16-57-25](https://github.com/user-attachments/assets/54d7b5d9-327b-44d8-9384-eda2b84d01c5)

### Hesap Yönetimi
![Screenshot from 2025-01-05 16-55-24](https://github.com/user-attachments/assets/7124b798-3eca-4251-9dd8-f2f3f83307f7)

### Çıkış
![Screenshot from 2025-01-05 16-59-10](https://github.com/user-attachments/assets/e26c1233-56c1-411f-9cd1-d9f63c377899)

