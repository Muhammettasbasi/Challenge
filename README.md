# Challenge



## Kurulum

1. Ansible ile gerekli tool kurulumları yapılır.

```bash
ansible-playbooks ansible/playbooks/main.yml -i ansible/inventory/hosts
```
2. Gerekli kurulumlar yapıldıktan sonra jenkins arayüzü üzerinden jenkins kurulumu tamamlanır.
**Not: host_ip ansible/inventory/hosts dosyası içerisindeki ip adresidir.**
```bash
http:://host_ip:8080
```
3. Jenkins kurulumu tamamlandıktan sonra arayüze giriş yapılır.(login bilgileri kurulum sırasında belirlenir.Burada admin:admin şeklindedir.) Arayüze girildikten sonra aşağıdaki link üzerinden jenkins API kullanımı için token oluşturulur.
```bash
http://host_ip:8080/user/admin/security/
```
4. Token oluşturulduktan sonra bu token degeri **ansible/vars/main.yml** içerisinde bulunan **jenkins_password** degeri güncellenmelidir.

5. Bu işlemler sonrasında ansible üzerinden jenkins API kullanılarak **Challenge** adında pipeline oluşturulur.
```bash
ansible-playbooks ansible/playbooks/jenkins/create_pipeline.yml -i ansible/inventory/hosts
```
5. Sonrasında aşağıdaki url açılır. Sonrasında sol menüde bulunan **Şimdi Yapılandır** butonuna tıklanarak pipeline çalıştırılır.
```bash
http://host_ip:8080/job/Challenge/
```
6. Kurulum tamamlanır.

 ## Test
## 1.Postgresql Testi
Kurulum sonrası postgresql e aşağıdaki link üzerinden ulaşılabilir.
 ```bash
jdbc:postgresql://host_ip:32432/challenge

```
Username ve Password bilgileri **/helm/values.yml** içerisinde postgresql secret tanımı altında base64 encode halinde bulunmaktadır.

## 1.Redis Testi
Kurulum sonrasında redis bağlantısı **redis-cli** yüklü bir makineden aşağıdaki link üzerinden test edilebilir. komut çıktısı başarılı ise **PONG** yanıtı dönmelidir.
 ```bash
redis-cli -h host_ip -p 32379 -a <PASSWORD> ping
```
Password bilgisi **/helm/velues.yml** içerisinde redis secret tanımı altında base64 encode halinde bulunmaktadır.
