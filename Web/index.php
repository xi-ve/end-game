<?php
require_once "config.php";
function encryptDecrypt($toEncrypt, $key)
{
    $output = '';
    for ($i = 0; $i < strlen($toEncrypt); $i++) {
        //$output .= chr(ord($toEncrypt[$i]) ^ 0x13);
        $output .= chr(ord($toEncrypt[$i]) ^ ord($key[$i % strlen($key)]));
    }
    return $output;
}

function output($data)
{
    //die($data);
    $key = openssl_random_pseudo_bytes(10);
    die($key . encryptDecrypt($data, $key));
}


function ban($user, $reason, $discord_msg)
{
    $pass = $dbh->prepare("update login set l_banned = ? WHERE l_user = ?");
    $pass->execute([$reason, $reason]);
    //https://discord.com/api/webhooks/761702119559921664/P2IicIIN_QSdYp-shq-cZgV54kmKlKgucreOcqk60Xf-WB1lJeCtJrnLGIGlGMSQL8wv
    $json_data = json_encode([
        // Message
        "content" => "<@" . $user['l_discord'] . "> (" . $user['l_discord'] . ") was auto banned for: " . $discord_msg,

        // Username
        "username" => "PHP-Log",

        // Avatar URL.
        // Uncoment to replace image set in webhook
        //"avatar_url" => "https://ru.gravatar.com/userimage/28503754/1168e2bddca84fec2a63addb348c571d.jpg?size=512",

        // Text-to-speech
        "tts" => false,



    ], JSON_UNESCAPED_SLASHES | JSON_UNESCAPED_UNICODE);
    $ch = curl_init('https://discord.com/api/webhooks/761702119559921664/P2IicIIN_QSdYp-shq-cZgV54kmKlKgucreOcqk60Xf-WB1lJeCtJrnLGIGlGMSQL8wv');
    curl_setopt($ch, CURLOPT_HTTPHEADER, array('Content-type: application/json'));
    curl_setopt($ch, CURLOPT_POST, 1);
    curl_setopt($ch, CURLOPT_POSTFIELDS, $json_data);
    curl_setopt($ch, CURLOPT_FOLLOWLOCATION, 1);
    curl_setopt($ch, CURLOPT_HEADER, 0);
    curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1);

    $response = curl_exec($ch);
}

function parse_Post()
{
    foreach ($_POST as $key => $value) {
        $data_key =   substr($value, 0, 10);
        $data_data =  substr($value, 10);
        $_POST[$key] = base64_decode($value);
        $data_key =   substr($_POST[$key], 0, 10);
        $data_data =  substr($_POST[$key], 10);
        $_POST[$key] = encryptDecrypt($data_data, $data_key);
        //file_put_contents("log.txt",$key . " > " . base64_decode($value). PHP_EOL ,FILE_APPEND);
    }
}


if (!isset($_POST["user"]) && !isset($_POST['pass']) && !isset($_POST['hwid']) && !isset($_POST["action"])) {
    output("1"); //data not set
}
parse_Post();

$user = $dbh->prepare("select * from login where l_user = ?");
$user->execute([$_POST['user']]);
$user = $user->fetch();
if ($user === false) {
    output("2"); //no user found
}
if ($user['l_pass'] == NULL) {
    $pass = $dbh->prepare("update login set l_pass = ? WHERE l_user = ?");
    $pass->execute([password_hash($_POST['pass'], PASSWORD_DEFAULT), $_POST["user"]]);
} elseif (!password_verify($_POST['pass'], $user['l_pass'])) {
    output("3"); //password not matched
}


if ($user['l_hwid'] == NULL) {
    //update hwid
    $hwid = $dbh->prepare("update login set l_hwid = ? WHERE l_user = ?");
    $hwid->execute([$_POST["hwid"], $_POST["user"]]);
} elseif ($user["l_hwid"] != $_POST["hwid"]) {
    output("4"); //hwid invalid
}

if ($user["l_banned"] != NULL) {
    output("5|" . $user["l_banned"]);
}
if ($_POST['action'] == "get_options") {
    if (!isset($_POST['version']) && $_POST['version'] <> '0.1') {
        output("0");
    }

    $lic = $dbh->prepare("SELECT * FROM `exp`,`soft` WHERE l_id = ? AND e_exp > NOW() AND exp.s_id = soft.s_id");
    $lic->execute([$user['l_id']]);
    $out = 'DONE|';
    $count = 0;
    while ($row = $lic->fetch(PDO::FETCH_ASSOC)) {
        $out .= $row['s_name'] . PHP_EOL;
        $count += 1;
    }
    if ($count > 0) {
        output($out);
    } else {
        output("6");
    }
}

if ($_POST['action'] == "peer") {
    if (!isset($_POST["peerData"])) {
        output("1");
    }
    foreach (explode(PHP_EOL, $_POST['peerData']) as $line) {
        foreach (explode(PHP_EOL, file_get_contents('/data/blacklist.txt')) as $data) {
            if ($data == '') continue;
            if (strpos($line, $data) !== false) {
                //user banned
                ban($_POST["user"], "get fugged", $line);
                output("dead");
            }
        }
    }
    output("DONE");
    //file_put_contents("peer.txt",$_POST["peerData"]. PHP_EOL ,FILE_APPEND);
}



if ($_POST['action'] == "CryptoExchange") {
    if (!isset($_POST["Hash"])) {
        output("1");
    }
    ban($_POST["user"], "get fugged", "Process Validation");
    output("dead");
}


if ($_POST['action'] == "get_data") {
    if (!isset($_POST['version']) && $_POST['version'] <> '0.1') {
        output("0");
    }
    if (!isset($_POST["name"])) {
        output("1");
    }
    $lic = $dbh->prepare("SELECT * FROM `exp`,`soft` WHERE l_id = ? AND e_exp > NOW() AND exp.s_id = soft.s_id AND s_name = ?");
    $lic->execute([$user['l_id'], $_POST["name"]]);
    $out = 'DONE|';
    $data = $lic->fetch();
    if (!$data) {
        output("6");
    } else {
        header('Content-Type: application/octet-stream');
        $file = fopen($data['s_path'], "rb");
        output(fread($file, filesize($data['s_path'])));
    }
}

output("1");
//$key = openssl_random_pseudo_bytes(10);
//output($key . encryptDecrypt(file_get_contents("putty.exe"),$key));
