function Get-DiaImagePercent {
    <#
    .SYNOPSIS
        Used by As Built Report to get base64 image percentage calculated from image width.
    .DESCRIPTION
        This allow the diagram image to fit the report page margins
    .NOTES
        Version:        0.2.30
        Author:         Jonathan Colon
    .EXAMPLE
    .LINK
    #>
    [CmdletBinding()]
    [OutputType([Hashtable])]
    param
    (
        [Parameter (
            Position = 0,
            Mandatory = $false,
            HelpMessage = 'Please provide Graphviz object'
        )]
        [string] $GraphObj,
        [Parameter(
            Position = 1,
            Mandatory = $false,
            HelpMessage = 'Please provide image file path'
        )]
        [ValidateScript( {
                if (Test-Path -Path $_) {
                    $true
                } else {
                    throw "File $_ not found!"
                }
            })]
        [string] $ImageInput,

        [Parameter (
            Mandatory = $false,
            HelpMessage = 'Set the image size in percent (100% is default)'
        )]
        [ValidateRange(10, 100)]
        [int] $Percent

    )

    begin {
        # Validate mandatory parameters
        if ((-not $PSBoundParameters.ContainsKey('ImageInput')) -and (-not $PSBoundParameters.ContainsKey('GraphObj'))) {
            throw "Error: Please provide a image path or a graphviz string to process."
        }
    }
    process {

        if ($GraphObj) {
            $ImagePrty = @{}
            try {
                $Image_FromStream = [System.Drawing.Image]::FromStream((New-Object System.IO.MemoryStream(, [convert]::FromBase64String($GraphObj))))
            } catch {
                Write-Verbose -Message "Unable to convert Graphviz object to base64 format needed to get image dimensions"
                Write-Debug -Message $($_.Exception.Message)
            }

            if ($Image_FromStream) {
                if ($Percent) {
                    $ImagePrty = @{
                        'Width' = ($Image_FromStream.Width / 100) * $Percent
                        'Height' = ($Image_FromStream.Height / 100) * $Percent
                    }
                } else {
                    $ImagePrty = @{
                        'Width' = $Image_FromStream.Width
                        'Height' = $Image_FromStream.Height
                    }
                }
                return $ImagePrty
            } else {
                Write-Verbose -Message "Unable to validate image dimensions"
            }
        } else {
            $ImagePrty = @{}
            try {
                $Image = [System.Drawing.Image]::FromFile((Get-ChildItem -Path $ImageInput).FullName)
            } catch {
                Write-Verbose -Message "Unable to validate image path needed to get image dimensions"
                Write-Debug -Message $($_.Exception.Message)
            }

            if ($Image) {
                if ($Percent) {
                    $ImagePrty = @{
                        'Width' = ($Image.Width / 100) * $Percent
                        'Height' = ($Image.Height / 100) * $Percent
                    }
                } else {
                    $ImagePrty = @{
                        'Width' = $Image.Width
                        'Height' = $Image.Height
                    }
                }
                return $ImagePrty
            } else {
                Write-Verbose -Message "Unable to validate image dimensions"
            }
        }
    }

    end {}

} # end