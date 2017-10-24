<#
.SYNOPSIS
.EXAMPLE
    PS C:\temp> hhd-android-adb-screencap2 -Verbose
    자세한 정보 표시: ReadAllBytes ...
    자세한 정보 표시: convert ...
    자세한 정보 표시: WriteAllBytes ...
    C:\temp\screencapture-171025-001627.png
#>
function adb-screencap
{
    [CmdletBinding()]
    param
    (
    )

    

    Write-Debug "adb shell screencap -p ..."
    adb start-server
    $fileName = "screencapture-$([datetime]::Now.ToString(`"yyMMdd-HHmmss`")).png"
    $cmd = "cmd.exe /C `"adb shell screencap -p > $fileName`""
    Invoke-Expression -Command $cmd
    

    Write-Verbose "ReadAllBytes ..."
    $fileBytes = [System.IO.File]::ReadAllBytes("$pwd\$fileName")


    Write-Verbose "convert ..."
    $newFileBytes = New-Object System.Collections.Generic.List[byte]

    for($i = 0; $i -lt $fileBytes.Length - 2; $i = $i + 1) 
    {
        if (($fileBytes[$i] -eq 0x0D) -and 
            ($fileBytes[$i + 1] -eq 0x0D) -and 
            ($fileBytes[$i + 2] -eq 0x0A))
        {
            $newFileBytes.Add(0x0A)
            $i = $i + 2
        }
        else 
        {
            $newFileBytes.Add($fileBytes[$i])
        }
    }

    Write-Verbose "WriteAllBytes ..."
    [System.IO.File]::WriteAllBytes("$pwd\$fileName", $newFileBytes)
    return "$pwd\$fileName"
}