Function Send-TCPMessage { 
    Param ( 
            [Parameter(Mandatory=$true, Position=1)]
            [ValidateNotNullOrEmpty()] 
            [string] 
            $EndPoint
        , 
            [Parameter(Mandatory=$true, Position=0)]
            [int]
            $Port
        , 
            [Parameter(Mandatory=$true, Position=2)]
            [string]
            $Message
    ) 
    Process {
        # Setup connection 
        $IP = [System.Net.Dns]::GetHostAddresses($EndPoint) 
        $Address = [System.Net.IPAddress]::Parse($IP) 
        $Socket = New-Object System.Net.Sockets.TCPClient($Address,$Port) 
    
        # Setup stream wrtier 
        $Stream = $Socket.GetStream() 
        $Writer = New-Object System.IO.StreamWriter($Stream)

        # Write message to stream
        $Message | % {
            $Writer.WriteLine($_)
            $Writer.Flush()
        }
    
        # Close connection and stream
        $Stream.Close()
        $Socket.Close()
    }
}

#ip jesu : 192.168.137.40


#Send-TCPMessage -Port 29800 -Endpoint 192.168.0.1 -message "My first TCP message !"