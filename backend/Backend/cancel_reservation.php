<?php
require __DIR__.'/db.php';
header('Content-Type: application/json; charset=utf-8');

$in = $_POST ?: json_decode(file_get_contents('php://input'), true);
$id  = (int)($in['id'] ?? 0);
if(!$id){ echo json_encode(['status'=>'error','message'=>'id fehlt']); exit; }

try{
  // Wenn approved -> Slot wieder freigeben
  $q=$pdo->prepare("SELECT r.status, r.slot_id FROM reservation r WHERE r.reservation_id=?");
  $q->execute([$id]); $r=$q->fetch(PDO::FETCH_ASSOC);
  if(!$r){ echo json_encode(['status'=>'error','message'=>'Reservierung nicht gefunden']); exit; }

  $pdo->beginTransaction();
  $pdo->prepare("UPDATE reservation SET status='cancelled' WHERE reservation_id=?")->execute([$id]);
  if($r['status']==='approved'){
    $pdo->prepare("UPDATE appointment_slot SET is_booked=0 WHERE slot_id=?")->execute([$r['slot_id']]);
  }
  $pdo->commit();
  echo json_encode(['status'=>'success']);
}catch(Throwable $e){
  if($pdo->inTransaction()) $pdo->rollBack();
  echo json_encode(['status'=>'error','message'=>$e->getMessage()]);
}
