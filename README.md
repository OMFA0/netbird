# 🧰 IT KONTROLL – Script netbird install

> Access to netbird network.

---

## 🌐 NetBird / UniFi
| Skript | Beskrivelse | Hent |
|--------|--------------|------|
| **IK-AGENT.sh** | Installer NetBird-agent på UDR/UDM | [Raw](https://gist.github.com/ITKONTROLL/ee2377e29b108840210a5fc29ec679ec) |

### 💻 install NetBird agent on UDR/UDM
Create folder
````
mkdir /data/netbird/
cd /data/netbird/
````
Run the following command on your UDM/UDR: 
````bash
 bash <(curl -fsSL https://raw.githubusercontent.com/OMFA0/netbird/refs/heads/main/netbird.sh)

````

Then add the setup key
````
/data/netbird/netbird -k <setup key> up
````
Run a reboot:

````
Reboot

````
---


🌐 **Firma:** [IT Kontroll AS](https://www.itkontroll.no)
