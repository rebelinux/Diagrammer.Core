function Get-RandomColorHex {
    # Generate random values for Red, Green, and Blue components (0-255)
    $red = Get-Random -Minimum 0 -Maximum 255
    $green = Get-Random -Minimum 0 -Maximum 255
    $blue = Get-Random -Minimum 0 -Maximum 255

    # Convert each component to a two-digit hexadecimal string
    $hexRed = "{0:X2}" -f $red
    $hexGreen = "{0:X2}" -f $green
    $hexBlue = "{0:X2}" -f $blue

    # Combine the hexadecimal components into a full color string
    $hexColor = "#$hexRed$hexGreen$hexBlue"

    return $hexColor
}