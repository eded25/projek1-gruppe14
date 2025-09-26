<?php
require __DIR__.'/db.php';
header('Content-Type: application/json; charset=utf-8');

$in = $_POST ?: json_decode(file_get_contents('php://input'), true);
$userId = (int)($in['user_id'] ?? 0);
$slotId = (int)($in['slot_id'] ?? 0);
$pay    = trim($in['payment_method'] ?? '');

if(!$userId || !$slotId){
  echo json_encode(['status'=>'error','message'=>'user_id oder slot_id fehlt']); exit;
}

try {
  // Slot prüfen
  $st = $pdo->prepare("SELECT slot_id, barber_id, date_time, duration_min, is_booked FROM appointment_slot WHERE slot_id=?");
  $st->execute([$slotId]);
  $slot = $st->fetch(PDO::FETCH_ASSOC);
  if(!$slot){ echo json_encode(['status'=>'error','message'=>'Slot nicht gefunden']); exit; }
  if((int)$slot['is_booked'] === 1){
    echo json_encode(['status'=>'error','message'=>'Slot bereits belegt']); exit;
  }

  // Reservierung anlegen (pending)
  $ins = $pdo->prepare("INSERT INTO reservation(user_id, slot_id, status, payment_method) VALUES (?,?, 'pending', ?)");
  $ins->execute([$userId, $slotId, $pay]);

  echo json_encode(['status'=>'success','reservation_id'=>$pdo->lastInsertId()]);
} catch(Throwable $e){
  echo json_encode(['status'=>'error','message'=>$e->getMessage()]);
}
