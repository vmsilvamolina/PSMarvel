function New-MarvelTimeSpan {
#API Keys and TS
$global:MarvelTS = New-TimeSpan -End (Get-Date -Year 2018 -Month 1 -Day 1)

[Environment]::GetEnvironmentVariables("Machine") | out-null
$checkVariable = Get-ChildItem Env:MarvelPublicKey -ErrorAction SilentlyContinue
if ($checkVariable.count -eq 0) {
    if (!(Test-Path variable:global:MarvelPublicKey)) {
        $PublicKeyPrompt = Read-Host -Prompt "Write your public key from the Marvel portal"
        [Environment]::SetEnvironmentVariable("MarvelPublicKey", "$PublicKeyPrompt", "Machine")
        $global:MarvelPublicKey = $PublicKeyPrompt
        $PrivateKeyPrompt = Read-Host -Prompt "Write your private key from the Marvel portal"
        [Environment]::SetEnvironmentVariable("MarvelPrivateKey", "$PrivayeKeyPrompt", "Machine")
        $global:MarvelPrivateKey = $PrivateKeyPrompt
    }
} else {
    $global:MarvelPublicKey = $env:MarvelPublicKey
    $global:MarvelPrivateKey = $env:MarvelPrivateKey
}

#Form the hash as Marvel requires 
$ToHash = $MarvelTS.ToString() + $MarvelPrivateKey.ToString() + $MarvelPublicKey.ToString()
$StringBuilder = New-Object System.Text.StringBuilder 
[System.Security.Cryptography.HashAlgorithm]::Create("MD5").ComputeHash([System.Text.Encoding]::UTF8.GetBytes($ToHash)) | % {
    [Void]$StringBuilder.Append($_.ToString("x2")) 
}
$global:MD5 = $StringBuilder.ToString()
}

function Get-MarvelRandomCharacter {
    New-MarvelTimeSpan
    $MarvelOffset = Get-Random -Maximum 1490

    $Url = "https://gateway.marvel.com:443/v1/public/characters?offset=$MarvelOffset&limit=1&apikey=$MarvelPublicKey&hash=$MD5&ts=$MarvelTS"
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
        Write-host "    N/A"
    }
    Write-host "`n## Comics: `n"  -ForegroundColor Green
    $Comics = $output.data.results.comics.items.name
    if ($Comics -gt 0) {
        $Comics | % {Write-host "    " $_}
    } else {
        Write-host "    N/A"
    }
}

function Find-MarvelCharacter {
    [CmdletBinding()]
    param(
    [Parameter(Mandatory)][string]$StartWith
    )

    New-MarvelTimeSpan
    $MarvelOffset = Get-Random -Maximum 1490

    $Url = "https://gateway.marvel.com:443/v1/public/characters?nameStartsWith=$StartWith&apikey=$MarvelPublicKey&hash=$MD5&ts=$MarvelTS"
    $Results = Invoke-WebRequest $Url
    $Content = $results.Content
    $Output = ConvertFrom-Json $Content
    
    Write-Host "`n## Character names: `n" -ForegroundColor Green
    $Output.data.results.name | % {Write-host "    " $_}
    
}

function Get-MarvelCharacter {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory)][string]$Name
    )

    New-MarvelTimeSpan
    $MarvelOffset = Get-Random -Maximum 1490
    $NameModified = $Name.Replace(" ","%20")
    $Url = "https://gateway.marvel.com:443/v1/public/characters?name=$NameModified&limit=1&apikey=$MarvelPublicKey&hash=$MD5&ts=$MarvelTS"
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

function Find-MarvelComic {
    [CmdletBinding()]
    param(
    [Parameter(Mandatory)][string]$StartWith
    )

    New-MarvelTimeSpan

    $Url = "https://gateway.marvel.com:443/v1/public/comics?titleStartsWith=$StartWith&apikey=$MarvelPublicKey&hash=$MD5&ts=$MarvelTS"
    $Results = Invoke-WebRequest $Url
    $Content = $results.Content
    $Output = ConvertFrom-Json $Content
    
    Write-Host "`n## Comic info: `n" -ForegroundColor Green
    $Output.data.results | select title, description, format, pageCount

}

function Get-MarvelComic {
    [CmdletBinding()]
    param(
    [Parameter(Mandatory)][string]$Title
    )

    New-MarvelTimeSpan

    $issueNumber = $Title.Split("#")[1]
    $startYear = $Title.Split("(")[1].Split(")")[0]
    $Title = $Title.split("(")[0] -replace ".$"
    $Url = "https://gateway.marvel.com:443/v1/public/comics?title=$Title&issueNumber=$issueNumber&startYear=$startYear&apikey=$MarvelPublicKey&hash=$MD5&ts=$MarvelTS"
    $Results = Invoke-WebRequest $Url
    $Content = $results.Content
    $Output = ConvertFrom-Json $Content

    Write-Host "`n## Comic title: `n" -ForegroundColor Green
    $Name = $Output.data.results.title
    Write-host "    " $Name
    Write-Host "`n## Description: `n" -ForegroundColor Green
    $Description = $Output.data.results.description
    if ($Description.Length -eq 0) {
        Write-host "    No description available."
    } else {
        Write-host $Description
    }
    Write-Host "`n## Series: `n"  -ForegroundColor Green
    $Series = $Output.data.results.series.name
    if ($Series -ne 0) {
        $Series | % {Write-host "    " $_}
    } else {
        Write-host "N/A"
    }
    Write-host "`n## Format: `n"  -ForegroundColor Green
    Write-host "    " $Output.data.results.format
    Write-host "`n## Creators: `n"  -ForegroundColor Green
    $Output.data.results.creators.items | % {Write-host "    " $_.name "/" $_.role}
}