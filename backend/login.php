<?php
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Methods: POST");
header("Access-Control-Allow-Headers: Content-Type");

error_reporting(E_ALL);
ini_set('display_errors', 1);

require 'db.php';

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $email = $_POST['email'] ?? '';
    $password = $_POST['password'] ?? '';

    // E-Mail prüfen
    $stmt = $pdo->prepare("SELECT * FROM users WHERE email = ?");
    $stmt->execute([$email]);
    $user = $stmt->fetch();

    // Passwort prüfen
    if ($user && password_verify($password, $user['password'])) {
        echo json_encode([
            'status' => 'success',
            'user_id' => $user['id'],
            'role' => $user['role'],
            'name' => $user['name'],
            'email' => $user['email'],
            'phone' => $user['phone']
        ]);
    } else {
        echo json_encode([
            'status' => 'error',
            'message' => 'Ungültige E-Mail oder Passwort'
        ]);
    }
}
?>
