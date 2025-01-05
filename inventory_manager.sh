#!/bin/bash


# Başlangıçta gerekli CSV dosyalarının oluşturulması
if [ ! -f depo.csv ]; then
    echo "Ürün Adı,Stok Miktarı,Birim Fiyatı,Kullanıcı Adı,Kategori" > depo.csv
fi
if [ ! -f kullanici.csv ]; then
    echo "Kullanıcı Adı,Şifre,Rol" > kullanici.csv  # Varsayılan yönetici hesabı
fi
if [ ! -f log.csv ]; then
    touch log.csv
fi



# Başlangıç ekranı
current_user_role=$(zenity --list --title="Sıma Pırlanta" --text="Sıma Pırlanta'ya Hoşgeldiniz!\nLütfen giriş türünüzü seçin:" \
--radiolist \
--column="Seçim" --column="Tür" \
TRUE "Yönetici" FALSE "Kullanıcı" --width=400 --height=800)

if [[ "$current_user_role" == "Yönetici" ]]; then
    # Yönetici için giriş yap veya kayıt ol seçenekleri
    action=$(zenity --list --title="Yönetici Paneli" --text="Lütfen bir işlem seçin:" \
    --radiolist \
    --column="Seçim" --column="İşlem" \
    TRUE "Giriş Yap" FALSE "Kayıt Ol" --width=400 --height=800)

    if [[ "$action" == "Kayıt Ol" ]]; then
    	(echo "0"; sleep 2; # 2 saniye bekle
    		echo "50"; # Yarım yol
    		sleep 2; # 2 saniye daha bekle
    		echo "100") | zenity --progress --title="Kayıt Ekranı" --text="Kayıt Ekranı Yükleniyor..." --percentage=0 --auto-close
        # Kullanıcı adı ve şifre al
        username=$(zenity --entry --title="Kayıt Ol" --text="Kullanıcı adı giriniz:" --width=400)

        if [[ -z "$username" ]]; then
            zenity --error --text="Kullanıcı adı boş olamaz." --width=400
            exit 1
        fi



        if grep -q "^$username," kullanici.csv; then
            # Kullanıcı zaten varsa hata mesajı
            error_message="Hata: '$username' adlı kullanıcı zaten mevcut."
            echo "$error_message" >> log.csv
            zenity --error --text="$error_message" --width=400
        else
            # Şifre al
            password=$(zenity --password --title="Şifre Belirle" --text="Şifrenizi giriniz:" --width=400)

            if [[ -z "$password" ]]; then
                zenity --error --text="Şifre boş olamaz." --width=400
                exit 1
            fi

            # Kullanıcıyı kaydet
            echo "$username,$password,$current_user_role" >> kullanici.csv
            zenity --info --text="Kayıt başarılı!" --width=400
            current_user="$username"
            current_user_role="Yönetici"
            (echo "0"; sleep 2; # 2 saniye bekle
    		echo "50"; # Yarım yol
    		sleep 2; # 2 saniye daha bekle
    		echo "100") | zenity --progress --title="Ana Menü" --text="Ana Menü Yükleniyor..." --percentage=0 --auto-close
            ana_menu
        fi
elif [[ "$action" == "Giriş Yap" ]]; then
	(echo "0"; sleep 2; # 2 saniye bekle
    		echo "50"; # Yarım yol
    		sleep 2; # 2 saniye daha bekle
    		echo "100") | zenity --progress --title="Giriş Ekranı" --text="Giriş Ekranı Açılıyor..." --percentage=0 --auto-close

        # Kullanıcı giriş işlemleri
        username=$(zenity --entry --title="Giriş Yap" --text="Kullanıcı adınızı giriniz:" --width=400)
        password=$(zenity --password --title="Giriş Yap" --text="Şifrenizi giriniz:" --width=400)

        if [[ -z "$username" || -z "$password" ]]; then
            zenity --error --text="Kullanıcı adı ve şifre boş bırakılamaz." --width=400
            exit 1
        fi

        if [[ ! -f "kullanici.csv" ]]; then
            zenity --error --text="Kayıtlı kullanıcı bulunamadı." --width=400
            exit 1
        fi

        if grep -q "^$username,$password,$current_user_role" kullanici.csv; then
            zenity --info --text="Giriş başarılı! Ana menüye yönlendiriliyorsunuz." --width=400
            # Ana menü işlemleri burada eklenebilir
            current_user="$username"
            (echo "0"; sleep 2; # 2 saniye bekle
    		echo "50"; # Yarım yol
    		sleep 2; # 2 saniye daha bekle
    		echo "100") | zenity --progress --title="Ana Menü" --text="Ana Menü Yükleniyor..." --percentage=0 --auto-close
            ana_menu
        else
            error_message="Hata: '$username' için giriş başarısız. Kullanıcı adı veya şifre hatalı."
            echo "$error_message" >> log.csv
            zenity --error --text="$error_message" --width=400
            exit 1
        fi
    fi
else
action=$(zenity --list --title="Kullanıcı Paneli" --text="Lütfen bir işlem seçin:" \
    --radiolist \
    --column="Seçim" --column="İşlem" \
    TRUE "Giriş Yap" FALSE "Kayıt Ol" --width=400 --height=800)

if [[ "$action" == "Kayıt Ol" ]]; then
	(echo "0"; sleep 2; # 2 saniye bekle
    		echo "50"; # Yarım yol
    		sleep 2; # 2 saniye daha bekle
    		echo "100") | zenity --progress --title="Kayıt Ekranı" --text="Kayıt Ekranı Yükleniyor..." --percentage=0 --auto-close

        # Kullanıcı adı ve şifre al
        username=$(zenity --entry --title="Kayıt Ol" --text="Kullanıcı adı giriniz:" --width=400)

        if [[ -z "$username" ]]; then
            zenity --error --text="Kullanıcı adı boş olamaz." --width=400
            exit 1
        fi

        # Kullanıcı.csv dosyasını kontrol et
        if [[ ! -f "kullanici.csv" ]]; then
            echo "Kullanıcı Adı,Şifre, Rol" > kullanici.csv
        fi

        if grep -q "^$username," kullanici.csv; then
            # Kullanıcı zaten varsa hata mesajı
            error_message="Hata: '$username' adlı kullanıcı zaten mevcut."
            echo "$error_message" >> log.csv
            zenity --error --text="$error_message" --width=400
        else
            # Şifre al
            password=$(zenity --password --title="Şifre Belirle" --text="Şifrenizi giriniz:" --width=400)

            if [[ -z "$password" ]]; then
                zenity --error --text="Şifre boş olamaz." --width=400
                exit 1
            fi

            # Kullanıcıyı kaydet
            echo "$username,$password,$current_user_role" >> kullanici.csv
            zenity --info --text="Kayıt başarılı!" --width=400
            current_user="$username"
            current_user_role="Kullanıcı"
            (echo "0"; sleep 2; # 2 saniye bekle
    		echo "50"; # Yarım yol
    		sleep 2; # 2 saniye daha bekle
    		echo "100") | zenity --progress --title="Ana Menü" --text="Ana Menü Açılıyor..." --percentage=0 --auto-close
            ana_menu
        fi
elif [[ "$action" == "Giriş Yap" ]]; then
    # Kullanıcı giriş işlemleri
    username=$(zenity --entry --title="Giriş Yap" --text="Kullanıcı adınızı giriniz:" --width=400)
    password=$(zenity --password --title="Giriş Yap" --text="Şifrenizi giriniz:" --width=400)

    # Başlangıçta deneme sayacını sıfırlayın
    attempt_count=0
    max_attempts=3  # Maksimum deneme sayısı

    if [[ -z "$username" || -z "$password" ]]; then
        zenity --error --text="Kullanıcı adı ve şifre boş bırakılamaz." --width=400
        exit 1
    fi

    if [[ ! -f "kullanici.csv" ]]; then
        zenity --error --text="Kayıtlı kullanıcı bulunamadı." --width=400
        exit 1
    fi

    # Kullanıcıyı kontrol et
    if grep -q "^$username,$password,$current_user_role" kullanici.csv; then
        export current_user="$username"
        export current_user_role="Kullanıcı"
        zenity --info --text="Giriş başarılı! Ana menüye yönlendiriliyorsunuz." --width=400
        
        ana_menu
        # Ana menü işlemleri burada eklenebilir
    else
        # Kullanıcı adı varsa yöneticisini bul
        admin_name=$(grep "^$username" kullanici.csv | cut -d',' -f2)
        if [[ -z "$admin_name" ]]; then
            admin_name="Yönetici bulunamadı"
        fi

        error_message="Hata: '$username' için giriş başarısız. Kullanıcı adı veya şifre hatalı."
        echo "$error_message, Yönetici: $admin_name, Tarih: $(date)" >> log.csv

        zenity --error --text="$error_message" --width=400
        ((attempt_count++))
        remaining_attempts=$((max_attempts - attempt_count))
        if [[ $remaining_attempts -gt 0 ]]; then
            zenity --error --text="Hatalı giriş! Kalan deneme sayısı: $remaining_attempts" --width=400
        fi
    fi

    # 3 başarısız giriş denemesinden sonra kullanıcıyı kilitle
    if [[ $attempt_count -eq $max_attempts ]]; then
        admin_name=$(grep ",Yönetici" kullanici.csv | cut -d',' -f1 | head -n 1)
        if [[ -z "$admin_name" ]]; then
            admin_name="Yönetici bulunamadı"
        fi

        # Kilitlenme bilgisi log.csv dosyasına yazılır
        log_entry="Kullanıcı: $username, Yönetici: $admin_name, Tarih: $(date), Durum: Hesap Kilitlendi"
        echo "$log_entry" >> log.csv

        # Kullanıcıya kilitlenme bildirimi yapılır
        zenity --error --text="Hesabınız kilitlendi! Yöneticinizden açılmasını isteyin." --width=400
        exit 1
    fi
fi


fi
# Ana Menü
function ana_menu() {
    while true; do
        action=$(zenity --list --title="Ana Menü" --column="Seçim" \
        "Ürün Ekle" "Ürün Listele" "Ürün Güncelle" "Ürün Sil" "Rapor Al" \
        "Kullanıcı Yönetimi" "Program Yönetimi" "Hesap Yönetimi" "Çıkış")

        case $action in
            "Ürün Ekle") ürün_ekle ;;
            "Ürün Listele") ürün_listele ;;
            "Ürün Güncelle") ürün_guncelle ;;
            "Ürün Sil") ürün_sil ;;
            "Kullanıcı Yönetimi") kullanici_yonetimi ;;
            "Program Yönetimi") program_yonetimi ;;
            "Hesap Yönetimi") hesap_yonetimi ;;
            "Rapor Al") rapor_al ;;
            "Çıkış")  # Çıkıştan önce onay sorusu
                if zenity --question --text="Çıkmak istediğinize emin misiniz?"; then
                    exit 0
                fi
                ;;
            *) zenity --error --text="Geçersiz seçenek!" ;;
        esac
    done
}

# Ürün Ekleme İşlevi
function ürün_ekle() {
    if [[ -z "$current_user" ]]; then
        hata_mesaji="Ürün ekleme işlemi için kullanıcı oturumu gerekli!"
        zenity --error --text="$hata_mesaji"
        echo "$(date +'%Y-%m-%d %H:%M:%S'),$hata_mesaji" >> log.csv
        return
    fi

    if [[ "$current_user_role" == "Kullanıcı" ]]; then
        hata_mesaji="Sadece yönetici rolündeki kullanıcılar ürün ekleyebilir!"
        zenity --error --text="$hata_mesaji"
        echo "$(date +'%Y-%m-%d %H:%M:%S'),$hata_mesaji, Kullanıcı Rolü: $current_user_role" >> log.csv
        return
    fi

    product_name=$(zenity --entry --title="Ürün Adı" --text="Ürün adını giriniz.")
    stock_quantity=$(zenity --entry --title="Stok Miktarı" --text="Stok miktarını giriniz.")
    unit_price=$(zenity --entry --title="Birim Fiyatı" --text="Birim fiyatını giriniz.")
    category=$(zenity --entry --title="Kategori" --text="Kategori adını giriniz.")

    if [[ -z "$product_name" ]]; then
        hata_mesaji="Ürün adı boş olamaz!"
        zenity --error --text="$hata_mesaji"
        return
    fi

    if grep -q "^$product_name," depo.csv; then
        hata_mesaji="Bu ürün adıyla başka bir kayıt bulunmaktadır: $product_name"
        zenity --error --text="$hata_mesaji"
        return
    fi

    (echo "0"; sleep 2; echo "50"; sleep 2; echo "100") | \
        zenity --progress --title="Ürün Ekleme" --text="Ürün Ekleniyor..." --percentage=0 --auto-close

    echo "$product_name,$stock_quantity,$unit_price,$current_user,$category" >> depo.csv
    zenity --info --text="Ürün başarıyla eklendi!"
}

function ürün_listele {
    if [[ "$current_user_role" == "Kullanıcı" ]]; then
        if [[ -z "$current_user" ]]; then
            zenity --error --text="Lütfen önce giriş yapın." --width=400
            return
        fi

        # Kullanıcıyı ekleyen yöneticiyi log.csv'den bul
        manager=$(grep "Kullanıcı eklendi: $current_user," log.csv | awk -F', Ekleyen Yönetici: ' '{print $2}' | awk -F',' '{print $1}')

        if [[ -z "$manager" ]]; then
            zenity --info --text="Sizi ekleyen yönetici bulunamadı." --width=400
            return
        fi

        # Yöneticinin ürünlerini depo.csv'den çek
        products=$(awk -F',' -v manager="$manager" '$4 == manager {print $1}' depo.csv | tr '\n' ', ' | sed 's/, $//')

        if [[ -z "$products" ]]; then
            zenity --info --text="Yöneticinizin ($manager) için kayıtlı ürün bulunamadı." --width=400
        else
            zenity --info --text="Yöneticinizin ($manager) ürünleri: $products" --width=400
        fi

    elif [[ "$current_user_role" == "Yönetici" ]]; then
        # Yönetici için ürünleri listele
        products=$(awk -F',' -v user="$current_user" '$4 == user {print $1}' depo.csv | tr '\n' ', ' | sed 's/, $//')

        if [[ -z "$products" ]]; then
            zenity --info --text="Yönetici ($current_user) için kayıtlı ürün bulunamadı." --width=400
        else
            (echo "0"; sleep 2;
             echo "50"; sleep 2;
             echo "100") | zenity --progress --title="Ürünler" --text="Ürünler Listeleniyor..." --percentage=0 --auto-close

            zenity --info --text="Yöneticinin ($current_user) ürünleri: $products" --width=400
        fi
    else
        zenity --error --text="Geçersiz kullanıcı rolü." --width=400
    fi
}
function ürün_guncelle() {
    if [[ -z "$current_user" ]]; then
        hata_mesaji="Güncelleme işlemi için yönetici oturumu gerekli!"
        zenity --error --text="$hata_mesaji"
        echo "$(date +'%Y-%m-%d %H:%M:%S'),$hata_mesaji" >> log.csv
        return
    fi

    if [[ "$current_user_role" == "Kullanıcı" ]]; then
        hata_mesaji="Sadece yönetici rolündeki kullanıcılar ürün güncelleyebilir!"
        zenity --error --text="$hata_mesaji"
        echo "$(date +'%Y-%m-%d %H:%M:%S'),$hata_mesaji" >> log.csv
        return
    fi

    urun_adi=$(zenity --entry --title="Ürün Güncelleme" --text="Güncellemek istediğiniz ürünün adını girin:")

    if [[ -z "$urun_adi" ]]; then
        hata_mesaji="Ürün adı boş bırakılamaz!"
        zenity --error --text="$hata_mesaji"
        echo "$(date +'%Y-%m-%d %H:%M:%S'),$hata_mesaji" >> log.csv
        return
    fi

    csv_dosya="depo.csv"
    if [[ ! -f "$csv_dosya" ]]; then
        hata_mesaji="Ürün dosyası ($csv_dosya) bulunamadı!"
        zenity --error --text="$hata_mesaji"
        echo "$(date +'%Y-%m-%d %H:%M:%S'),$hata_mesaji" >> log.csv
        return
    fi

    # Ürün adını ve kullanıcıyı kontrol ederek doğru satırı bulma
    satir=$(awk -F',' -v urun_adi="$urun_adi" -v kullanici="$current_user" \
    '$1 == urun_adi && $4 == kullanici {print $0}' "$csv_dosya")

    if [[ -z "$satir" ]]; then
        hata_mesaji="Ürün bulunamadı ya da bu ürün size ait değil: $urun_adi"
        zenity --error --text="$hata_mesaji"
        echo "$(date +'%Y-%m-%d %H:%M:%S'),$hata_mesaji" >> log.csv
        return
    fi

    zenity --info --title="Mevcut Ürün Bilgisi" --text="Mevcut bilgiler:\n$satir"

    yeni_bilgi=$(zenity --forms --title="Ürün Güncelleme" \
        --text="Yeni ürün bilgilerini girin:" \
        --add-entry="Ürün Adı" \
        --add-entry="Stok Miktarı" \
        --add-entry="Birim Fiyatı" \
        --add-entry="Kategori")

    if [[ -z "$yeni_bilgi" ]]; then
        hata_mesaji="Yeni bilgiler boş bırakılamaz!"
        zenity --error --text="$hata_mesaji"
        echo "$(date +'%Y-%m-%d %H:%M:%S'),$hata_mesaji" >> log.csv
        return
    fi

    # Kullanıcıdan alınan yeni bilgiler
    IFS="|" read -r yeni_urun_adi yeni_stok yeni_fiyat yeni_kategori <<< "$yeni_bilgi"
    
    # Ürün adını, kullanıcıyı ve mevcut kategoriyi eşleştirerek doğru satırı güncelle
    sed -i "/^$urun_adi,[^,]*,[^,]*,$current_user,/s|^$urun_adi,[^,]*,[^,]*,$current_user,[^,]*|$yeni_urun_adi,$yeni_stok,$yeni_fiyat,$current_user,$yeni_kategori|" "$csv_dosya"

    # İlerleme çubuğu göstermek için Zenity
    (echo "0"; sleep 2; echo "50"; sleep 2; echo "100") | zenity --progress --title="Ürün Güncellenme" --text="Satır Güncelleniyor..." --percentage=0 --auto-close

    # Başarı mesajı
    zenity --info --text="Ürün başarıyla güncellendi!\nYeni bilgiler:\n$yeni_urun_adi,$yeni_stok,$yeni_fiyat,$current_user,$yeni_kategori"
}


# Ürün Silme İşlevi
function ürün_sil() {
    if [[ -z "$current_user" ]]; then
        hata_mesaji="Ürün silme işlemi için yönetici oturumu gerekli!"
        zenity --error --text="$hata_mesaji"
        echo "$(date +'%Y-%m-%d %H:%M:%S'),$hata_mesaji" >> log.csv
        return
    fi

    if [[ "$current_user_role" == "Kullanıcı" ]]; then
        hata_mesaji="Sadece yönetici rolündeki kullanıcılar ürün silebilir!"
        zenity --error --text="$hata_mesaji"
        echo "$(date +'%Y-%m-%d %H:%M:%S'),$hata_mesaji, Kullanıcı: $current_user" >> log.csv
        return
    fi

    product_name=$(zenity --entry --title="Ürün Silme" --text="Silmek istediğiniz ürün adını giriniz:")
    if [[ -z "$product_name" ]]; then
        hata_mesaji="Ürün adı boş bırakılamaz!"
        zenity --error --text="$hata_mesaji"
        echo "$(date +'%Y-%m-%d %H:%M:%S'),$hata_mesaji" >> log.csv
        return
    fi

    csv_dosya="depo.csv"
    if [[ ! -f "$csv_dosya" ]]; then
        hata_mesaji="Ürün dosyası ($csv_dosya) bulunamadı!"
        zenity --error --text="$hata_mesaji"
        echo "$(date +'%Y-%m-%d %H:%M:%S'),$hata_mesaji" >> log.csv
        return
    fi

    # Ürün ve kullanıcı adı eşleşmesini kontrol et
    satir=$(awk -F',' -v urun="$product_name" -v kullanici="$current_user" '$1 == urun && $4 == kullanici' "$csv_dosya")
    if [[ -z "$satir" ]]; then
        hata_mesaji="Ürün bulunamadı ya da bu ürün size ait değil: $product_name"
        zenity --error --text="$hata_mesaji"
        echo "$(date +'%Y-%m-%d %H:%M:%S'),$hata_mesaji" >> log.csv
        return
    fi

    # Ürün silmeden önce onay iste
    if zenity --question --title="Ürün Silme Onayı" --text="Bu ürünü silmek istediğinize emin misiniz? $product_name"; then
        # İlerleme çubuğu
        (echo "0"; sleep 2; 
        echo "50"; sleep 2; 
        echo "100") | zenity --progress --title="Ürün Silme" --text="Ürün Siliniyor..." --percentage=0 --auto-close

        # Ürünü silmek için satırı 'depo.csv' dosyasından çıkart
        # Başlık satırını koruyarak ürün satırını silme
        # "Ürün Adı" ve "Kullanıcı Adı"na göre satırı bul ve sil
        sed -i "/^$product_name,[^,]*,[^,]*,$current_user,/d" "$csv_dosya"
        
        if [[ $? -eq 0 ]]; then
            echo "$(date +'%Y-%m-%d %H:%M:%S'),Ürün başarıyla silindi: $product_name, Kullanıcı: $current_user" >> log.csv
            zenity --info --text="Ürün başarıyla silindi: $product_name"
        else
            hata_mesaji="Ürün silme işlemi sırasında bir hata oluştu!"
            zenity --error --text="$hata_mesaji"
            echo "$(date +'%Y-%m-%d %H:%M:%S'),$hata_mesaji" >> log.csv
        fi
    else
        # Onay verilmedi, silme işlemi iptal edildi
        echo "$(date +'%Y-%m-%d %H:%M:%S'),Ürün silme işlemi iptal edildi: $product_name" >> log.csv
        zenity --info --text="Ürün silme işlemi iptal edildi."
    fi
}


function rapor_al() {

    # Yönetici kontrolü
    if [[ "$current_user_role" != "Yönetici" ]]; then
        if [[ -z "$current_user" ]]; then
            zenity --error --text="Lütfen önce giriş yapın." --width=400
            return
        fi

        # Kullanıcıyı ekleyen yöneticiyi log.csv'den bul
        manager=$(grep "Kullanıcı eklendi: $current_user" log.csv | awk -F', Ekleyen Yönetici: ' '{print $2}' | awk -F',' '{print $1}')

        if [[ -z "$manager" ]]; then
            zenity --info --text="Sizi ekleyen yönetici bulunamadı." --width=400
            return
        fi

        # Yöneticinin ürünlerini depo.csv'den çek
        products=$(grep ",$manager$" depo.csv)

        csv_dosya="depo.csv"

        if [[ ! -f "$csv_dosya" ]]; then
            hata_mesaji="Ürün dosyası ($csv_dosya) bulunamadı!"
            zenity --error --text="$hata_mesaji"
            echo "$(date +'%Y-%m-%d %H:%M:%S'),$hata_mesaji" >> log.csv
            return
        fi

        if [[ -z "$products" ]]; then
            zenity --info --title="Rapor" --text="Kullanıcıya ait ürün bulunamadı."
            return
        fi
	(echo "0"; sleep 2; # 2 saniye bekle
    	echo "50"; # Yarım yol
    	sleep 2; # 2 saniye daha bekle
    	echo "100") | zenity --progress --title="Rapor Al" --text="Rapor Yükleniyor" --percentage=0 --auto-close

        # Toplam ürün sayısı ve toplam değer hesapla
        total_products=$(echo "$products" | wc -l)
        total_value=$(echo "$products" | awk -F"," '{sum += $2 * $3} END {print sum}')

        # Stoğu azalan ürünleri bul (stok miktarı 10'dan küçük)
        low_stock_products=$(echo "$products" | awk -F"," '$2 < 5 {print $1 " (Stok: " $2 ")"}')

        # En yüksek stoğa sahip ürün(ler)
        max_stock=$(echo "$products" | awk -F"," '{if($2 > max) max=$2} END {print max}')
        highest_stock_products=$(echo "$products" | awk -F"," -v max="$max_stock" '$2 == max {print $1 " (Stok: " $2 ")"}')

        # Rapor mesajı oluştur
        rapor="Toplam Ürün Sayısı: $total_products\nToplam Değer: $total_value TL\n\n"
        rapor+="Stoğu Azalan Ürünler:\n"
        rapor+="${low_stock_products:-Tüm ürünlerin stoğu yeterli.}\n\n"
        rapor+="En Yüksek Stoğa Sahip Ürünler:\n"
        rapor+="${highest_stock_products:-Veri bulunamadı.}"

        # Raporu göster
        zenity --info --title="Rapor" --text="$rapor" --width=400 --height=300
    elif [[ "$current_user_role" == "Yönetici" ]]; then
        csv_dosya="depo.csv"

        if [[ ! -f "$csv_dosya" ]]; then
            hata_mesaji="Ürün dosyası ($csv_dosya) bulunamadı!"
            zenity --error --text="$hata_mesaji"
            echo "$(date +'%Y-%m-%d %H:%M:%S'),$hata_mesaji" >> log.csv
            return
        fi

        # Yöneticiye ait ürünleri filtrele
        admin_products=$(awk -F',' -v admin="$current_user" '$4 == admin' "$csv_dosya")

        if [[ -z "$admin_products" ]]; then
            zenity --info --title="Rapor" --text="Yöneticinin ürünleri bulunamadı."
            return
        fi
	(echo "0"; sleep 2; # 2 saniye bekle
    	echo "50"; # Yarım yol
    	sleep 2; # 2 saniye daha bekle
    	echo "100") | zenity --progress --title="Rapor Al" --text="Rapor Yükleniyor..." --percentage=0 --auto-close

        # Toplam ürün sayısı ve toplam değer hesapla
        total_products=$(echo "$admin_products" | wc -l)
        total_value=$(echo "$admin_products" | awk -F"," '{sum += $2 * $3} END {print sum}')

        # Stoğu azalan ürünleri bul (stok miktarı 10'dan küçük)
        low_stock_products=$(echo "$admin_products" | awk -F"," '$2 < 5 {print $1 " (Stok: " $2 ")"}')

        # En yüksek stoğa sahip ürün(ler)
        max_stock=$(echo "$admin_products" | awk -F"," '{if($2 > max) max=$2} END {print max}')
        highest_stock_products=$(echo "$admin_products" | awk -F"," -v max="$max_stock" '$2 == max {print $1 " (Stok: " $2 ")"}')

        # Rapor mesajı oluştur
        rapor="Toplam Ürün Sayısı: $total_products\nToplam Değer: $total_value TL\n\n"
        rapor+="Stoğu Azalan Ürünler:\n"
        rapor+="${low_stock_products:-Tüm ürünlerin stoğu yeterli.}\n\n"
        rapor+="En Yüksek Stoğa Sahip Ürünler:\n"
        rapor+="${highest_stock_products:-Veri bulunamadı.}"

        # Raporu göster
        zenity --info --title="Rapor" --text="$rapor" --width=400 --height=300
    fi
}

# Kullanıcı Yönetimi İşlevi
function kullanici_yonetimi() {
    # Yönetici kontrolü
    if [[ "$current_user_role" != "Yönetici" ]]; then
        hata_mesaji="Bu işlemi gerçekleştirmek için yönetici yetkisi gereklidir!"
        zenity --error --text="$hata_mesaji"
        echo "$(date +'%Y-%m-%d %H:%M:%S'),$hata_mesaji, Kullanıcı: $current_user" >> log.csv
        return
    fi

    # İşlem seçimi
    action=$(zenity --list --title="Kullanıcı Yönetimi" --column="Seçim" \
    "Kullanıcı Ekle" "Kullanıcı Listele" "Kullanıcı Güncelle" "Kullanıcı Sil")

    case $action in
        "Kullanıcı Ekle")
            username=$(zenity --entry --title="Kullanıcı Ekle" --text="Kullanıcı adını giriniz.")
            password=$(zenity --password --title="Kullanıcı Şifre" --text="Şifre giriniz.")
            role=$(zenity --list --title="Kullanıcı Rolü" --column="Rol" "Yönetici" "Kullanıcı")

            if [[ -z $username || -z $password || -z $role ]]; then
                hata_mesaji="Tüm alanlar doldurulmalıdır!"
                zenity --error --text="$hata_mesaji"
                echo "$(date +'%Y-%m-%d %H:%M:%S'),$hata_mesaji, İşlem: Kullanıcı Ekle" >> log.csv
                return
            fi

            # İlerleme çubuğu ekleniyor
            (echo "0"; sleep 2; # 2 saniye bekle
    		echo "50"; # Yarım yol
    		sleep 2; # 2 saniye daha bekle
    		echo "100") | zenity --progress --title="Kullanıcı Ekleme" --text="Kullanıcı Ekleniyor..." --percentage=0 --auto-close


            echo "$username,$password,$role" >> kullanici.csv
            zenity --info --text="Kullanıcı başarıyla eklendi!"
            echo "$(date +'%Y-%m-%d %H:%M:%S'),Kullanıcı eklendi: $username, Ekleyen Yönetici: $current_user" >> log.csv
            ;;
        "Kullanıcı Listele")
            if [[ ! -f "kullanici.csv" ]]; then
                hata_mesaji="Kullanıcı dosyası bulunamadı!"
                zenity --error --text="$hata_mesaji"
                echo "$(date +'%Y-%m-%d %H:%M:%S'),$hata_mesaji, İşlem: Kullanıcı Listele" >> log.csv
                return
            fi

		(echo "0"; sleep 2; # 2 saniye bekle
    		echo "50"; # Yarım yol
    		sleep 2; # 2 saniye daha bekle
    		echo "100") | zenity --progress --title="Kullanıcılar Listeleme" --text="Kullanıcılar Listeleniyor..." --percentage=0 --auto-close


            zenity --text-info --title="Kullanıcı Listele" --width=500 --height=300 --filename=kullanici.csv
            echo "$(date +'%Y-%m-%d %H:%M:%S'),Kullanıcı listesi görüntülendi, Yönetici: $current_user" >> log.csv
            ;;
        "Kullanıcı Güncelle")
            username=$(zenity --entry --title="Kullanıcı Güncelle" --text="Güncellemek istediğiniz kullanıcı adını giriniz.")

            if [[ -z "$username" ]]; then
                hata_mesaji="Kullanıcı adı boş bırakılamaz!"
                zenity --error --text="$hata_mesaji"
                echo "$(date +'%Y-%m-%d %H:%M:%S'),$hata_mesaji, İşlem: Kullanıcı Güncelle" >> log.csv
                return
            fi

            # Kullanıcıyı kontrol et
            user_info=$(grep "^$username," kullanici.csv)

            if [[ -z "$user_info" ]]; then
                hata_mesaji="Kullanıcı bulunamadı!"
                zenity --error --text="$hata_mesaji"
                echo "$(date +'%Y-%m-%d %H:%M:%S'),$hata_mesaji, Kullanıcı: $username" >> log.csv
                return
            fi

            # Mevcut bilgileri al
            old_password=$(echo $user_info | cut -d',' -f2)
            old_role=$(echo $user_info | cut -d',' -f3)

            # Yeni kullanıcı adı gir
            new_username=$(zenity --entry --title="Kullanıcı Adı Güncelle" --text="Yeni kullanıcı adını giriniz (Eski: $username):")
            if [[ -z "$new_username" ]]; then
                new_username=$username
            fi

            # Yeni şifre gir
            new_password=$(zenity --password --title="Şifre Güncelle" --text="Yeni şifreyi giriniz (Eski şifreyi değiştirmeyecekseniz boş bırakın):")
            if [[ -z "$new_password" ]]; then
                new_password=$old_password
            fi

            # Yeni rol seç
            new_role=$(zenity --list --title="Kullanıcı Rolü Güncelle" --column="Rol" "Yönetici" "Kullanıcı" --text="Eski rol: $old_role, Yeni rolü seçiniz:")
            if [[ -z "$new_role" ]]; then
                new_role=$old_role
            fi

            
            # İlerleme çubuğu başlat
    	(echo "0"; sleep 2; # 2 saniye bekle
    	echo "50"; # Yarım yol
    	sleep 2; # 2 saniye daha bekle
    	echo "100") | zenity --progress --title="Kullanıcı Bilgileri Güncellenme" --text="Kullanıcı Bilgileri Güncelleniyor..." --percentage=0 --auto-close

            # Kullanıcı bilgilerini güncelle
            sed -i "s/^$username,.*$/$new_username,$new_password,$new_role/" kullanici.csv
            zenity --info --text="Kullanıcı bilgileri başarıyla güncellendi: $new_username"
            echo "$(date +'%Y-%m-%d %H:%M:%S'),Kullanıcı bilgileri güncellendi: $username -> $new_username, Yönetici: $current_user" >> log.csv
            ;;
        "Kullanıcı Sil")
            username=$(zenity --entry --title="Kullanıcı Sil" --text="Silmek istediğiniz kullanıcı adını giriniz.")

            if [[ -z "$username" ]]; then
                hata_mesaji="Kullanıcı adı boş bırakılamaz!"
                zenity --error --text="$hata_mesaji"
                echo "$(date +'%Y-%m-%d %H:%M:%S'),$hata_mesaji, İşlem: Kullanıcı Sil" >> log.csv
                return
            fi

            # İlerleme çubuğu başlat
    	(echo "0"; sleep 2; # 2 saniye bekle
    	echo "50"; # Yarım yol
    	sleep 2; # 2 saniye daha bekle
    	echo "100") | zenity --progress --title="Kullanıcı Silme" --text="Kullanıcı Siliniyor..." --percentage=0 --auto-close

            sed -i "/^$username,/d" kullanici.csv
            zenity --info --text="Kullanıcı başarıyla silindi: $username"
            echo "$(date +'%Y-%m-%d %H:%M:%S'),Kullanıcı silindi: $username, Yönetici: $current_user" >> log.csv
            ;;
        *)
            hata_mesaji="Geçersiz seçenek!"
            zenity --error --text="$hata_mesaji"
            echo "$(date +'%Y-%m-%d %H:%M:%S'),$hata_mesaji, İşlem: $action" >> log.csv
            ;;
    esac
}

function program_yonetimi() {
    # Kullanıcı rolü kontrolü
    if [[ "$current_user_role" != "Yönetici" ]]; then
        hata_mesaji="Sadece yönetici rolündeki kullanıcılar program yönetimi işlemlerini yapabilir!"
        zenity --error --text="$hata_mesaji"
        echo "$(date +'%Y-%m-%d %H:%M:%S'),$hata_mesaji, Kullanıcı: $current_user" >> log.csv
        return
    fi

    while true; do
        action=$(zenity --list --title="Program Yönetimi" --column="Seçim" \
        "Diskteki Alanı Göster" "Diske Yedekle" "Hata Kayıtlarını Göster" "Programı Kapat" "Geri Dön")

        case $action in
            "Diskteki Alanı Göster")
                disk_alani_goster
                ;;
            "Diske Yedekle")
                dosya_yedekle
                ;;
            "Hata Kayıtlarını Göster")
                hata_kayitlarini_goster
                ;;
            "Programı Kapat")
                exit 0
                ;;
            "Geri Dön")
                break
                ;;
            *)
                hata_mesaji="Geçersiz seçenek!"
                zenity --error --text="$hata_mesaji"
                echo "$(date +'%Y-%m-%d %H:%M:%S'),$hata_mesaji, Kullanıcı: $current_user" >> log.csv
                ;;
        esac
    done
}
function disk_alani_goster() {
    if [[ ! -f "log.csv" && ! -f "kullanici.csv" && ! -f "depo.csv" ]]; then
        hata_mesaji="Dosyalar bulunamadı! (log.csv, kullanici.csv, depo.csv)"
        zenity --error --text="$hata_mesaji"
        echo "$(date +'%Y-%m-%d %H:%M:%S'),$hata_mesaji, Kullanıcı: $current_user" >> log.csv
        return
    fi
    # İlerleme çubuğu başlat
    (echo "0"; sleep 2; # 2 saniye bekle
    echo "50"; # Yarım yol
    sleep 2; # 2 saniye daha bekle
    echo "100") | zenity --progress --title="Dosya Boyutları" --text="Dosya Boyutları Hesaplanıyor..." --percentage=0 --auto-close
    # Dosyaların boyutlarını hesapla
    boyutlar=$(du -sh log.csv kullanici.csv depo.csv 2>/dev/null | awk '{print $2 " - " $1}')

    if [[ -z "$boyutlar" ]]; then
        hata_mesaji="Dosya boyutları hesaplanamadı!"
        zenity --error --text="$hata_mesaji"
        echo "$(date +'%Y-%m-%d %H:%M:%S'),$hata_mesaji, Kullanıcı: $current_user" >> log.csv
        return
    fi

    # Dosya boyutlarını Zenity ile göster
    zenity --info --title="Dosya Boyutları" --text="Dosyaların Kapladığı Alan:\n$boyutlar" --width=400
    echo "$(date +'%Y-%m-%d %H:%M:%S'),Dosya boyutları görüntülendi, Kullanıcı: $current_user" >> log.csv
}

# Diskteki alanı gösterme fonksiyonu
function dosya_yedekle() {
    # Yedekleme dizinini seçme
    backup_dir=$(zenity --file-selection --directory --title="Yedekleme Dizini Seç")

    if [[ -z "$backup_dir" ]]; then
        hata_mesaji="Yedekleme dizini seçilmedi!"
        zenity --error --text="$hata_mesaji"
        echo "$(date +'%Y-%m-%d %H:%M:%S'),$hata_mesaji, Kullanıcı: $current_user" >> log.csv
        return
    fi

    # Yedekleme işlemi
    # İlerleme çubuğu başlat
    (echo "0"; sleep 2; # 2 saniye bekle
    echo "50"; # Yarım yol
    sleep 2; # 2 saniye daha bekle
    echo "100") | zenity --progress --title="Yedekleme İşlemi" --text="Yedekleme İşlemi Başlıyorr..." --percentage=0 --auto-close
    if [[ -n "$current_user" ]]; then
        # Verileri yedekle
        grep ",$current_user$" depo.csv > "$backup_dir/depo_$current_user.csv.bak"
        grep "^$current_user," kullanici.csv > "$backup_dir/kullanici_$current_user.csv.bak"
        grep "$current_user" log.csv > "$backup_dir/log_$current_user.csv.bak"

        # Her dosya için kontrol ve bilgi mesajları
        if [[ -s "$backup_dir/depo_$current_user.csv.bak" ]]; then
            depo_mesaji="Depo dosyası başarıyla yedeklendi: depo_$current_user.csv.bak"
            echo "$(date +'%Y-%m-%d %H:%M:%S'),$depo_mesaji, Kullanıcı: $current_user" >> log.csv
        else
            depo_mesaji="Depo dosyası boş olduğu için yedeklenmedi!"
            echo "$(date +'%Y-%m-%d %H:%M:%S'),$depo_mesaji, Kullanıcı: $current_user" >> log.csv
        fi

        if [[ -s "$backup_dir/kullanici_$current_user.csv.bak" ]]; then
            kullanici_mesaji="Kullanıcı dosyası başarıyla yedeklendi: kullanici_$current_user.csv.bak"
            echo "$(date +'%Y-%m-%d %H:%M:%S'),$kullanici_mesaji, Kullanıcı: $current_user" >> log.csv
        else
            kullanici_mesaji="Kullanıcı dosyası boş olduğu için yedeklenmedi!"
            echo "$(date +'%Y-%m-%d %H:%M:%S'),$kullanici_mesaji, Kullanıcı: $current_user" >> log.csv
        fi

        if [[ -s "$backup_dir/log_$current_user.csv.bak" ]]; then
            log_mesaji="Log dosyası başarıyla yedeklendi: log_$current_user.csv.bak"
            echo "$(date +'%Y-%m-%d %H:%M:%S'),$log_mesaji, Kullanıcı: $current_user" >> log.csv
        else
            log_mesaji="Log dosyası boş olduğu için yedeklenmedi!"
            echo "$(date +'%Y-%m-%d %H:%M:%S'),$log_mesaji, Kullanıcı: $current_user" >> log.csv
        fi

        # Kullanıcıya genel bir bilgi mesajı göster
        zenity --info --text="Yedekleme işlemi tamamlandı! Yedekleme dizini: $backup_dir
        $depo_mesaji
        $kullanici_mesaji
        $log_mesaji"
    else
        hata_mesaji="current_user değişkeni boş. Yedekleme yapılamadı!"
        zenity --error --text="$hata_mesaji"
        echo "$(date +'%Y-%m-%d %H:%M:%S'),$hata_mesaji, Kullanıcı: $current_user" >> log.csv
    fi
}


# Hata kayıtlarını gösterme fonksiyonu
function hata_kayitlarini_goster() {
    if [[ ! -f "log.csv" ]]; then
        hata_mesaji="Log dosyası bulunamadı!"
        zenity --error --text="$hata_mesaji"
        echo "$(date +'%Y-%m-%d %H:%M:%S'),$hata_mesaji, Kullanıcı: $current_user" >> log.csv
        return
    fi

    # İlerleme çubuğu başlat
    (echo "0"; sleep 2; # 2 saniye bekle
    echo "50"; # Yarım yol
    sleep 2; # 2 saniye daha bekle
    echo "100") | zenity --progress --title="Hata Kayıtları" --text="Hata kayıtları yükleniyor..." --percentage=0 --auto-close

    zenity --text-info --title="Hata Kayıtları" --width=600 --height=400 --filename=log.csv
    echo "$(date +'%Y-%m-%d %H:%M:%S'),Hata kayıtları görüntülendi, Kullanıcı: $current_user" >> log.csv
}

function hesap_yonetimi() {
    while true; do
        # Zenity arayüzü ile seçim yap
        action=$(zenity --list --title="Hesap Yönetimi" --text="Bir işlem seçin:" \
        --column="İşlemler" "Şifre Sıfırla" "Hesap Kilidini Aç" "Geri Dön" --width=400 --height=300)

        case $action in
            "Şifre Sıfırla")
                sifre_sifirla
                ;;
            "Hesap Kilidini Aç")
                hesap_kilidini_ac
                ;;
            "Geri Dön")
                zenity --info --text="Ana menüye dönülüyor..." --width=300
                break
                ;;
            *)
                if [[ -z "$action" ]]; then
                    zenity --question --text="Çıkmak istediğinize emin misiniz?" --width=300
                    if [[ $? -eq 0 ]]; then
                        exit 0
                    fi
                else
                    zenity --error --text="Geçersiz seçim! Lütfen tekrar deneyin." --width=300
                fi
                ;;
        esac
    done
}

function sifre_sifirla() {
    # Kullanıcı adı girişi
    kullaniciAdi=$(zenity --entry --title="Şifre Sıfırla" --text="Şifresi sıfırlanacak kullanıcının adını girin:" --width=400)

    if [[ -z "$kullaniciAdi" ]]; then
        zenity --error --text="Kullanıcı adı boş bırakılamaz." --width=300
        return
    fi

    if [[ ! -f "kullanici.csv" ]]; then
        zenity --error --text="Kullanıcı dosyası bulunamadı. Lütfen kullanıcı.csv dosyasını kontrol edin." --width=400
        return
    fi

    # Kullanıcının var olup olmadığını kontrol et
    kullaniciSatiri=$(grep "^$kullaniciAdi," kullanici.csv)
    if [[ -z "$kullaniciSatiri" ]]; then
        zenity --error --text="Kullanıcı '$kullaniciAdi' bulunamadı." --width=400
        return
    fi

    # Yeni şifre giriş
    yeniSifre=$(zenity --password --title="Yeni Şifre" --text="Yeni şifreyi girin:" --width=400)

    if [[ -z "$yeniSifre" ]]; then
        zenity --error --text="Şifre boş bırakılamaz." --width=300
        return
    fi

    # Kullanıcı bilgilerini güncelle
    eskiRol=$(echo "$kullaniciSatiri" | cut -d',' -f3) # Kullanıcının mevcut rolünü al
    yeniSatir="$kullaniciAdi,$yeniSifre,$eskiRol"

    # Dosyayı güncelle
    sed -i "s/^$kullaniciAdi,.*/$yeniSatir/" kullanici.csv

    zenity --info --text="Kullanıcı '$kullaniciAdi' için şifre başarıyla güncellendi." --width=400
}

function hesap_kilidini_ac() {
    # Kullanıcı adı al
    kullaniciAdi=$(zenity --entry --title="Hesap Kilidini Aç" --text="Kilidi açılacak kullanıcının adını girin:" --width=400)

    if [[ -z "$kullaniciAdi" ]]; then
        zenity --error --text="Kullanıcı adı boş bırakılamaz." --width=300
        return
    fi

    # log.csv dosyasını kontrol et
    if [[ ! -f "log.csv" ]]; then
        zenity --error --text="Log dosyası bulunamadı. Lütfen log.csv dosyasını kontrol edin." --width=400
        return
    fi

    # Kullanıcıya ait bir kilit kaydı olup olmadığını kontrol et
    kilitliMi=$(grep "^Kullanıcı: $kullaniciAdi,.*Kilitli" log.csv)

    if [[ -z "$kilitliMi" ]]; then
        zenity --info --text="Kullanıcı '$kullaniciAdi' zaten kilitli değil." --width=400
        return
    fi

    # Hesap kilidini aç ve log.csv dosyasına yaz
    adminAdi=$(zenity --entry --title="Yönetici Bilgisi" --text="Yönetici adını girin:" --width=400)
    if [[ -z "$adminAdi" ]]; then
        zenity --error --text="Yönetici adı boş bırakılamaz." --width=300
        return
    fi

    tarih=$(date)
    echo "Kullanıcı: $kullaniciAdi, Yönetici: $adminAdi, Tarih: $tarih, Durum: Kilit Açıldı" >> log.csv
    zenity --info --text="Kullanıcı '$kullaniciAdi' için hesap kilidi başarıyla açıldı." --width=400
}


# Programı Başlat
ana_menu
