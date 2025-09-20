# My personal Home Assistant 🏠 Add-ons

## Add Repository to HA

[![Open your Home Assistant instance and show the add add-on repository dialog with a specific repository URL pre-filled.](https://my.home-assistant.io/badges/supervisor_add_addon_repository.svg)](https://my.home-assistant.io/redirect/supervisor_add_addon_repository/?repository_url=https%3A%2F%2Fgithub.com%2Falsotoes%2Fhassio-infrastructure)

## About

I plan to maintain this repo because I use these addons in my setup.
I use it on a raspberry, so I only test for arm64 architecture.
PR and issue reports are definitely welcome.

## Installation

Adding this add-ons repository to your Home Assistant instance is easy. In the
Home Assistant add-on store, a possibility to add a repository is provided.

Use the following URL to add this repository:

```txt
https://github.com/alsotoes/hassio-infrastructure
```

## Add-ons provided by this repository

### &#10003; [cups addon](https://github.com/alsotoes/hassio-infrastructure/blob/main/cups)

![Supports amd64 Architecture][amd64-shield] 
![Supports aarch64 Architecture][aarch64-shield] 
![Supports arm64 Architecture][arm64-shield]

CUPS is a modular printing system for Unix-like computer operating systems which allows a computer to act as a print server.

[cups addon documentation](https://github.com/alsotoes/hassio-infrastructure/blob/main/cups/README.md)

### &#10003; [etcd addon](https://github.com/alsotoes/hassio-infrastructure/blob/main/etcd)

![Supports amd64 Architecture][amd64-shield]
![Supports aarch64 Architecture][aarch64-shield]
![Supports arm64 Architecture][arm64-shield]

etcd is a distributed reliable key-value store for the most critical data of a distributed system.

[etcd addon documentation](https://github.com/alsotoes/hassio-infrastructure/blob/main/etcd/README.md)

### &#10003; [smb1-proxy addon](https://github.com/alsotoes/hassio-infrastructure/blob/main/smb1-proxy)

![Supports amd64 Architecture][amd64-shield]
![Supports aarch64 Architecture][aarch64-shield]
![Supports arm64 Architecture][arm64-shield]

This add-on acts as a **proxy**:
- Connects to the legacy SMB1 share.
- Re-exports it as a modern **SMB2/SMB3 share** that Home Assistant and other devices can mount safely.

[smb1-proxy addon documentation](https://github.com/alsotoes/hassio-infrastructure/blob/main/smb1-proxy/README.md)

## License

GNU GENERAL PUBLIC [LICENSE](LICENSE.md) Version 3

Also, have the following in mind.

THE SOFTWARE IS PROVIDED "AS IS" WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.

[armhf-shield]: https://img.shields.io/badge/armhf-no-red.svg
[armv7-shield]: https://img.shields.io/badge/armv7-yes-green.svg
[arm64-shield]: https://img.shields.io/badge/arm64-yes-green.svg
[aarch64-shield]: https://img.shields.io/badge/aarch64-yes-green.svg
[amd64-shield]: https://img.shields.io/badge/amd64-yes-green.svg
