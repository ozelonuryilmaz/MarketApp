
# MarketApp

## Amaç

Bu proje, modern iOS uygulama geliştirme prensiplerine uygun olarak yapılandırılmış bir e-ticaret demo uygulamasıdır. Temel hedefimiz, **Clean Architecture**, **Best Practice**, **Thread & Memory Management**, **Test Edilebilirlik** ve **Performans** odaklı bir yapı kurmaktır.

---

## Uygulama Özellikleri

- Ana sayfada ürünler **pagination** ile listelenir.
- Ürün detay sayfası görüntülenebilir.
- Ürün sepete eklenebilir.
- Sepette ürün adedi artırılıp azaltılabilir.
- Toplam sepet fiyatı hesaplanır ve gösterilir.

---

## Katmanlar ve Mimariler

### 🔹 App Katmanı (MVVM-C Yapısı)

- `ViewController`: Kullanıcı etkileşimini alır, ViewModel’a iletir.
- `RootView`: ViewController'ın sahip olduğu UI katmanıdır. Tüm alt bileşenleri (label, button, tableView vb.) içerir.
- `ViewModel`: UI ile iş mantığını birbirine bağlar. Data-binding sağlar (`viewState`).
- `VMLogic`: ViewModel’a yardımcı olur; iş kurallarını soyutlar.
- `Coordinator`: Sayfalar arası yönlendirmeden sorumludur.
- `Repository`: Veriyi getirir (local veya remote olabilir). ViewModel, repository’i direkt tanır.
- `Params`: Sayfalar arası veri taşımak için kullanılır.
- `Builder`: ViewController, ViewModel, Coordinator gibi bileşenleri başlatır (init eder). Tüm bağımlılıkları burada tanımlar. Dependency Injection prensibine uygundur.

---

### 🔹 Domain Katmanı

> **Clean Architecture prensibine göre** App katmanı sadece Domain katmanını bilir. Domain ise Data katmanını bilir. Bu sayede App → Data erişimi **engellenmiş** olur.

- `UseCase`: Saf ve test edilebilir iş kurallarını tanımlar.
- `Entity`: Uygulama içi sade veri modelleridir. DTO içermez.
- `Provider`: UseCase bağımlılıkları Provider aracılığıyla App katmanına enjekte edilir.
- **UseCase → Repository** protokolüne erişir, ancak verinin nereden geldiğini (remote/local) **bilmez**.

---

### 🔹 Data Katmanı

> Uygulamanın verilerle olan iletişimini yönetir. Veri kaynağına göre (CoreData / API) yönetimi bu katmanda yapılır.

- `RemoteDataSource`: API üzerinden veri çekimi sağlar.
- `LocalDataSource`: CoreData kullanarak veri saklar ve çeker.
- `Repository`: Domain’in tanıdığı protokolleri uygular.
- `DTO`: Network ve CoreData modellerini temsil eder.

> 💡 Repository, verinin nereden geldiğini bilir. Domain bunu **bilmez**.

---

## 📦 SPM ile Ayrıştırılmış Katmanlar _(İptal Edildi)_

Başlangıçta **Domain** ve **Data** katmanlarını ayrı **Swift Package Manager (SPM)** paketleri olarak yapılandırdık.

Ancak;

- `CoreData.xcdatamodeld` dosyasının doğru biçimde çalışmaması,
- `@objc` sınıf eşleşmelerinin bozulması,
- `.xcdatamodeld` dosyasının `resources` olarak derlenememesi

gibi sorunlar nedeniyle bu yapı **iptal edildi**.

> **Challanges** yapıldı ancak Apple’ın CoreData’yı SPM içinde desteklememesi nedeniyle **App katmanına** taşındı.

---

## 🧠 Teknik Prensipler & Wow Özellikler

- **MVVM-C** kullanıldı. Modüler, test edilebilir yapı.
- **Clean Architecture** ile katmanlar ayrıldı.
- **Protocol Oriented Programming (POP)** destekli interface’ler.
- **SOLID prensiplerine uygun** sınıf tasarımı.
- **Dependency Injection (DI)**: Builder pattern ile yönlendirildi.
- **Memory Management**: Tüm base class’ların `deinit` log’ları eklendi.
- **Thread Safety**: GCD kullanıldı. CoreData işlemleri sıraya alındı.
- **Combine Framework**: Modern reaktif yapı kullanıldı.
- **Unit Test**: GIVEN-WHEN-THEN prensibine uygun olarak yazıldı.
- **ViewModel → viewState** binding: Android’deki MVI’ya denk gelir. Tek yönlü veri akışı uygulanmıştır.

---

## Test Edilebilirlik

- Domain katmanında `UseCase` fonksiyonlarına unit test yazıldı.
- MockRepository’ler oluşturularak veri kaynağı izole edildi.
- Combine işlemleri beklenti ile test edildi (`XCTestExpectation`).

---

## Bağımlılıklar

- **Combine**: Apple reaktif programlama framework’ü
- **CoreData**: Local veri saklama çözümü (SPM dışında çalışır)
- (Opsiyonel olarak) **GRDB** alternatif olarak değerlendirilebilir

---

## Proje Yapısı

```
MarketApp/
├── App/
│   ├── Builder/
│   ├── Coordinator/
│   ├── Params/
│   └── Repository/
│   ├── ViewModel/
│   ├── VMLogic/
│   ├── ViewController/
│   ├── RootView/
├── Domain/
│   ├── Entity/
│   ├── UseCase/
│   └── Provider/
├── Data/
│   ├── CoreDataManager/
│   ├── NetworkManager/
│   ├── RemoteDataSource/
│   ├── LocalDataSource/
│   ├── Repository/
│   └── DTO/
```

---

## 📌 Sonuç

Bu proje; modern iOS uygulama geliştirme sürecine güçlü bir temel sunar.  
Mimarisi sade ama ölçeklenebilir olacak şekilde planlanmıştır.  
Kod kalitesi, test edilebilirlik ve performans göz önünde bulundurularak oluşturulmuştur.
