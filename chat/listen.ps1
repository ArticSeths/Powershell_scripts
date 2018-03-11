

Function Receive-TCPMessage {
    Param ( 
        [Parameter(Mandatory=$true, Position=0)]
        [ValidateNotNullOrEmpty()] 
        [int] $Port
    ) 
    Process {
        Try {
            # Set up endpoint and start listening
            $endpoint = new-object System.Net.IPEndPoint([ipaddress]::any,$port) 
            $listener = new-object System.Net.Sockets.TcpListener $EndPoint
            $listener.start() 
            While ($true){
                
 
                # Wait for an incoming connection 
                $data = $listener.AcceptTcpClient() 
        
                # Stream setup
                $stream = $data.GetStream() 
                $bytes = New-Object System.Byte[] 1024

                # Read data from stream and write it to host
                while (($i = $stream.Read($bytes,0,$bytes.Length)) -ne 0){
                    $EncodedText = New-Object System.Text.ASCIIEncoding
                    $data = $EncodedText.GetString($bytes,0, $i)
                    Write-Output $data
                }
         
                # Close TCP connection and stop listening
                $stream.close()
            }
        }
        Catch {
            "Receive Message failed with: `n" + $Error[0]
        }
        finally{
            $listener.stop()
            Write-host "Listener Closed Safely"
        }
    }
}

Receive-TCPMessage -Port 29800