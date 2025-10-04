# simplerestic

<img src="_doc/assets/simplerestic.png" alt="simplerestic logo" width="500px"/>

**Simplerestic** is a graphical backup manager built on top of the amazing [restic](https://github.com/restic/restic) project.
It provides an Ubuntu Yaru–themed GUI to manage your restic backups without needing to use the command line.

Currently, simplerestic only works with Linux (tested with Ubuntu 24.04).

> [!CAUTION]
> This project is still in an early stage and may contain bugs. Use with caution for critical backups.

---

## ✨ Features

* Create, import and check restic repositories
* Create, forget, and restore snapshots
  * Supports **dry runs** for snapshot creation
* Mount repositories (optionally filtered by path)
* Backup interval indicator

---

## 🛠️ Planned Features

* [ ] Integrate the `copy` command
* [ ] Compare snapshots
* [ ] Support environment variables instead of password files
* [ ] Include/exclude files and add tags during snapshot creation
* [ ] Download restic automatically instead of bundling the binary
* [ ] Add statistics including `stats` command information
* [ ] Add windows support

---

## 🚀 Installation & Usage

Currently, there is no prebuilt executable available.

To build simplerestic yourself, you need to have [Flutter](https://docs.flutter.dev/install) installed.
- It is recommended to just use [fvm](https://fvm.app/)
  - fvm will automatically install and use the correct flutter version to ensure compatibility.
- Alternatively, you can also install the [currently used version](.fvmrc) globally on your machine

The command to build the application:
```bash
fvm flutter build linux
```
(Without fvm):
```bash
flutter build linux
```

After running the build command you should find the executable under `build/linux/x64/release/bundle`.

---

## 📷 Screenshots

![create repository](_doc/assets/create_repository.png)
![create snapshot](_doc/assets/create_snapshot.png)
![detail snapshot](_doc/assets/detail_snapshot.png)
![restore_snapshot](_doc/assets/restore_snapshot.png)

---

## 📄 License

This project is licensed under the **GNU General Public License v3.0**.
See the [LICENSE](LICENSE) file for details.

**Note:**

* The included **restic executable** is licensed under the **BSD 2-Clause License**.
* A copy of this license can be found [here](assets/LICENSE_restic).
