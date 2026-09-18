$HyperVHost = "hostname-or-IP"

$ports = @(135, 445, 5985, 5986, 6160, 6162, 2500, 3300)

$results = foreach ($port in $ports) {
    $result = Test-NetConnection -ComputerName $HyperVHost -Port $port -WarningAction SilentlyContinue
    [PSCustomObject]@{
        Port    = $port
        Success = $result.TcpTestSucceeded
        Status  = if ($result.TcpTestSucceeded) { "OPEN" } else { "BLOCKED" }
    }
}

$results | Format-Table -AutoSize