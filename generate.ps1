Clear-Host
$ErrorView = 'NormalView'

# Get dirs
$dir = Split-Path $MyInvocation.MyCommand.Path
$config = Get-Content -Path "$dir\config.ini"
$list = Get-Content -Path "$dir\list.txt" | Where-Object { $_ -ne '' }

# Default values
$hex = "000000", "ffffff"
$header = "[", "]"
$headerInt = 1

# Initialize arrays
$separator = [String[]]::new($list.Length + 1)
$separatorAppend = [String[]]::new($list.Length + 1)

function getConfig { # Parses ./config.ini
    Write-Output "`nReading config..."

    foreach ($line in $global:config) {
        if ($line.StartsWith("[") -or $line.StartsWith(";") -or $line -eq "") { continue }

        # Get color values
        if ($line.StartsWith("colorStart = ")) {
            $global:hex[0] = $line -replace 'colorStart = '
            if ($global:hex[0].StartsWith("#")) {$global:header[0] = -replace "#"}
        }
        if ($line.StartsWith("colorEnd = ")) {
            $global:hex[1] = $line -replace 'colorEnd = '
            if ($global:hex[1].StartsWith("#")) {$global:header[1] = -replace "#"}
        }

        # Get header decoration values
        if ($line.StartsWith("headerStart = ")) {
            $global:header[0] = $line -replace 'headerStart = ' -replace '"'
            if ($global:header[0].EndsWith(" ")) {} else { $global:header[0] = $global:header[0] + " " }
        }
        if ($line.StartsWith("headerEnd = ")) {
            $global:header[1] = $line -replace 'headerEnd = ' -replace '"'
            if ($global:header[1].StartsWith(" ")) {} else { $global:header[1] = " " + $global:header[1]}
        }
    }
    
    # Output
    $configOut = "Gradient range set to #" + $global:hex[0] + " -> #" + $global:hex[1] + "`nHeader decor set to " + $global:header[0] + "HEADER" + $global:header[1]
    Write-Output $configOut
}

function indexSeparators {
    Write-Output "`nReading separator list..."
    $number = $lineNum = 1
    $header = 0

    foreach ($line in $global:list) {
        if ($line.StartsWith(";") -or $line -eq "") { continue }

        # Decorate headers
        if ($line.StartsWith("! ")) {
            $newLine = $global:header[0] + ($line.ToUpper() -replace "! ") + $global:header[1]
            $local:header += 1
        }

        # Numberize non-headers
        else {
            $newLine = "$number. $line"
            $number += 1
        }

        $global:separator[$lineNum] = $newLine
        $global:separatorAppend[$lineNum] = "+" + $newLine + "_separator"
        $lineNum += 1
    }

    # Globalize header count
    $global:headerInt = $local:header
}

function getGradientRange {
    Add-Type -Assembly System.Drawing

    $start = $hex[0]
    $end = $hex[1]
    $stepCount = $headerInt

    $startColor = [System.Drawing.Color]::FromArgb(0, [System.Convert]::ToInt32($start.Substring(0,2), 16), [System.Convert]::ToInt32($start.Substring(2,2), 16), [System.Convert]::ToInt32($start.Substring(4,2), 16))
    $endColor = [System.Drawing.Color]::FromArgb(0, [System.Convert]::ToInt32($end.Substring(0,2), 16), [System.Convert]::ToInt32($end.Substring(2,2), 16), [System.Convert]::ToInt32($end.Substring(4,2), 16))

    $rStep = ($endColor.R - $startColor.R) / $stepCount
    $gStep = ($endColor.G - $startColor.G) / $stepCount
    $bStep = ($endColor.B - $startColor.B) / $stepCount

    for ($i = 0; $i -lt $stepCount; $i++) {
        $r = [math]::Round($startColor.R + ($rStep * $i))
        $g = [math]::Round($startColor.G + ($gStep * $i))
        $b = [math]::Round($startColor.B + ($bStep * $i))

        $color = [System.Drawing.Color]::FromArgb(0, $r, $g, $b)
        $global:gradient[$i] = "{0:X2}{1:X2}{2:X2}" -f $color.R, $color.G, $color.B
    }

    Write-Host "Gathered gradient range: " -NoNewline
    foreach ($item in $global:gradient) {

        Write-Host "$item" -NoNewline
        if ($global:gradient.IndexOf($item) -lt ($global:gradient.Length - 1)) { Write-Host ", " -NoNewline }
    }
}

function makeProfile {

    # Reverse appended array
    $init = $global:separatorAppend
    [array]::Reverse($init)
    
    # Output to modlist.txt
    New-Item -Path "$dir/profiles/test/modlist.txt" -ItemType File -Force | Out-Null
    $init | Set-Content "$dir/profiles/test/modlist.txt"
    Write-Output "`nCreated modlist.txt"
}

function makeFolders {
    getGradientRange

    Write-Output "`n`nCreating separator directories..."
    $header = -1

    foreach ($item in $global:separatorAppend) {
        if ($null -eq $item) { continue }

        # Create separator folders
        $name = $item -replace "^\+"
        New-Item -Path "$dir/mods/$name" -ItemType Directory -Force | Out-Null

        #Create meta files for header coloring
        if ($name.StartsWith($global:header[0])) {
            $local:header += 1
            $content = "[General]`ncolor=#" + $global:gradient[$local:header]
            New-Item -Path "$dir/mods/$name/meta.ini" -Value $content -ItemType File -Force | Out-Null
        }
        
        Write-Output "Created directory for $name"
    }
}

getConfig
indexSeparators
makeProfile
$gradient = [String[]]::new($headerInt)
makeFolders

Start-Sleep -s 3