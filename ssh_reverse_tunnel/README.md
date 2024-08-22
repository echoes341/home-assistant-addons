# SSH Reverse Tunnel for Home Assistant

![Supports aarch64 Architecture][aarch64-shield]
![Supports amd64 Architecture][amd64-shield]
![Supports armhf Architecture][armhf-shield]
![Supports armv7 Architecture][armv7-shield]
![Supports i386 Architecture][i386-shield]

ThisHome Assistant addon allows to share on the internet a Home Assistant server using an SSH reverse tunnel.

## Prerequisites
In order to do it you need:

- A VM hosted somewhere accessible from the public internet
- Possibly a domain
- (optional) a reverse proxy on your VM so that you can easily handle HTTPS, I personally use [Traefik](https://traefik.io/traefik/) but any will do.

## Configuration

Once you installed you'll need to configure this addon before running it.

The addon currently accepts the following settings, defaults in square brackets:
- `remote_ip` [127.0.0.1] : The IP where that tunnel will be in the remote machine. This doesn't need to be the remote ip of the machine. For example, setting it to 127.0.0.1 means that the tunnel will be reachable only by connections coming from the virtual machine. This makes sense if you want the internet to be able to access home assistant using a reverse proxy. 
- `remote_port` [18123]: Port where the tunnel will be allocated on the remote machine.
- `local_port` [8123]: Local port to forward through the remove machine. Home Assistant usually is on 8123.
- `target`: SSH target for the remote connection, for example `myuser@your-domain.com`
- `private_key_b64`: Base64 encode private key to use for connecting. The remote machine must have the relative public key set into its `~/.ssh/authorized_keys` 
- `known_hosts_b64`: (optional, but recommended) Base64 encoded `known_hosts` file containing the server public key to validate the ssh connection.

To encode the required keys to base64, you can use this handy [recipe on Cybershef](https://gchq.github.io/CyberChef/#recipe=Find_/_Replace(%7B'option':'Extended%20(%5C%5Cn,%20%5C%5Ct,%20%5C%5Cx...)','string':'%5C%5Cr'%7D,'',true,false,true,false)To_Base64('A-Za-z0-9%2B/%3D')).

## Disclaimer

Use it at your own risk and follow good security practices when managing your VPS and SSH configuration.

[aarch64-shield]: https://img.shields.io/badge/aarch64-yes-green.svg
[amd64-shield]: https://img.shields.io/badge/amd64-yes-green.svg
[armhf-shield]: https://img.shields.io/badge/armhf-yes-green.svg
[armv7-shield]: https://img.shields.io/badge/armv7-yes-green.svg
[i386-shield]: https://img.shields.io/badge/i386-yes-green.svg
