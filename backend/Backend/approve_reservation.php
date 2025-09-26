<?php
require __DIR__.'/db.php';
header('Content-Type: application/json; charset=utf-8');

/*
  Aufruf-Varianten:
  - POST: id, action=approve|reject, approved_by=email@domain
*/
$in = $_POST ?: json_decode(file_get_contents('php://input'), true);
$id  = (int)($in['id'] ?? 0);
$act = $in['action'] ?? '';
$by  = trim($in['approved_by'] ?? '');

if(!$id || !in_array($act, ['approve','reject'])){
  echo json_encode(['status'=>'error','message'=>'id oder action fehlt']); exit;
}

try{
  // Reservation + Slot holen
  $q = $pdo->prepare("SELECT r.reservation_id, r.status, s.slot_id, s.is_booked
                      FROM reservation r JOIN appointment_slot s ON s.slot_id=r.slot_id
                      WHERE r.reservation_id=? FOR UPDATE");
  $pdo->beginTransaction();
  $q->execute([$id]);
  $row = $q->fetch(PDO::FETCH_ASSOC);
  if(!$row){ $pdo->rollBack(); echo json_encode(['status'=>'error','message'=>'Reservierung nicht gefunden']); exit; }
  if($row['status']!=='pending'){ $pdo->rollBack(); echo json_encode(['status'=>'error','message'=>'Bereits: '.$row['status']]); exit; }

  if($act==='approve'){
    // Status setzen + Slot blockieren
    $u1=$pdo->prepare("UPDATE reservation SET status='approved', approved_by=? WHERE reservation_id=?");
    $u1->execute([$by, $id]);
    $u2=$pdo->prepare("UPDATE appointment_slot SET is_booked=1 WHERE slot_id=?");
    $u2->execute([$row['slot_id']]);
  } else {
    $u1=$pdo->prepare("UPDATE reservation SET status='rejected', approved_by=? WHERE reservation_id=?");
    $u1->execute([$by, $id]);
    // Slot bleibt frei
  }

  $pdo->commit();
  echo json_encode(['status'=>'success','new_status'=>$act==='approve'?'approved':'rejected']);
}catch(Throwable $e){
  if($pdo->inTransaction()) $pdo->rollBack();
  echo json_encode(['status'=>'error','message'=>$e->getMessage()]);
}
