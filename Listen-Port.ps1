
function Listen-Port ($port=80){
    $endpoint = new-object System.Net.IPEndPoint ([system.net.ipaddress]::any, $port)    
    $listener = new-object System.Net.Sockets.TcpListener $endpoint
    $listener.server.ReceiveTimeout = 3000
    $listener.start()    
    try {
    Write-Host "Listening on port $port, press CTRL+C to cancel"
    While ($true){
        if (!$listener.Pending())
        {
            Start-Sleep -Seconds 1; 
            continue; 
        }
        $client = $listener.AcceptTcpClient()
        $client.client.RemoteEndPoint | Add-Member -NotePropertyName DateTime -NotePropertyValue (get-date) -PassThru
        $client.close()
        }
    }
    catch {
        Write-Error $_          
    }
    finally{
            $listener.stop()
            Write-host "Listener Closed Safely"
    }

}

