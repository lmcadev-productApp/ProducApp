Import-Module Posh-SSH

# Variables
$user = "yuliana"
$ip = "145.223.79.134"
$port = 22
$password = "212QjLRTKWJeTtA"

$localDeployPath = ".."                     # Ruta local donde está docker-compose.yml y carpetas backend, frontend
$remotePath = "/home/yuliana/deploy"        # Ruta remota en el VPS

# Crear credencial
$securePass = ConvertTo-SecureString $password -AsPlainText -Force
$cred = New-Object System.Management.Automation.PSCredential ($user, $securePass)

# Función para subir carpetas recursivamente
function Upload-Folder($sessionId, $localFolder, $remoteFolder) {
    Write-Host "Subiendo carpeta $localFolder a $remoteFolder ..."
    $items = Get-ChildItem -Path $localFolder
    foreach ($item in $items) {
        if ($item.PSIsContainer) {
            # Crear carpeta remota
            Invoke-SSHCommand -SessionId $sessionId -Command "mkdir -p `"$remoteFolder/$($item.Name)`"" | Out-Null
            # Subir recursivamente
            Upload-Folder $sessionId $item.FullName "$remoteFolder/$($item.Name)"
        } else {
            # Subir archivo
            Set-SFTPFile -SessionId $sessionId -LocalFile $item.FullName -RemotePath "$remoteFolder/$($item.Name)"
            Write-Host "  Archivo $($item.Name) subido."
        }
    }
}

try {
    Write-Host "Creando sesión SFTP..."
    $sftpSession = New-SFTPSession -ComputerName $ip -Credential $cred -Port $port -AcceptKey

    Write-Host "Creando carpeta remota (si no existe)..."
    Invoke-SSHCommand -SessionId $sftpSession.SessionId -Command "mkdir -p $remotePath" | Out-Null

    # Subir docker-compose.yml
    Write-Host "Subiendo docker-compose.yml..."
    Set-SFTPFile -SessionId $sftpSession.SessionId -LocalFile "$localDeployPath/docker-compose.yml" -RemotePath "$remotePath/docker-compose.yml"

    # Subir carpetas backend y frontend (opcional, si las tienes localmente)
    Upload-Folder -sessionId $sftpSession.SessionId -localFolder "$localDeployPath/backend" -remoteFolder "$remotePath/backend"
    Upload-Folder -sessionId $sftpSession.SessionId -localFolder "$localDeployPath/frontend" -remoteFolder "$remotePath/frontend"

    # Cerrar sesión SFTP
    Remove-SFTPSession -SessionId $sftpSession.SessionId

    Write-Host "Creando sesión SSH para ejecutar docker-compose..."
    $sshSession = New-SSHSession -ComputerName $ip -Credential $cred -Port $port -AcceptKey

    # Verificar si Docker está instalado
    $dockerCheck = Invoke-SSHCommand -SessionId $sshSession.SessionId -Command "docker --version"
    Write-Host "Docker versión en VPS: " $dockerCheck.Output

    # Ejecutar docker-compose up -d
    $cmd = "cd $remotePath; docker-compose up -d"
    Write-Host "Ejecutando: $cmd"
    $result = Invoke-SSHCommand -SessionId $sshSession.SessionId -Command $cmd
    Write-Host "Resultado del deploy:`n" + $result.Output

    # Cerrar sesión SSH
    Remove-SSHSession -SessionId $sshSession.SessionId

    Write-Host "Deploy completado."
}
catch {
    Write-Error "Ocurrió un error: $_"
    if ($sftpSession) { Remove-SFTPSession -SessionId $sftpSession.SessionId }
    if ($sshSession) { Remove-SSHSession -SessionId $sshSession.SessionId }
}
