$ProgressPreference = 'SilentlyContinue'

$WixDownloadUrl = "https://wixtoolset.org/downloads/v3.14.0.6526/wix314.exe"
$WixBinariesDownloadUrl = "https://wixtoolset.org/downloads/v3.14.0.6526/wix314-binaries.zip"

# Download WiX binaries and verify their hash sums
Invoke-WebRequest -Uri $WixDownloadUrl -OutFile "$($ENV:Temp)\wix314.exe"
$Hash = (Get-FileHash -Algorithm SHA256 "$($ENV:Temp)\wix314.exe").Hash
if ($Hash -ne 'FADEB00B1FCCD9BB2FDD6CE28D4C3ECDA339C8906A72586515C14A93CEADB6FE')
{
    Write-Error "$WixHash"
    throw "wix314.exe has unexpected SHA256 hash: $Hash"
}
Invoke-WebRequest -Uri $WixBinariesDownloadUrl -OutFile "$($ENV:Temp)\wix314-binaries.zip"
$Hash = (Get-FileHash -Algorithm SHA256 "$($ENV:Temp)\wix314-binaries.zip").Hash
if($Hash -ne '4C89898DF3BCAB13E12F7CA54399C35AD273475AD2CB6284611D00AE2D063C2C')
{
    throw "wix314-binaries.zip has unexpected SHA256 hash: $Hash"
}

# Install WiX
Start-Process -Wait -FilePath "$($ENV:Temp)\wix314.exe" -ArgumentList "/install /quiet"

# Extract WiX binaries and copy wix.targets to the installed dir
Expand-Archive -Path "$($ENV:Temp)\wix314-binaries.zip" -Force -DestinationPath "$($ENV:Temp)"
Copy-Item -Path "$($ENV:Temp)\wix.targets" -Destination "C:\Program Files (x86)\WiX Toolset v3.14\"
<databaseChangeLog
        xmlns="http://www.liquibase.org/xml/ns/dbchangelog"
        xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
        xsi:schemaLocation="http://www.liquibase.org/xml/ns/dbchangelog
	  http://www.liquibase.org/xml/ns/dbchangelog/dbchangelog-3.8.xsd">

    <changeSet id="V0.12-20220424-001" author="Chambers" labels="space">
        <comment>Space Invite Record Table add space_id index</comment>
        <sql>
            ALTER TABLE `${table.prefix}space_invite_record`
            ADD INDEX `idx_space_id`(`invite_space_id`) USING BTREE;
        </sql>
    </changeSet>

    <changeSet id="V0.12-20220424-002" author="Chambers" labels="space">
        <comment>Space Invite Record Table add email index</comment>
        <sql>
            ALTER TABLE `${table.prefix}space_invite_record`
            ADD INDEX `idx_email`(`invite_email`) USING BTREE;
        </sql>
    </changeSet>
