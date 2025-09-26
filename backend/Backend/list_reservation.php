<?php
require __DIR__.'/db.php';
header('Content-Type: application/json; charset=utf-8');

$userId   = isset($_GET['user_id'])   ? (int)$_GET['user_id']   : null; // Kunde
$barberId = isset($_GET['barber_id']) ? (int)$_GET['barber_id'] : null; // Friseur
$status   = $_GET['status'] ?? null;                                   // pending/approved/...
$from     = $_GET['from']   ?? null;                                   // YYYY-MM-DD
$to       = $_GET['to']     ?? null;

$sql="SELECT r.*, s.date_time, s.duration_min,
             u.name AS customer_name, u.email AS customer_email, u.phone AS phone
      FROM reservation r
      JOIN appointment_slot s ON s.slot_id=r.slot_id
      JOIN users u ON u.id=r.user_id
      WHERE 1=1";
$p=[];
if($userId){   $sql.=" AND r.user_id=?";   $p[]=$userId; }
if($barberId){ $sql.=" AND s.barber_id=?"; $p[]=$barberId; }
if($status){   $sql.=" AND r.status=?";    $p[]=$status; }
if($from){     $sql.=" AND DATE(s.date_time)>=?"; $p[]=$from; }
if($to){       $sql.=" AND DATE(s.date_time)<=?"; $p[]=$to; }
$sql.=" ORDER BY s.date_time";

$st=$pdo->prepare($sql);
$st->execute($p);
echo json_encode(['status'=>'success','items'=>$st->fetchAll(PDO::FETCH_ASSOC)]);
