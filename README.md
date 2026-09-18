# Veeam-Port-Test
Small script for testing ports needed by Veeam VBR server

Tests the TCP ports Veeam Backup & Replication needs open to a managed Windows or Hyper-V host, and prints OPEN or BLOCKED for each one.

Useful when a backup job fails with a connection or agent deployment error and you need to know whether it is a firewall problem before opening a support case.

## Usage

Edit the hostname at the top of the script, then run it.

```powershell
$HyperVHost = "hv01.contoso.local"
```

```powershell
.\Veeam_Port_Test.ps1
```

```
Port Success Status
---- ------- ------
 135    True OPEN
 445    True OPEN
5985    True OPEN
5986   False BLOCKED
6160    True OPEN
6162    True OPEN
2500    True OPEN
3300    True OPEN
```

No modules required. PowerShell 5.1 or later. Read-only, and it changes nothing on either machine.

## Ports tested

| Port | Used for |
|---|---|
| 135 | RPC endpoint mapper, used for component deployment |
| 445 | SMB, used to push the Veeam components to the host |
| 5985 | WinRM over HTTP |
| 5986 | WinRM over HTTPS |
| 6160 | Veeam Installer Service |
| 6162 | Veeam Data Mover Service |
| 2500 | First port of the default data transmission range |
| 3300 | Last port of the default data transmission range |

## Notes

- Ports 2500 and 3300 are the boundaries of the data transmission range. Only those two are tested, not every port between them. If both are open and backups still fail mid-transfer, confirm the whole range is permitted.
- 5986 showing as BLOCKED is normal when WinRM over HTTPS is not configured. It matters only if your environment requires it.
- `Test-NetConnection` reports whether a TCP connection can be established. An OPEN result does not confirm that the Veeam service behind the port is running or that authentication will succeed.
- To test several hosts, wrap the script in a loop over a host list, or change `$HyperVHost` and run it again.

## Related

- Free Microsoft 365, Active Directory, and Veeam tools at [m365admintools.com](https://m365admintools.com)

## Author

Charles Arconi, [m365admintools.com](https://m365admintools.com)

Not affiliated with, endorsed by, or supported by Veeam Software. Veeam is a trademark of Veeam Software Group GmbH.

## License

MIT. See [LICENSE](LICENSE).
