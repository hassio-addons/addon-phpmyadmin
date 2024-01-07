<?php

require('/data/config.secret.inc.php');

$cfg['AllowThirdPartyFraming'] = true;
$cfg['CheckConfigurationPermissions'] = false;
$cfg['ExecTimeLimit'] = 3600;
$cfg['SaveDir'] = '';
$cfg['TempDir'] = sys_get_temp_dir();
$cfg['UploadDir'] = '';
$cfg['VersionCheck'] = false;
$cfg['ZeroConf'] = false;

$cfg['Servers'][1]['host'] = getenv("SERVICE_HOST");
$cfg['Servers'][1]['port'] = getenv("SERVICE_PORT");
$cfg['Servers'][1]['auth_type'] = 'config';
$cfg['Servers'][1]['user'] = getenv("SERVICE_USERNAME");
$cfg['Servers'][1]['password'] = getenv("SERVICE_PASSWORD");
