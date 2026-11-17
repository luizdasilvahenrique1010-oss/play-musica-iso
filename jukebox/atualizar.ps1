# Gera o arquivo biblioteca.js com a lista de musicas e imagens desta pasta.
$root = $PSScriptRoot
$ext = '.mp3','.wav','.ogg','.oga','.m4a','.aac','.flac','.opus','.wma','.mp4','.m4v','.webm','.mkv','.mov','.avi','.mpg','.mpeg','.3gp','.ogv','.wmv','.jpg','.jpeg','.png','.webp','.gif','.bmp'
$files = Get-ChildItem -LiteralPath $root -Recurse -File | Where-Object { $ext -contains $_.Extension.ToLower() }
$list = @($files | ForEach-Object { $_.FullName.Substring($root.Length + 1).Replace('\', '/') })
$json = ConvertTo-Json -InputObject $list
$js = 'window.BIBLIOTECA=' + $json + ';'
[System.IO.File]::WriteAllText((Join-Path $root 'biblioteca.js'), $js, (New-Object System.Text.UTF8Encoding($false)))
Write-Host ''
Write-Host ('Pronto! ' + $list.Count + ' arquivos (musicas e imagens) encontrados.')
Write-Host 'Agora abra o index.html.'
