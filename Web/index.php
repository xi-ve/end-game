<?php
require_once "config.php";
function encryptDecrypt($toEncrypt,$key) {
    $output= '';
    for ( $i = 0; $i < strlen($toEncrypt); $i++ ) {
        $output .= $toEncrypt[$i] ^ $key[$i % strlen($key)];
    }
    return $output;
} 
function output($data){
    $key = openssl_random_pseudo_bytes(10);
    die($key . encryptDecrypt($data,$key));
}


function parse_Post(){
    foreach($_POST as $key => $value)
    {
        $data_key =   substr($value,0,10);
        $data_data =  substr($value,10);
        $_POST[$key] = encryptDecrypt($data_data,$data_key);
        //echo encryptDecrypt($data_data,$data_key) . PHP_EOL;
    }
}


if(!isset($_POST["user"]) && !isset($_POST['pass']) && !isset($_POST['hwid'])){
    output("1");//data not set
}
parse_Post();
$user = $dbh->prepare("select * from login where l_user = ?");
$user->execute([$_POST['user']]);
$user = $user->fetch();
if ($user === false){
    output("2");//no user found
}
if ($user['l_pass'] == NULL){
    $pass = $dbh->prepare("update login set l_pass = ? WHERE l_user = ?");
    $pass->execute([password_hash($_POST['pass'],PASSWORD_DEFAULT),$_POST["user"]]);
}elseif (!password_verify($_POST['pass'],$user['l_pass'])){
    output("3");//password not matched
}

if(strtotime($user["l_exp"]) < time()){
    output("4");//expired
}

if ($user['l_hwid'] == NULL){
//update hwid
$hwid = $dbh->prepare("update login set l_hwid = ? WHERE l_user = ?");
$hwid->execute([$_POST["hwid"],$_POST["user"]]);

}elseif($user["l_hwid"] != $_POST["hwid"]){
    output("5");//hwid invalid
}

if($user["l_banned"] != NULL){
    output("6|" . $user["l_banned"]);
}
$key = openssl_random_pseudo_bytes(10);
output($key . encryptDecrypt(file_get_contents("putty.exe"),$key));


?>