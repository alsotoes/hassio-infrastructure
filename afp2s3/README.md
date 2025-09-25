![afp2s3 Logo](logo.png)

# Home Assistant Add-on: afp2s3

This add-on mounts a remote AFP (Apple Filing Protocol) share into the add-on's filesystem and exposes it as an S3-compatible object storage endpoint using Minio.

## Installation

1.  Copy the `afp2s3` directory to the `/addons` directory of your Home Assistant installation.
2.  In Home Assistant, navigate to the **Add-on Store** in the **Supervisor** panel.
3.  Click the three dots in the top right corner and select **"Reload"**.
4.  The "AFP to S3" add-on will appear as a local add-on. Click on it and then click **"Install"**.

## Configuration

After installation, you need to configure the add-on. You can do this from the add-on's "Configuration" tab.

The following configuration options are available:

| Option          | Description                               |
| --------------- | ----------------------------------------- |
| `afp_server`    | The URL of the AFP server and share.      |
| `afp_user`      | The username for the AFP share.           |
| `afp_password`  | The password for the AFP share.           |
| `s3_access_key` | The access key for the S3 server (Minio). |
| `s3_secret_key` | The secret key for the S3 server (Minio). |

### Example Configuration

```yaml
afp_server: "afp://192.168.1.100/my_share"
afp_user: "my_user"
afp_password: "my_password"
s3_access_key: "my_access_key"
s3_secret_key: "my_secret_key"
```

## Usage

Once the add-on is started, you can access the S3 server on port `9000`. The Minio web interface is available on port `9001`.

You can access the Minio web interface through the Home Assistant ingress by clicking the "Open Web UI" button on the add-on's page.

## Security

This add-on previously shipped with an AppArmor profile to restrict permissions. AppArmor enforcement is currently disabled for compatibility, but the reference profile remains available in `apparmor.txt` should you wish to adapt it for your own deployment.

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
