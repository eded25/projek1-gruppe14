<?php
// 🟢 Error Reporting aktivieren für Debugging
error_reporting(E_ALL);
ini_set('display_errors', 1);
ini_set('log_errors', 1);
ini_set('error_log', '/Applications/MAMP/logs/php_error.log');

// Datenbank-Konfiguration
$host = 'localhost';
$db = 'thmCUT';
$user = 'root';
$pass = 'root'; 

try {
    // PDO-Verbindung mit zusätzlichen Optionen
    $pdo = new PDO("mysql:host=$host;dbname=$db;charset=utf8", $user, $pass);
    
    // 🟢 PDO Error Mode auf Exception setzen, zeigt detaillierte Fehler
    $pdo->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
    
    // 🟢 UTF-8 Encoding sicherstellen
    $pdo->setAttribute(PDO::MYSQL_ATTR_INIT_COMMAND, "SET NAMES utf8");
    
    // 🟢 Bestätigung dass DB-Verbindung funktioniert (nur für Debugging)
    // echo "<!-- DB Connection OK -->";
    
} catch (PDOException $e) {
    // 🟢 Detaillierte Fehlermeldung mit mehr Infos
    $error_msg = "Verbindung fehlgeschlagen: " . $e->getMessage();
    
    // 🟢 Fehler in Log-Datei schreiben
    error_log("Database Connection Error: " . $error_msg);
    
    // 🟢 Nutzerfreundliche Fehlermeldung
    die(json_encode([
        'status' => 'error',
        'message' => 'Datenbankverbindung fehlgeschlagen',
        'debug' => $error_msg
    ]));
}
?>