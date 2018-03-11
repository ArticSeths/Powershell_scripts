$url = 'https://spotifycharts.com/api/?download=true&limit=200&country=global&recurrence=daily&date=latest&type=regional'
$outfile = 'C:\Users\ArticDirex\OneDrive\Documentos en la nube\SpotifyBot\list.csv'
Invoke-WebRequest -Uri $url -OutFile $outfile
Import-Csv "C:\Users\ArticDirex\OneDrive\Documentos en la nube\SpotifyBot\list.csv" | %{
$YTquery="https://www.youtube.com/results?search_query="+$_."Track Name"
$YTqueryReq=Invoke-WebRequest -Uri $YTquery
$YTqueryReq.ParsedHtml.getElementsByTagName(‘div’) | Where{$_.className -eq ‘yt-lockup yt-lockup-tile yt-lockup-video clearfix’}
}