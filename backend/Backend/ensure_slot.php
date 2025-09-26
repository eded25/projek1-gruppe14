<?php
require __DIR__.'/db.php';
header('Content-Type: application/json; charset=utf-8');

$in = $_POST ?: json_decode(file_get_contents('php://input'), true);
$barberId = (int)($in['barber_id'] ?? 0);
$dateTime = trim($in['date_time'] ?? '');     // 'YYYY-MM-DD HH:MM:SS'
$duration = (int)($in['duration_min'] ?? 30);

if(!$barberId || !$dateTime){
  echo json_encode(['status'=>'error','message'=>'barber_id oder date_time fehlt']); exit;
}

try {
  // gibt es den Slot bereits?
  $st = $pdo->prepare("SELECT slot_id, is_booked FROM appointment_slot WHERE barber_id=? AND date_time=?");
  $st->execute([$barberId, $dateTime]);
  $row = $st->fetch(PDO::FETCH_ASSOC);

  if($row){
    if((int)$row['is_booked'] === 1){
      echo json_encode(['status'=>'error','message'=>'Slot bereits belegt']); exit;
    }
    echo json_encode(['status'=>'success','slot_id'=>$row['slot_id']]); exit;
  }

  // sonst neu anlegen
  $ins = $pdo->prepare("INSERT INTO appointment_slot (barber_id, date_time, duration_min, is_booked) VALUES (?,?,?,0)");
  $ins->execute([$barberId, $dateTime, $duration]);
  echo json_encode(['status'=>'success','slot_id'=>$pdo->lastInsertId()]);
} catch(Throwable $e){
  echo json_encode(['status'=>'error','message'=>$e->getMessage()]);
}
