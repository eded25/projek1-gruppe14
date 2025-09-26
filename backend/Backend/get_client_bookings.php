<?php
header('Content-Type: application/json');
header('Access-Control-Allow-Origin: *');
header('Access-Control-Allow-Methods: GET, POST, OPTIONS');
header('Access-Control-Allow-Headers: Content-Type');

$host = 'localhost';
$dbname = 'barber_app';
$username = 'root';
$password = '';

try {
    $pdo = new PDO("mysql:host=$host;dbname=$dbname", $username, $password);
    $pdo->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
    
    // Client ID aus GET Parameter oder POST
    $client_id = $_GET['client_id'] ?? $_POST['client_id'] ?? null;
    
    if (!$client_id) {
        echo json_encode([
            'status' => 'error',
            'message' => 'Client ID required'
        ]);
        exit;
    }
    
    // Hole alle Buchungen für den Client
    $stmt = $pdo->prepare("
        SELECT 
            r.id,
            r.appointment_date,
            r.appointment_time,
            r.status,
            r.total_price,
            r.created_at,
            b.name as barber_name,
            b.id as barber_id,
            GROUP_CONCAT(s.name SEPARATOR ', ') as services
        FROM reservations r
        LEFT JOIN users b ON r.barber_id = b.id
        LEFT JOIN reservation_services rs ON r.id = rs.reservation_id  
        LEFT JOIN services s ON rs.service_id = s.id
        WHERE r.client_id = ?
        GROUP BY r.id
        ORDER BY r.appointment_date DESC, r.appointment_time DESC
    ");
    
    $stmt->execute([$client_id]);
    $bookings = $stmt->fetchAll(PDO::FETCH_ASSOC);
    
    // Formatiere die Daten für die App
    $formattedBookings = [];
    foreach ($bookings as $booking) {
        $formattedBookings[] = [
            'id' => $booking['id'],
            'barber_name' => $booking['barber_name'] ?? 'Unknown',
            'barber_id' => $booking['barber_id'],
            'date' => $booking['appointment_date'],
            'time' => $booking['appointment_time'],
            'status' => $booking['status'],
            'price' => floatval($booking['total_price']),
            'services' => $booking['services'] ?? 'Cut',
            'created_at' => $booking['created_at']
        ];
    }
    
    echo json_encode([
        'status' => 'success',
        'bookings' => $formattedBookings,
        'count' => count($formattedBookings)
    ]);
    
} catch(PDOException $e) {
    echo json_encode([
        'status' => 'error', 
        'message' => 'Database error: ' . $e->getMessage()
    ]);
}
?>