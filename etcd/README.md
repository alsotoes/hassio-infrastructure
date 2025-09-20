# Home Assistant Community Add-on: etcd

![Supports amd64 Architecture][amd64-shield]
![Supports aarch64 Architecture][aarch64-shield]
![Supports arm64 Architecture][arm64-shield]

[armhf-shield]: https://img.shields.io/badge/armhf-no-red.svg
[armv7-shield]: https://img.shields.io/badge/armv7-yes-green.svg
[arm64-shield]: https://img.shields.io/badge/arm64-yes-green.svg
[aarch64-shield]: https://img.shields.io/badge/aarch64-yes-green.svg
[amd64-shield]: https://img.shields.io/badge/amd64-yes-green.svg

![etcd Logo](https://raw.githubusercontent.com/etcd-io/etcd/main/logos/etcd-horizontal-color.svg)

etcd is a distributed reliable key-value store for the most critical data of a distributed system, with a focus on being:

* *Simple*: well-defined, user-facing API (gRPC)
* *Secure*: automatic TLS with optional client cert authentication
* *Fast*: benchmarked 10,000 writes/sec
* *Reliable*: properly distributed using Raft

etcd is written in Go and uses the [Raft](https://github.com/etcd-io/raft) [README.md](https://github.com/etcd-io/raft/blob/main/README.md) consensus algorithm to manage a highly-available replicated log.

## Important
**Only use this add-on if you are running home assistant on SSD drives** otherwise, the server will constantly fail because of low IO.

## Security
This add-on includes an AppArmor security profile that provides mandatory access controls to enhance container security and limit potential attack vectors.

## License
GNU GENERAL PUBLIC [LICENSE](https://github.com/alsotoes/hassio-infrastructure/blob/main/LICENSE.md) Version 3

Also, have the following in mind.

THE SOFTWARE IS PROVIDED "AS IS" WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
