function Get-DiaImagePercent {
    <#
    .SYNOPSIS
        Used by As Built Report to get base64 image percentage calculated from image width.
    .DESCRIPTION
        This allow the diagram image to fit the report page margins
    .NOTES
        Version:        0.2.33
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
            $Image_FromStream = @{
                Width = 0
                Height = 0
            }
            switch ($PSVersionTable.Platform) {
                'Unix' {
                    & {
                        if ([ImageProcessor]) {
                            $Image_FromStream.Width = [ImageProcessor]::GetImageWidthFromBase64($GraphObj)
                            $Image_FromStream.Height = [ImageProcessor]::GetImageHeightFromBase64($GraphObj)
                        } else {
                            throw "Unable to convert Graphviz object to base64 format needed to get image dimensions"
                        }
                    }
                }
                default {
                    try {
                        $Image_FromStream = [System.Drawing.Image]::FromStream((New-Object System.IO.MemoryStream(, [convert]::FromBase64String($GraphObj))))
                    } catch {
                        throw "Unable to convert Graphviz object to base64 format needed to get image dimensions"
                    }
                }
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
                $ImageFromFile = @{
                    Width = 0
                    Height = 0
                }
                switch ($PSVersionTable.Platform) {
                    'Unix' {
                        & {
                            if ([ImageProcessor]) {
                                $ImageFromFile.Width = [ImageProcessor]::GetImageWidthFromFile((Get-ChildItem -Path $ImageInput).FullName)
                                $ImageFromFile.Height = [ImageProcessor]::GetImageHeightFromFile((Get-ChildItem -Path $ImageInput).FullName)
                            } else {
                                throw "Unable to get image dimensions on Unix platforms."
                            }
                        }
                    }
                    default {
                        $ImageFromFile = [System.Drawing.Image]::FromFile((Get-ChildItem -Path $ImageInput).FullName)
                    }
                }
            } catch {
                Write-Verbose -Message "Unable to validate image path needed to get image dimensions"
                Write-Debug -Message $($_.Exception.Message)
            }

            if ($ImageFromFile) {
                if ($Percent) {
                    $ImagePrty = @{
                        'Width' = ($ImageFromFile.Width / 100) * $Percent
                        'Height' = ($ImageFromFile.Height / 100) * $Percent
                    }
                } else {
                    $ImagePrty = @{
                        'Width' = $ImageFromFile.Width
                        'Height' = $ImageFromFile.Height
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