function New-MarvelTimeSpan {
#API Keys and TS
$global:MarvelPublic = "baf813e65986ffdb43856b3957acda38"
$global:MarvelPrivate = "62f28fe9b3893112146e8d4add4b7ab571f03f41"
$global:MarvelTS = New-TimeSpan -End (Get-Date -Year 2018 -Month 1 -Day 1)

#Form the hash as Marvel requires 
$ToHash = $MarvelTS.ToString() + $MarvelPrivate.ToString() + $MarvelPublic.ToString()
$StringBuilder = New-Object System.Text.StringBuilder 
[System.Security.Cryptography.HashAlgorithm]::Create("MD5").ComputeHash([System.Text.Encoding]::UTF8.GetBytes($ToHash)) | % {
    [Void]$StringBuilder.Append($_.ToString("x2")) 
}
$global:MD5 = $StringBuilder.ToString()
}

function Get-MarvelRandomCharacter {
    New-MarvelTimeSpan
    $MarvelOffset = Get-Random -Maximum 1490

    $Url = "https://gateway.marvel.com:443/v1/public/characters?offset=$MarvelOffset&limit=1&apikey=$MarvelPublic&hash=$MD5&ts=$MarvelTS"
    $Results = Invoke-WebRequest $Url
    $Content = $results.Content
    $Output = ConvertFrom-Json $Content
    
    Write-Host "`n## Character name: `n" -ForegroundColor Green
    $Name = $Output.data.results.name
    Write-host "    " $Name
    Write-Host "`n## Description: `n" -ForegroundColor Green
    $Description = $Output.data.results.description
    if ($Description.Length -ge 0) {
        Write-host "    No description available."
    } else {
        Write-host $Description
    }
    Write-Host "`n## Series: `n"  -ForegroundColor Green
    $Series = $output.data.results.series.items.name
    if ($Series -gt 0) {
        $Series | % {Write-host "    " $_}
    } else {
        Write-host "N/A"
    }
    Write-host "`n## Comics: `n"  -ForegroundColor Green
    $Comics = $output.data.results.comics.items.name
    if ($Comics -gt 0) {
        $Comics | % {Write-host "    " $_}
    } else {
        Write-host "N/A"
    }
}

function Find-MarvelCharacter {
    param(
    [string]$StartWith
    )

    New-MarvelTimeSpan
    $MarvelOffset = Get-Random -Maximum 1490

    $Url = "https://gateway.marvel.com:443/v1/public/characters?nameStartsWith=$StartWith&apikey=$MarvelPublic&hash=$MD5&ts=$MarvelTS"
    $Results = Invoke-WebRequest $Url
    $Content = $results.Content
    $Output = ConvertFrom-Json $Content
    
    Write-Host "`n## Character name: `n" -ForegroundColor Green
    $Output.data.results.name | % {Write-host "    " $_}
    
}

function Get-MarvelCharacter {
    param(
        [string]$Name
    )

    New-MarvelTimeSpan
    $MarvelOffset = Get-Random -Maximum 1490
    $NameModified = $Name.Replace(" ","%20")
    $Url = "https://gateway.marvel.com:443/v1/public/characters?name=$NameModified&limit=1&apikey=$MarvelPublic&hash=$MD5&ts=$MarvelTS"
    $Results = Invoke-WebRequest $Url
    $Content = $results.Content
    $Output = ConvertFrom-Json $Content
    
    Write-Host "`n## Character name: `n" -ForegroundColor Green
    $Name = $Output.data.results.name
    Write-host "    " $Name
    Write-Host "`n## Description: `n" -ForegroundColor Green
    $Description = $Output.data.results.description
    if ($Description.Length -ge 0) {
        Write-host "    No description available."
    } else {
        Write-host $Description
    }
    Write-Host "`n## Series: `n"  -ForegroundColor Green
    $Series = $output.data.results.series.items.name
    if ($Series -gt 0) {
        $Series | % {Write-host "    " $_}
    } else {
        Write-host "N/A"
    }
    Write-host "`n## Comics: `n"  -ForegroundColor Green
    $Comics = $output.data.results.comics.items.name
    if ($Comics -gt 0) {
        $Comics | % {Write-host "    " $_}
    } else {
        Write-host "N/A"
    }
}