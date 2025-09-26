<?php
require __DIR__.'/db.php';
header('Content-Type: application/json; charset=utf-8');

$sql = "SELECT u.id, u.name, u.email, u.phone, 
               bp.bio, bp.location, bp.image 
        FROM users u 
        LEFT JOIN barber_profile bp ON u.id = bp.barber_id 
        WHERE u.role = 'barber' 
        ORDER BY u.name";

$st = $pdo->prepare($sql);
$st->execute();
$barbers = $st->fetchAll(PDO::FETCH_ASSOC);

echo json_encode(['status' => 'success', 'barbers' => $barbers]);
?>