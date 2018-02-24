# PSMarvel
PSMarvel is a module created to consume the **Marvel Comics REST API (https://developer.marvel.com/).**

## Table of Contents

- [Contributing](#contributing)
- [Usage](#usage)
  - [Installation](#installation)
  - [Commands](#commands-available)
  - [Installation](#installation)
- [Related posts](#related-posts)
- [Resources](#resources)


## Contributing

Contributions are more than welcome! 🚀💻 Feel free to participate via pull requests or issues.

## Usage

### Installation

Install the module from the [PowerShell Gallery](https://www.powershellgallery.com/) with the command:

```powershell
Install-Module -Name PSMarvel
```

### First run

In the first run, you will be asked about your public key and private keys of the developer's portal. After that, the keys will be saved in environment variables (while the script is running it uses global variables, because it needs to restart the session to update them):

```powershell
PS C:\Users\vmsilvamolina> Get-MarvelRandomCharacter
Write your public key from the Marvel portal: baf813e65986ffdb43856b3957acda38
Write your private key from the Marvel portal: 62f28fe9b3893112146e8d4add4b7ab571f03f41

## Character name: 

     Iron Patriot (James Rhodes)

## Description: 

    No description available.

## Series: 

     Art of Marvel Studios TPB Slipcase (2011 - Present)
     Avengers West Coast (1985 - 1994)
     Avengers West Coast Annual (1986 - 1993)
     Avengers: The Initiative (2007 - 2010)
     Avengers: The Terminatrix Objective (1993)
     Crew (2003)
     Fear Itself: The Fearless (2011 - 2012)
     Hulk (2008 - 2012)
     Incredible Hulks (2009 - 2011)
     Invincible Iron Man (2008 - 2012)
     Invincible Iron Man Vol. 1: The Five Nightmares (2009 - Present)
     Invincible Iron Man Vol. 4: Stark Disassembled (2011 - Present)
     Iron Man (1998 - 2004)
     Iron Man (1968 - 1996)
     Iron Man 2.0 (2011)
     Iron Man 2.0: Modern Warfare (2011)
     Iron Man Annual (1970 - 1994)
     Iron Man Legacy (2010 - 2011)
     Iron Man: Rapture TPB (2011)
     Iron Man: The Rapture (2010 - 2011)

## Comics: 

     Art of Marvel Studios TPB Slipcase (Hardcover)
     Avengers West Coast (1985) #100
     Avengers West Coast (1985) #101
     Avengers West Coast Annual (1986) #8
     Avengers: The Initiative (2007) #11
     Avengers: The Initiative (2007) #12
     Avengers: The Initiative (2007) #15
     Avengers: The Initiative (2007) #16
     Avengers: The Terminatrix Objective (1993) #1
     Avengers: The Terminatrix Objective (1993) #2
     Avengers: The Terminatrix Objective (1993) #3
     Avengers: The Terminatrix Objective (1993) #4
     Crew (2003) #1
     Crew (2003) #2
     Crew (2003) #4
     Crew (2003) #5
     Crew (2003) #7
     Fear Itself: The Fearless (2011) #3
     Hulk (2008) #42
     Hulk (2008) #43

PS C:\Users\vmsilvamolina>
```


### Commands available

The following commands are available:

```powershell
Get-Command -Module PSMarvel
```

```text
CommandType     Name                                               Version    Source
-----------     ----                                               -------    ------
Function        Find-MarvelCharacter                               1.0.3      PSMarvel
Function        Find-MarvelComic                                   1.0.3      PSMarvel
Function        Get-MarvelCharacter                                1.0.3      PSMarvel
Function        Get-MarvelComic                                    1.0.3      PSMarvel
Function        Get-MarvelRandomCharacter                          1.0.3      PSMarvel
```

## Related posts

* [PSMarvel PowerShell module](https://blog.victorsilva.com.uy/marvel-from-powershell/) by [@vmsilvamolina](https://twitter.com/vmsilvamolina)

## Resources

* [Marvel Comics REST API documentation](https://developer.marvel.com/documentation/getting_started)
* [Invoke-RestMethod command documentation](https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.utility/invoke-restmethod?view=powershell-6)
