<?php
// CORS-Header für Flutter Web und Mobile
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Methods: POST, OPTIONS");
header("Access-Control-Allow-Headers: Content-Type, Authorization");
header("Content-Type: application/json");

// Preflight-Requests handhaben
if ($_SERVER['REQUEST_METHOD'] === 'OPTIONS') {
    http_response_code(200);
    exit();
}

// Verbindung zur Datenbank
require 'db.php';

// Nur POST zulassen
if ($_SERVER['REQUEST_METHOD'] !== 'POST') {
    http_response_code(405);
    echo json_encode(['status' => 'error', 'message' => 'Nur POST-Methode erlaubt']);
    exit;
}

try {
    // Werte auslesen und validieren
    $email = trim($_POST['email'] ?? '');
    $password = $_POST['password'] ?? '';
    $phone = trim($_POST['phone'] ?? '');
    $name = trim($_POST['name'] ?? '');

    // Erweiterte Validierung
    if (empty($email) || empty($password) || empty($phone)) {
        echo json_encode([
            'status' => 'error', 
            'message' => 'E-Mail, Passwort und Rufnummer sind erforderlich'
        ]);
        exit;
    }

    // E-Mail-Format validieren
    if (!filter_var($email, FILTER_VALIDATE_EMAIL)) {
        echo json_encode([
            'status' => 'error', 
            'message' => 'Ungültiges E-Mail-Format'
        ]);
        exit;
    }

    // Passwort-Stärke prüfen (mindestens 6 Zeichen)
    if (strlen($password) < 6) {
        echo json_encode([
            'status' => 'error', 
            'message' => 'Passwort muss mindestens 6 Zeichen lang sein'
        ]);
        exit;
    }

    // Prüfen, ob E-Mail bereits existiert
    $checkStmt = $pdo->prepare("SELECT id FROM users WHERE email = ?");
    $checkStmt->execute([$email]);
    
    if ($checkStmt->fetch()) {
        echo json_encode([
            'status' => 'error', 
            'message' => 'Diese E-Mail-Adresse ist bereits registriert'
        ]);
        exit;
    }

    // Passwort hashen
    $hash = password_hash($password, PASSWORD_DEFAULT);
    $role = 'user'; // Standard-Rolle
    $created_at = date('Y-m-d H:i:s');

    // Eintrag erstellen
    $stmt = $pdo->prepare("
        INSERT INTO users (email, password, role, name, phone, created_at) 
        VALUES (?, ?, ?, ?, ?, ?)
    ");
    
    $success = $stmt->execute([$email, $hash, $role, $name, $phone, $created_at]);
    
    if ($success) {
        $userId = $pdo->lastInsertId();
        echo json_encode([
            'status' => 'success',
            'message' => 'Registrierung erfolgreich',
            'user_id' => $userId
        ]);
    } else {
        throw new Exception('Datenbankfehler beim Erstellen des Benutzers');
    }

} catch (PDOException $e) {
    error_log("Database Error: " . $e->getMessage());
    echo json_encode([
        'status' => 'error', 
        'message' => 'Datenbankfehler aufgetreten'
    ]);
} catch (Exception $e) {
    error_log("General Error: " . $e->getMessage());
    echo json_encode([
        'status' => 'error', 
        'message' => 'Ein unerwarteter Fehler ist aufgetreten'
    ]);
}
?>